-- change the database to dwh_postgres
\c dwh_postgres;
CREATE SCHEMA dwh;
CREATE TABLE dwh.flights (
	flight_id serial4 NOT NULL,
	flight_no bpchar(6) NOT NULL,
	scheduled_departure timestamptz NOT NULL,
	scheduled_arrival timestamptz NOT NULL,
	departure_airport bpchar(3) NOT NULL,
	arrival_airport bpchar(3) NOT NULL,
	status varchar(20) NOT NULL,
	aircraft_code bpchar(3) NOT NULL,
	actual_departure timestamptz NULL,
	actual_arrival timestamptz NULL,
    load_dt timestamptz NOT NULL);

CREATE TABLE dwh.seats (
	aircraft_code bpchar(3) NOT NULL,
	seat_no varchar(4) NOT NULL,
	fare_conditions varchar(10) NOT NULL,
    load_dt timestamptz NOT NULL);