-- database name must not be in uppercase
-- if BD exists, this skript does not work
CREATE DATABASE source_db;
GRANT ALL PRIVILEGES ON DATABASE source_db TO dwh_postgres;
-- change the database to source_db
\c source_db;
CREATE SCHEMA source_schema;
CREATE TABLE source_schema.flights (
	flight_id serial4 NOT NULL,
	flight_no bpchar(6) NOT NULL,
	scheduled_departure timestamptz NOT NULL,
	scheduled_arrival timestamptz NOT NULL,
	departure_airport bpchar(3) NOT NULL,
	arrival_airport bpchar(3) NOT NULL,
	status varchar(20) NOT NULL,
	aircraft_code bpchar(3) NOT NULL,
	actual_departure timestamptz NULL,
	actual_arrival timestamptz NULL);

CREATE TABLE source_schema.seats (
	aircraft_code bpchar(3) NOT NULL,
	seat_no varchar(4) NOT NULL,
	fare_conditions varchar(10) NOT NULL);