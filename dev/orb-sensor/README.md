# Orb.net Sensor

## Docker Compose:

1. Run `docker compose up -d`, then link to your account with:

    ```bash
    podman exec -it orb-sensor /app/orb link
    ```

2. Click on the link to connect.


## Podman Quadlet

1. Create the following file: `/etc/containers/systemd/orb-sensor.container`

    ```container
    [Unit]
    Description=Orb Sensor

    [Container]
    Image=docker.io/orbforge/orb:latest
    ContainerName=orb-sensor
    Network=host
    Volume=/home/admin/orb:/root/.config/orb:Z
    AutoUpdate=registry

    [Service]
    Restart=unless-stopped
    TimeoutStartSec=900

    [Install]
    WantedBy=multi-user.target default.target
    ```

2. Start the container:

    ```bash
    mkdir -p /home/admin/orb/
    systemctl daemon-reload
    systemctl start orb-sensor
    ```

    > **NOTE:** Troubleshoot with: `/usr/lib/systemd/system-generators/podman-system-generator --dryrun`

3. Enable auto updates:

    ```bash
    systemctl enable --now podman-auto-update.timer
    podman auto-update --dry-run
    ```
    
    > **NOTE:** You only need to enable the timer (`podman-auto-update.timer`), not the service (`podman-auto-update.service`).

    > **NOTE:** By default, the timer runs the podman-auto-update.service daily at midnight.

3. Link to your account:

    ```bash
    podman exec -it orb-sensor /app/orb link
    ```

4. Click on the link to connect.