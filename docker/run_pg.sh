#! /bin/bash

# Use whichever container runtime this machine has (podman on acropolis, docker on arrakis).
CTR=$(command -v podman || command -v docker) || { echo "no container runtime found" >&2; exit 1; }

"$CTR" run --name pg --rm -e POSTGRES_PASSWORD=password -p 5432:5432 -v pgdata:/var/lib/postgresql/data -d postgis/postgis:17-3.5
