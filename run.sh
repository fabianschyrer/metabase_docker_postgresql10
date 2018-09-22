# Create Docker Volumes
docker volume create --driver local --name=metabase-pgvol
docker volume create --driver local --name=metabase-pglogvol

# Create Docker Network
docker network create --driver bridge --subnet 172.0.0.0/29 metabase-network &>/dev/null || :

# Run Docker container
docker run --publish 5432:5432 \
  --volume=metabase-pgvol:/var/lib/postgresql/data \
  --volume=metabase-pglogvol:/var/log \
  -v "$PWD/pg_config/postgresql.conf":/etc/postgresql/postgresql.conf \
  -v "$PWD/pg_config/pg_hba.conf":/etc/postgresql/pg_hba.conf \
  --name="postgres-metabase" \
  --hostname="postgres-metabase" \
  --network="metabase-network" \
  --env-file=pg-env.list \
   --detach \
   <DOCKER_REGISTRY>/metabase.docker.postgres:latest \
    -c 'config_file=/etc/postgresql/postgresql.conf' \
  	-c 'hba_file=/etc/postgresql/pg_hba.conf'



