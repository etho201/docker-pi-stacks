# Force the ActionCable Redis pub/sub listener to start at boot so broadcasts
# relay to WebSocket clients even before the first client connects.
#
# Without this, the listener starts lazily on the first WS subscription. That
# makes the container healthcheck (which looks for the listener's
# '_action_cable_internal' Redis subscription) fail during idle periods and
# causes autoheal to restart chatwoot-rails in a loop.
#
# Guarded so a failure here can never prevent the app from booting. If it does
# fail we log an ERROR (not just a warning): the app keeps running and the
# listener will still start lazily when the first client connects, but while
# idle the healthcheck can false-positive — so the failure must be visible in
# the logs to explain any autoheal restarts.
Rails.application.config.after_initialize do
  begin
    ActionCable.server.pubsub.subscribe('chatwoot_boot_stream', ->(*) {})
    Rails.logger.info('actioncable_boot: ActionCable listener pre-started')
  rescue StandardError => e
    Rails.logger.error(
      "actioncable_boot: FAILED to pre-start ActionCable listener " \
      "(#{e.class}: #{e.message}). The healthcheck may false-positive while idle " \
      "until a client connects and lazily starts the listener."
    )
  end
end
