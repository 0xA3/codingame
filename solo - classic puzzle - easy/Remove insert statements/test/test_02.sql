8
CREATE TABLE acheteur (
    id character integer NOT NULL,
    date_creation timestamp without time zone,
    name text,
    id_createur character varying(32),
    amount double precision,
);
--insert into acheteur(id,date_creation, name, id_createur, amount) values(1,'12/08/2020','John',1,100);