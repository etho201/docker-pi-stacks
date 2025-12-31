# Upgrading the database in Teslamate:

1. Set variable for your data mounts:
	```bash
	TESLAMATE_DB_VOLUME=/data/docker/volume/teslamate/db
	```
	> **NOTE:** This is fairly generic in that my `/var/lib/postgresql/data` is mounted at `/data/docker/volume/teslamate/db`, so set the variable to wherever you keep your data mounted.

2. Create a backup of the database:
	```bash
    mkdir ${TESLAMATE_DB_VOLUME}/backup/
	docker exec teslamate-db /bin/bash -c '/usr/bin/pg_dump -Fc -U teslamate teslamate' > ${TESLAMATE_DB_VOLUME}/backup/backup.dump
	docker kill teslamate teslamate-db
	```

3. At this point, move the mounted directory to some place else. For example:
	```bash
	mv ${TESLAMATE_DB_VOLUME} ${TESLAMATE_DB_VOLUME}-pg16
	```

4. Update the Postgres version in the docker-compose.yml file. Example:
	```bash
	teslamate-db:
	  image: postgres:18
	```
	> **NOTE:** Reference the docker install guide [here](https://docs.teslamate.org/docs/installation/docker) file to find the latest tested database version.
    > **NOTE:** Check here for general guidance on upgrading the database: https://docs.teslamate.org/docs/maintenance/upgrading_postgres/
	
5. Run the new image and allow the file structure to be created
	```bash
	docker compose up -d --force-recreate
	```
	> **NOTE:** Wait until the Teslamate web application is accessible in the browser.
	
6. Once the database is up and ready to accept connections (you can check this by viewing the logs) and you are able to nagivate to the Teslamate web application, copy the `backup.dump` file into the new volume mount, and import the database from the backup you created in step 1.
	```bash
	cp ${TESLAMATE_DB_VOLUME}-pg16/backup/backup.dump ${TESLAMATE_DB_VOLUME}/backup/
	docker exec teslamate-db pg_restore --clean -U postgres -d teslamate /var/lib/postgresql/data/backup/backup.dump
	```
	
7. You're now finished with your database upgrade. At this point, it's a good idea to restart your Teslamate docker compose enrionment with `docker compose up -d --force-recreate` to purge out any excess RAM usage left behind from the database upgrade.