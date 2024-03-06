# ownCloud OCIS

1. OCIS is still being developed, so if changes to the `ocis.yaml` file take place upstream, but not for your server, you may need to generate a new file:

2. Initialize the `ocis.yaml` file to see what's new.

    ```bash
    docker run --rm -it -v $(pwd):/etc/ocis/ owncloud/ocis:latest init
    ```

3. Move the `ocis.yaml` file to the mounted location. Example:

    ```bash
    mv ocis.yaml /media/docker/config/owncloud/ocis.yaml.bak
    ```

4. To recover your old accounts and files, simply merge everything from the deltas from the `ocis.yaml.bak` file into your exisitng `ocis.yaml` file.

5. Reboot ownCloud after updating the ocis.yaml file.