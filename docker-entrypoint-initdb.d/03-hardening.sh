#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	REVOKE CREATE ON SCHEMA public FROM PUBLIC;
    CREATE SCHEMA my_new_public AUTHORIZATION postgres;
	SET search_path TO ascend,public;
	GRANT INSERT, UPDATE, DELETE, SELECT ON ALL TABLES IN SCHEMA my_new_public TO metabase;
	GRANT INSERT, UPDATE, DELETE, SELECT ON ALL TABLES IN SCHEMA my_new_public TO postgres;
	GRANT CREATE, CONNECT, TEMPORARY, TEMP ON DATABASE metabase TO metabase;
EOSQL
