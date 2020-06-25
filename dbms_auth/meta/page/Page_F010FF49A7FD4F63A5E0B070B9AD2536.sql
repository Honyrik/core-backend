--liquibase formatted sql
--changeset patcher-core:Page_F010FF49A7FD4F63A5E0B070B9AD2536 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
select pkg_patcher.p_remove_page('F010FF49A7FD4F63A5E0B070B9AD2536');

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('F010FF49A7FD4F63A5E0B070B9AD2536', '6230F0855D6648C9A0CDBE62ED1B1811', 2, 'f1a1eb4ad55d4442998925c3b86b410d', 40, 0, null, '9', '1', '2019-08-21T00:00:00.000+0000', 1) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('E6CC3AF8398B4F2D805056BF5A2847B1', 'F010FF49A7FD4F63A5E0B070B9AD2536', 'edit', 516, '1', '2019-08-13T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('DF7AC7FA76A04C5AA5FDD45694DE9A8E', 'F010FF49A7FD4F63A5E0B070B9AD2536', 'view', 516, '1', '2019-08-13T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_object('84B647F9150D49E9885516F0E42C9924', '8', null, 'Account Info << DO NOT CHANGE', 1000050, 'AuthShowParamsInfo', 'Справочник дополнительных полей пользователя', null, 'pkg_json_account.f_modify_d_info', 'authcore', '1', '2019-08-13T00:00:00.000+0000');
select pkg_patcher.p_merge_object('80E0095F45F147FAA4346817D61B3330', '19', '84B647F9150D49E9885516F0E42C9924', 'Add button', 1, null, 'Добавление', '122d20300ab34c02b78bd1d3945e5eeb', null, null, '1', '2019-08-13T00:00:00.000+0000');
select pkg_patcher.p_merge_object('3FC29653D85045F288BC226EC4BF5391', '16', '84B647F9150D49E9885516F0E42C9924', 'Edit button column', 10, null, 'Редактирование', null, null, null, '1', '2019-08-13T00:00:00.000+0000');
select pkg_patcher.p_merge_object('80C9BDAAF21E4C86B7EE2FA631634515', '9', '84B647F9150D49E9885516F0E42C9924', 'ck_id', 20, null, 'Наименование', 'e0cd88534f90436da2b3b5eeae0ae340', null, null, '1', '2019-08-13T00:00:00.000+0000');
select pkg_patcher.p_merge_object('8DF1348FE48541E8904AA866BF61FCAB', '9', '84B647F9150D49E9885516F0E42C9924', 'cv_description', 30, null, 'Описание', 'a4b1d1f3995f499a8f2bac5b57a3cbdc', null, null, '1', '2019-08-13T00:00:00.000+0000');
select pkg_patcher.p_merge_object('F9B7026B559443418DFDEEE8BA86BA74', '9', '84B647F9150D49E9885516F0E42C9924', 'cr_type', 40, null, 'Тип данных', 'b5cf4acf63fd47ef9c8484f62a8efdf2', null, null, '1', '2019-08-13T00:00:00.000+0000');
select pkg_patcher.p_merge_object('66E0D5CA49E3493687F5FF114C3639E6', '36', '84B647F9150D49E9885516F0E42C9924', 'cl_required', 50, null, 'Признак обязательного поля', 'e706e3ec3e4343cfa00d6c624e703a8e', null, null, '1', '2019-08-13T00:00:00.000+0000');
select pkg_patcher.p_merge_object('5BC3300778424F4688361496AFBEBFB5', '31', 'F9B7026B559443418DFDEEE8BA86BA74', 'cr_type combo', 1, 'AuthShowParamsInfoType', 'Список типов', '58c6c7fc17f24ef88b62dcdb03584381', null, null, '1', '2019-08-13T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('0A3D37F5DA2F4403854A5A8D4ED23CB2', '5BC3300778424F4688361496AFBEBFB5', '120', 'cr_type', '1', '2019-08-13T00:00:00.000+0000', 'column');
select pkg_patcher.p_merge_object_attr('C2D07E19EF47419CAA98753526D9FC55', '5BC3300778424F4688361496AFBEBFB5', '123', 'true', '1', '2019-08-13T00:00:00.000+0000', 'required');
select pkg_patcher.p_merge_object_attr('98F6C14AE94644CAB63498A7BE7980DC', '5BC3300778424F4688361496AFBEBFB5', '125', 'ck_id', '1', '2019-08-13T00:00:00.000+0000', 'displayfield');
select pkg_patcher.p_merge_object_attr('3B18320A1EE14E809A8628A817281A7D', '5BC3300778424F4688361496AFBEBFB5', '126', '[{"in": "ck_id", "out": null}]', '1', '2019-08-13T00:00:00.000+0000', 'valuefield');
select pkg_patcher.p_merge_object_attr('3811C912DA9F42A58FCA5D4C3F3DD3D9', '80E0095F45F147FAA4346817D61B3330', '155', '1', '1', '2019-08-13T00:00:00.000+0000', 'mode');
select pkg_patcher.p_merge_object_attr('600814E4F5CF4AF38381F3712810B76F', '84B647F9150D49E9885516F0E42C9924', '852', 'ck_id', '1', '2019-08-13T00:00:00.000+0000', 'orderproperty');
select pkg_patcher.p_merge_object_attr('00B1B75147B64D2799F6C0B9ECC61E6B', '84B647F9150D49E9885516F0E42C9924', '853', 'ASC', '1', '2019-08-13T00:00:00.000+0000', 'orderdirection');
select pkg_patcher.p_merge_object_attr('F70CB50DA478470999C38178FC7BC01B', '5BC3300778424F4688361496AFBEBFB5', '870', 'text', '1', '2019-08-13T00:00:00.000+0000', 'defaultvalue');
select pkg_patcher.p_merge_object_attr('02CE8960AD40466DBB1A57763CF6784C', '80E0095F45F147FAA4346817D61B3330', '992', 'plus', '1', '2019-08-21T00:00:00.000+0000', 'iconfont');
select pkg_patcher.p_merge_object_attr('BE15C3D5ACE14DC98F8654820F777C91', '3FC29653D85045F288BC226EC4BF5391', '1493', null, '1', '2019-08-13T00:00:00.000+0000', 'ckwindow');
select pkg_patcher.p_merge_object_attr('ED1A834598D44E64A4471A5101EB4C13', '80C9BDAAF21E4C86B7EE2FA631634515', '433', 'insert', '1', '2019-08-13T00:00:00.000+0000', 'editmode');
select pkg_patcher.p_merge_object_attr('FB15AADBE9E849B8ADB58E84206368EC', '80C9BDAAF21E4C86B7EE2FA631634515', '453', 'true', '1', '2019-08-13T00:00:00.000+0000', 'required');
select pkg_patcher.p_merge_object_attr('6864790BF2334A7F88307988C855D885', '80C9BDAAF21E4C86B7EE2FA631634515', '47', 'ck_id', '1', '2019-08-13T00:00:00.000+0000', 'column');
select pkg_patcher.p_merge_object_attr('4C28ABEC6DD94C5682B242C15305FE7A', '8DF1348FE48541E8904AA866BF61FCAB', '453', 'true', '1', '2019-08-13T00:00:00.000+0000', 'required');
select pkg_patcher.p_merge_object_attr('ABB3D2243C60435A963469CDA7192EE0', '8DF1348FE48541E8904AA866BF61FCAB', '47', 'cv_description', '1', '2019-08-13T00:00:00.000+0000', 'column');
select pkg_patcher.p_merge_object_attr('D5A8DB8C1A4541E7BD0FC8E29B757C2A', 'F9B7026B559443418DFDEEE8BA86BA74', '47', 'cr_type', '1', '2019-08-13T00:00:00.000+0000', 'column');
select pkg_patcher.p_merge_object_attr('A0ED5E17791242ADB00685AD11DA1BCB', '66E0D5CA49E3493687F5FF114C3639E6', '250', 'cl_required', '1', '2019-08-13T00:00:00.000+0000', 'column');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('CDC36350A6FD44419FE5E08BDAC7BCBA', 'F010FF49A7FD4F63A5E0B070B9AD2536', '84B647F9150D49E9885516F0E42C9924', 1, null, null, '1', '2019-08-13T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('A965F522BF28477BAC6C72E1B9D3171F', 'F010FF49A7FD4F63A5E0B070B9AD2536', '80E0095F45F147FAA4346817D61B3330', 1, 'CDC36350A6FD44419FE5E08BDAC7BCBA', null, '1', '2019-08-13T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('4534BE1786E24326A31891EFFEB40840', 'F010FF49A7FD4F63A5E0B070B9AD2536', '3FC29653D85045F288BC226EC4BF5391', 10, 'CDC36350A6FD44419FE5E08BDAC7BCBA', null, '1', '2019-08-13T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('3DD36CD0AFFC4391A7C5A25B4CB4E671', 'F010FF49A7FD4F63A5E0B070B9AD2536', '80C9BDAAF21E4C86B7EE2FA631634515', 20, 'CDC36350A6FD44419FE5E08BDAC7BCBA', null, '1', '2019-08-13T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('B7AB1316F9D54A74851204470EE3DAD2', 'F010FF49A7FD4F63A5E0B070B9AD2536', '8DF1348FE48541E8904AA866BF61FCAB', 30, 'CDC36350A6FD44419FE5E08BDAC7BCBA', null, '1', '2019-08-13T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('4C68AC286E1D40AA887BF84BA9CD448F', 'F010FF49A7FD4F63A5E0B070B9AD2536', 'F9B7026B559443418DFDEEE8BA86BA74', 40, 'CDC36350A6FD44419FE5E08BDAC7BCBA', null, '1', '2019-08-13T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('6A477647ECBD44049EAE48387A72BD42', 'F010FF49A7FD4F63A5E0B070B9AD2536', '66E0D5CA49E3493687F5FF114C3639E6', 50, 'CDC36350A6FD44419FE5E08BDAC7BCBA', null, '1', '2019-08-13T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('BBE140819EC24ED0A09C94C370AAD9E3', 'F010FF49A7FD4F63A5E0B070B9AD2536', '5BC3300778424F4688361496AFBEBFB5', 1, '4C68AC286E1D40AA887BF84BA9CD448F', null, '1', '2019-08-13T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
select t.ck_id, t.ck_d_lang, t.cr_namespace, t.cv_value, t.ck_user, t.ct_change::timestamp from (
    select '58c6c7fc17f24ef88b62dcdb03584381' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Список типов' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select 'b5cf4acf63fd47ef9c8484f62a8efdf2' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Тип данных' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select 'd0ad23ef13f8493e996cfca8a98d0721' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Редактировать значение' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select 'e706e3ec3e4343cfa00d6c624e703a8e' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Признак обязательного поля' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select 'f1a1eb4ad55d4442998925c3b86b410d' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Справочник дополнительных данных пользователя' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select '122d20300ab34c02b78bd1d3945e5eeb' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Добавить' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-25T00:00:00.000+0000' as ct_change
    union all
    select 'a4b1d1f3995f499a8f2bac5b57a3cbdc' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Описание' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-26T00:00:00.000+0000' as ct_change
    union all
    select 'e0cd88534f90436da2b3b5eeae0ae340' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Наименование' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2019-12-26T00:00:00.000+0000' as ct_change
) as t 
 join s_mt.t_d_lang dl
 on t.ck_d_lang = dl.ck_id
on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
