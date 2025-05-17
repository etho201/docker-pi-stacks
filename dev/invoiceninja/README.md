# Deploy

1. Prepare the folder structure and permissions before running `docker compose up`. Run the following as the root user:

    ```bash
    DOCKER_VOLUME=/data/docker/volume
    mkdir -p ${DOCKER_VOLUME}/invoiceninja/{storage,public}
    chown -R 1500:1500 ${DOCKER_VOLUME}/invoiceninja/{storage,public}
    ```

2. Run `docker compose up`

    ```bash
    docker compose up -d
    ```