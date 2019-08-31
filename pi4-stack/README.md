To launch all the containers:
```
docker-compose up -d
```

To launch an individual container, specify the service (for example: Lidarr):
```
docker-compose up -d lidarr
```

To launch multiple containers, separate the services with spaces (for example: db1 and nextcloud):
```
docker-compose up -d db1 nextcloud
```
