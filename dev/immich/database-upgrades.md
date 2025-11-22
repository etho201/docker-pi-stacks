# Upgrading the database in Immich:

1. Set variable for your data mounts:
	```bash
	IMMICH_DB_VOLUME=/data/docker/volume/immich/db
	```
	> **NOTE:** This is fairly generic in that my `/var/lib/postgresql/data` is mounted at `/data/docker/volume/immich/db`, so set the variable to wherever you keep your data mounted.

2. Create a backup of the database:
	```bash
	docker exec immich-db /bin/bash -c '/usr/bin/pg_dump -Fc -U postgres immich' > ${IMMICH_DB_VOLUME}/backup.dump
	docker kill immich-server immich-db immich-machine-learning immich-redis
	```

3. At this point, move the mounted directory to some place else. For example:
	```bash
	mv ${IMMICH_DB_VOLUME} ${IMMICH_DB_VOLUME}-pg14
	```

4. Update the Postgres version in the docker-compose.yml file. Example:
	```bash
	immich-db:
	  image: ghcr.io/immich-app/postgres:17-vectorchord0.5.3
	```
	> **NOTE:** Reference the sample [docker-compose.yml](https://github.com/immich-app/immich/blob/main/docker/docker-compose.yml) file to find the latest tested database version.
    > **NOTE:** Check here for all supported database versions: https://docs.immich.app/administration/postgres-standalone/
	
5. Run the new image and allow the file structure to be created
	```bash
	docker compose up -d --force-recreate
	```
	> **NOTE:** Wait until the Immich web application is accessible in the browser.
	
6. Once the database is up and ready to accept connections (you can check this by viewing the logs) and you are able to nagivate to the Immich web application, copy the `backup.dump` file into the new volume mount, and import the database from the backup you created in step 1.
	```bash
	cp ${IMMICH_DB_VOLUME}-pg14/backup.dump ${IMMICH_DB_VOLUME}/
	docker exec immich-db pg_restore --clean -U postgres -d immich /var/lib/postgresql/data/backup.dump
	```
	
7. You're now finished with your database upgrade.