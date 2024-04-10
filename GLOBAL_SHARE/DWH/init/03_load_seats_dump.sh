# load data into the database from dump
current_dump="source_seats_dump.sql"
psql -c 'SET search_path TO source_db;' -U dwh_postgres -d source_db  -f /var/lib/postgresql/dumps/$current_dump