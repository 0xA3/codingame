CREATE TABLE acheteur (
    id character integer NOT NULL,
    date_creation timestamp without time zone,
    name text,
    id_createur character varying(32),
    amount double precision,
);
CREATE TABLE benchmark.prestataire (
    id integer NOT NULL,
    name text,
	insert_date_string_format text
);