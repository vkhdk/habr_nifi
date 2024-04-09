# load data into the database from dump
current_dump="example_dump.sql"
psql -c 'SET search_path TO dwh;' -U dwh_postgres -d dwh_postgres  -f /var/lib/postgresql/dumps/$current_dump