# ownCloud OCIS configuration with Pocket-ID

The Client IDs and secrets are hardcoded in the ownCloud applications. You can find these values [here](https://doc.owncloud.com/server/10.15/admin_manual/configuration/user/oidc/oidc.html#client-ids-secrets-and-redirect-uris).

As a workaround, you need to create OIDC Clients for each, and then manually specify the client ID and secrets that ownCloud expects them to be.

1. Install sqlite into the `pocket-id` container so you can modify the database entries:


    ```bash
    cd path-to-pocket-id-compose-file

    docker compose exec pocket-id apk add sqlite
    docker compose exec pocket-id sqlite3

    # EXAMPLE (see below for more details):
    # docker compose exec pocket-id sqlite3 /app/data/pocket-id.db "UPDATE oidc_clients SET id='owncloud-client-id', secret='owncloud-client-secret-bcrypt-hashed' WHERE id='current-client-id';"
    ```

    * Replace `owncloud-client-id` with the desired client ID.
    * Replace `owncloud-client-secret-bcrypt-hashed` with the bcrypt-hashed version of the client secret you want to use. To generate this hash, visit https://bcrypt-generator.com/, input your client secret, and use the resulting hash (replace the `$`'s with backslashes).
    * Replace `current-client-id` with the client ID of the existing client you want to update.

2. Obtain the client ID for each entry, and run the following command so the client can authenticate. Replace `current-client-id` with the client ID of the existing client you want to update.

    - Desktop Client
        ```bash
        docker compose exec pocket-id sqlite3 /app/data/pocket-id.db "UPDATE oidc_clients SET id='xdXOt13JKxym1B1QcEncf2XDkLAexMBFwiT9j6EfhhHFJhs2KM9jbjTmf8JBXE69', secret='\$2a\$12\$HbbJMheIYyo8yfEuvm8Boe0baMZTIDXzchpVdLsfPqc3Eb.oULn5W' WHERE id='current-client-id';"
        ```
        > Callback URL: `http://127.0.0.1`

    - Android

        ```bash
        docker compose exec pocket-id sqlite3 /app/data/pocket-id.db "UPDATE oidc_clients SET id='e4rAsNUSIUs0lF4nbv9FmCeUkTlV9GdgTLDH1b5uie7syb90SzEVrbN7HIpmWJeD', secret='\$2a\$12\$sdQWjAxlQzRojU3bhvxp/e/5aY/tzskKqD76AQpiBJpj7USgWhZUO' WHERE id='current-client-id';"
        ```
        > Callback URL: `oc://android.owncloud.com`

    - iOS:

        ```bash
        docker compose exec pocket-id sqlite3 /app/data/pocket-id.db "UPDATE oidc_clients SET id='mxd5OQDk6es5LzOzRvidJNfXLUZS2oN3oUFeXPP8LpPrhx3UroJFduGEYIBOxkY1', secret='\$2a\$12\$3qHWSJRKBVoHVrn7kp4NFuEN4r.wmh9zB8oRjtYwHBUzwM818Hhje' WHERE id='current-client-id';"
        ```
        > Callback URL: `oc://ios.owncloud.com`

3. You can verify the changes with:

    ```bash
    docker compose exec pocket-id sqlite3 /app/data/pocket-id.db "SELECT * FROM oidc_clients;"
    ```