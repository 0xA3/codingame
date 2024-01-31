29
--
-- TOC entry 49331 (class 1255 OID 11620988)
-- Name: fs_insertcheckmarxactionplan(integer, integer, integer, text);
--
CREATE FUNCTION benchmark.fs_insertcheckmarxactionplan(nb_object integer, pmetric_id integer, id_snapshot integer, status text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	v_metric_id integer;
begin 
	v_metric_id := 0;
    set search_path=benchmark;
    Select metric_id into v_metric_id from ref_metric rm where rm.metric_id = pMetric_id;
    insert into action_plan(nb_object, id_metric, comment_action, id_snapshot, status, id_outil) values ( nb_object, v_metric_id, 'N/A', id_snapshot, status, 2);
return 1;
end;
$$;
--
-- TOC entry 182322 (class 0 OID 11621003)
-- Dependencies: 16626
-- Data for Name: action_plan; Type: TABLE DATA; Schema: benchmark; Owner: -
--
INSERT INTO benchmark.action_plan VALUES (8911, 1, 1, 1, 1020810, 'PRESTATAIRE', 1166, 'NEW', 1);
INSERT INTO benchmark.action_plan VALUES (100000, 1, 1, 129, 7788, 'PRESTATAIRE', 100001, 'STILL_VIOLATION', 1);
INSERT INTO benchmark.action_plan VALUES (100001, 1, 1, 109, 8106, 'PRESTATAIRE', 100001, 'STILL_VIOLATION', 1);
INSERT INTO benchmark.action_plan VALUES (100002, 2, 1, 37, 7670, 'PRESTATAIRE', 100001, 'STILL_VIOLATION', 1);
INSERT INTO benchmark.action_plan VALUES (100003, 2, 1, 49, 7518, 'PRESTATAIRE', 100001, 'STILL_VIOLATION', 1);
INSERT INTO benchmark.action_plan VALUES (100004, 2, 1, 6, 7532, 'PRESTATAIRE', 100001, 'STILL_VIOLATION', 1);
-- END Batch