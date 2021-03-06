--liquibase formatted sql
--changeset artemov_i:AuthShowParamsInfo.sql dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_query (ck_id,cc_query,ck_provider,ck_user,ct_change,cr_type,cr_access,cv_description)
VALUES ('AuthShowParamsInfo','/*AuthShowParamsInfo*/
select ck_id, cv_description, cr_type, cl_required, ck_user, ct_change at time zone :sess_cv_timezone as ct_change
from t_d_info
where true
/*##filter.ck_id*/
   and ck_id = :json::json#>>''{filter,ck_id}''/*filter.ck_id##*/
','authcore','-11','2019-08-13 18:30:00.000','select','po_session','Список дополнительных атрибутов')
on conflict (ck_id) do update set cc_query = excluded.cc_query, ck_provider = excluded.ck_provider, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cr_type = excluded.cr_type, cr_access = excluded.cr_access, cv_description = excluded.cv_description;
