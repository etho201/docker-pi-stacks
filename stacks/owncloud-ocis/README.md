# ownCloud OCIS

1. OCIS is still being developed, so if changes to the `ocis.yaml` file take place upstream, but not for your server, you may need to generate a new file and/or add environment variables that are missing. Check the [release notes](https://doc.owncloud.com/ocis_release_notes.html) for any breaking changes before upgrading.

2. Initialize the `ocis.yaml` file to see what's new.

    ```bash
    docker run --rm -it -v $(pwd):/etc/ocis/ owncloud/ocis:latest
    ```

3. Check for new entries required in the `ocis.yaml` file. This can be done using the ocis cli:

    ```bash
    cd /etc/ocis
    ocis init --diff
    ```

4. To recover your old accounts and files, simply merge everything from the deltas between the old and new configuration.

    ```bash
    patch < ocis.config.patch
    ```

5. Update the ocis version in your `compose.yaml` file and recreate the container.

---

## Troubleshooting:


### Unexpected HTTP response: 500

1. If you try to login to OwnCloud and receive the error: "**Unexpected HTTP response: 500. Please check your connection and try again.**" This is probably due to an expired cert. You can confirm this by viewing the logs (may need to put the logging into `DEBUG` mode to see).
2. Within the logs, you may see issues such as:
    ```bash
    "ldap identifier backend logon connect error: LDAP Result Code 200 \"Network Error\": tls: failed to verify certificate: x509: certificate has expired or is not yet valid: current time 2025-03-25T20:51:42Z is after 2025-03-24T19:07:03Z"

    "remote error: tls: bad certificate"
	```
3. To fix this, kill the `owncloud` container. Then navigate to the `idm` directory and rename the `ldap.crt` and `ldap.key` files.
    ```bash
    cd ${VOLUME_DIR}/owncloud/idm
    mv ldap.crt ldap.crt.bak
    mv ldap.key ldap.key.bak
    ```
4. Recreate owncloud
    ```bash
    docker compose up -d --force-recreate
    ```
5. Check if you can login, and if so, go ahead and delete the old `ldap` (`*.bak`) files as they're no longer needed.

### Upload fails with "Unknown Error"

- Uploads of files over 100MB seem to fail with status 404 and unknown error.
- Cloudflare's free tier may limit uploads to 100MB. If using Cloudflare, disable the proxy for the specific DNS entry (owncloud.${FQDN}).
- This could be resolved by adjusting the `FRONTEND_UPLOAD_MAX_CHUNK_SIZE` value in `ocis.yaml`
    - https://doc.owncloud.com/ocis/next/deployment/services/s-list/frontend.html

---

## Environment Variables:
- https://doc.owncloud.com/ocis/next/deployment/services/s-list/search.html


