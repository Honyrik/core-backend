--liquibase formatted sql
--changeset artemov_i:MTClassAttrPlacementList.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id, cc_query, ck_provider, ck_user, ct_change, cr_type, cr_access, cn_action, cv_description) VALUES ('MTClassAttrPlacementList', '/*MTClassAttrPlacementList*/

select ca.ck_id,

       ca.ck_attr         

  from s_mt.t_class_attr ca

  join s_mt.t_attr a on a.ck_id = ca.ck_attr and a.ck_attr_type = ''placement''

 where ca.ck_class = (cast(:json as jsonb)->''master''->>''ck_id'')::varchar

   /*##filter.ck_id*/and ca.ck_id = (cast(:json as jsonb)->''filter''->>''ck_id'')::varchar/*filter.ck_id##*/

 order by ca.ck_attr asc

  ', 'meta', '20783', '2019-05-27 09:20:25.164918+03', 'select', 'po_session', NULL, 'Необходимо актуализировать')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access;

