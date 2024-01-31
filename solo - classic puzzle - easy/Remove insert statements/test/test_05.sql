16
CREATE TABLE acheteur (
    id character integer NOT NULL,
    date_creation timestamp without time zone,
    name text,
    id_createur character varying(32),
    amount double precision,
);
insert into acheteur(id,date_creation, name, id_createur, amount) values(1,'12/08/2020','John',1,100);
Insert INTO benchmark.ticket VALUES (62, 21805, 51, 'SI Quality model empty', '2020-02-12 00:00:00');
INSeRt INTO benchmark.snapshot VALUES (1615, 11, 79, '2019-11-18 13:51:20.2641', NULL, '2019-10-22 01:00:00', 1715, 5594, 3909, 0, 0, 0, 0, 3.16, 3.08, 3.22, 3.18, 3.41, 3.70, 3.25, '8.3.12.1', 'v2.5.8', 1, 15, 0, 0, 685,  'ETAT1 - v2.5.8 - dev - aip1 - e', 0);
iNSERT INTO benchmark.ticket VALUES (61, 21798, 1, 'false positive for "Avoid unreferenced Classes", due to FacesConverter annotation (21739 suite)', '2020-02-12 00:00:00');-- premier comment OK OK
INSERT INTO benchmark.snapshot VALUES (500044, 26, 68, '2014-10-17 00:03:00', 0, '2014-10-17 00:03:00', 1247000, '7.3.0', 'V1.c7 (730 migrées)', 3, 1, 0, 0, 1145, 1145,  14, 194, 4136, 54947, 22, 142, 467, 3765, 0.004, 0.316, 6.9043, 92.6, 0.5, 3.2, 10.612, 85.65);
INSERT INTO benchmark.snapshot VALUES (1170, 3, 429, '2019-02-04 00:00:00', NULL, '2019-01-16', 743428, 272, 9, 64, 3585, 1355, 7256, 3.16, 2.991, 2.91, 2.19, 3.14, 3.14, 2.956, '8.3.8.1', 'v6.0.0_reprise', 3, 0, 0, 0, 954, 1, 213, 2213,  309, 823, 1.23, '23 - v6.0 poids 0');
INSERT INTO benchmark.ref_metric VALUES (1007248, 'Use sufficient SSL\TLS context (PHP)', 'TQI', 1, 'NOT CRITICAL', NULL);--petit comment qu'il faut garder
INSERT INTO benchmark.snapshot VALUES (750000, 4, 489, '2013-11-06 00:00:00', 0, '2013-11-06 00:00:00', 134674, 63542, 300698, 0, 0, 0, 0, 3.22, 3.31, 2.77, 3.5, 2.640012, 2.087, 2.95, '7.0.19.1', 'Partage V1.2 + lib',0);
INSERT INTO benchmark.snapshot VALUES (8, 9, 780, '2022-06-29 13:49:11.8066', NULL, '2022-06-29 12:08:00', 400598, 210702, 68729, 0, 0, 0, 0, 3.27, 2.93, 3.27, 2.74, 3.64, 2.79, 3.02, '8.3.30.1', 'V3.1', 1, 12, 'exde 175 PA à la demande du projet', 6, 269, 275, 'backup.zip');