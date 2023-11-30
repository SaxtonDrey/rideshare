#!/bin/bash

PGPASSWORD=postgres docker exec -it db01 \
  psql -U postgres -c \
  "REASSIGN OWNED BY replication_user TO postgres;"
PGPASSWORD=postgres docker exec -it db01 \
  psql -U postgres -c \
  "DROP OWNED BY replication_user;"

# Drop slots
# - my_subscription
# - rideshare_slot
PGPASSWORD=postgres docker exec -it db01 \
  psql -U postgres -c \
  "SELECT pg_drop_replication_slot('my_subscription');"
PGPASSWORD=postgres docker exec -it db01 \
  psql -U postgres -c \
  "SELECT pg_drop_replication_slot('rideshare_slot');"

docker exec -it db01 \
  psql -U postgres \
  -c "DROP USER IF EXISTS replication_user"
