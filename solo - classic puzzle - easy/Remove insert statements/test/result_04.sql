CREATE FUNCTION benchmark.fs_insertcheckmarxactionplan(pid_app integer, nb_object integer, pmetric_id integer, id_snapshot integer, status text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
	v_metric_id integer;
begin 
	v_metric_id := 0;
    set search_path=benchmark;
    Select metric_id into v_metric_id from ref_metric rm where rm.metric_id = pMetric_id;
    insert into action_plan(id_application, nb_object, id_metric, comment_action, id_snapshot, status, id_outil) values ( pid_app, nb_object, v_metric_id, 'N/A', id_snapshot, status, 2);
return 1;
end;