#! /bin/bash

podman run --name pg -e POSTGRES_PASSWORD=password -p 5432:5432 -v pgdata:/var/lib/postgresql/data -d postgis/postgis:17-3.4
