CREATE TABLE vendeur (
    id character integer NOT NULL,
    date_creation timestamp without time zone,
    name text,
    id_createur character varying(32),
    amount double precision,
);