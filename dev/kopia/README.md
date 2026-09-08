# To create policies programmatically:

**NOTE:** Refer to the [policy set](https://kopia.io/docs/reference/command-line/common/policy-set/) command line documentation for more details.

## Creating a policy:

```bash
APP=immich
SOURCE_PATH=/data/docker/volume/immich/db/backup

kopia policy set ${SOURCE_PATH} \
    --snapshot-interval=0 \
    --snapshot-time-crontab="40 */2 * * *" \
    --compression=zstd \
    --before-snapshot-root-action=/home/erik/documents/git/backup-strategy/kopia/${APP}-before.sh \
    --after-snapshot-root-action=/home/erik/documents/git/backup-strategy/kopia/${APP}-after.sh

```

## Editing a policy:

```bash
kopia policy set /data/docker/volume/joplin-data/backup \
    --before-snapshot-root-action=/home/erik/documents/git/backup-strategy/kopia/joplin-before.sh \
    --after-snapshot-root-action=/home/erik/documents/git/backup-strategy/kopia/joplin-after.sh
```

---

{
    "retention": {},
    "files": {},
    "errorHandling": {},
    "scheduling": {
        "intervalSeconds": 10800
    },
    "compression": {
        "compressorName": "zstd"
    },
    "metadataCompression": {},
    "splitter": {},
    "actions": {
        "beforeSnapshotRoot": {
            "script": "/home/erik/documents/git/backup-strategy/kopia/pre-joplin.sh",
            "timeout": 300
        },
        "afterSnapshotRoot": {
            "script": "/home/erik/documents/git/backup-strategy/kopia/post-joplin.sh",
            "timeout": 300,
            "mode": "essential"
        }
    },
    "osSnapshots": {
        "volumeShadowCopy": {}
    },
    "logging": {
        "directories": {},
        "entries": {}
    },
    "upload": {}
}