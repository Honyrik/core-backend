--liquibase formatted sql
--changeset patcher-core:Page_182033F620954FD3B4052BE7CBFD4071 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
select pkg_patcher.p_remove_page('182033F620954FD3B4052BE7CBFD4071');

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('182033F620954FD3B4052BE7CBFD4071', 'EFFC1868B5804AABAAF7EE516BD24952', 2, 'fd0b2b0f99cf4423bb2a3bd0284548f4', 20, 0, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-10T14:58:23.082+0000', 0) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('9EF41CDCDF284DD0BCFCCFD51B320237', '182033F620954FD3B4052BE7CBFD4071', 'edit', 99999, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-10T14:58:23.082+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('9CE8C6C3C8164F74BFAB24124863D473', '182033F620954FD3B4052BE7CBFD4071', 'view', 99999, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T18:58:22.857+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_object('2491A10BC0604CDAB122F43A0E396F2E', '1EE230968D8648419A9FEF0AAF7390E7', null, 'SYS Application - Promo', 10, null, 'Приложение Promo', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-05T14:35:29.434+0000');
select pkg_patcher.p_merge_object('313CA48BDEF94CB7A76537E7DAB0572F', '1807D17438814B31B75A279C4CBC6C0C', '2491A10BC0604CDAB122F43A0E396F2E', 'App Bar Promo', 10, null, 'App Bar Promo', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-05T14:36:33.831+0000');
select pkg_patcher.p_merge_object('5FD02A0DA5F344A6BAC3B2E995765281', '0DDBEE01777844F5AC8F129EB5A43118', '2491A10BC0604CDAB122F43A0E396F2E', 'Promo', 20, null, 'Promo', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T09:07:05.005+0000');
select pkg_patcher.p_merge_object('83E97BE579434D03A92C51CBADB35C86', 'DF451F5CC0A54F8791C4DFAC12DAE42E', '2491A10BC0604CDAB122F43A0E396F2E', 'Profile Drawer', 120, null, 'Profile Drawer', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T14:08:51.400+0000');
select pkg_patcher.p_merge_object('79AAB1A792CC44F5BC994101AF166BF1', '4457', '313CA48BDEF94CB7A76537E7DAB0572F', 'Empty Space App Bar', 10, null, 'Empty Space App Bar', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-05T14:36:58.431+0000');
select pkg_patcher.p_merge_object('0631A84F42044FCA915D4CB4CBE42D72', '2BB74480D7E2455B97AED5B3A070FE35', '83E97BE579434D03A92C51CBADB35C86', 'Theme', 10, null, 'Theme', 'eb5f0456bee64d60ba3560e6f7a9f332', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T14:08:57.273+0000');
select pkg_patcher.p_merge_object('A97A899D290D44E0BBF0D0A2980D25C5', 'DB557A6113634FD2BC40D2A58EE1EB3F', '313CA48BDEF94CB7A76537E7DAB0572F', 'Button Group Right', 20, null, 'Button Group Right', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-05T14:38:09.134+0000');
select pkg_patcher.p_merge_object('9E56968D23B54F76999B44FB699EC380', '19', 'A97A899D290D44E0BBF0D0A2980D25C5', 'Button Profile', 50, null, 'Профиль', 'e571d8599bc8466aac42ade8b1891e44', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T14:07:28.869+0000');
select pkg_patcher.p_merge_object('51370A5B19FF49AFA52276D38113856B', '19', 'A97A899D290D44E0BBF0D0A2980D25C5', 'Button github', 80, null, 'Button github', '67209b3397fe48368477aeda7bb2e397', null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T14:28:31.826+0000');
select pkg_patcher.p_merge_object('080A4280BE994B798E6B57497C469179', '19', 'A97A899D290D44E0BBF0D0A2980D25C5', 'Button Auth', 100, null, 'Button Auth', null, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T14:07:12.652+0000');
select pkg_patcher.p_merge_object_attr('37587321212A43D4B831CA2C24737F5D', '79AAB1A792CC44F5BC994101AF166BF1', '26169', '100%', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-05T14:37:19.938+0000', 'width');
select pkg_patcher.p_merge_object_attr('65184D51FBAF4299863D964B00BF42CD', '79AAB1A792CC44F5BC994101AF166BF1', '5DEE50EEE8144BD9A2FA58D9B2D3CA57', '45px', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-05T14:37:16.095+0000', 'height');
select pkg_patcher.p_merge_object_attr('96F66A22731F4337B4EF9B6CA375476A', '313CA48BDEF94CB7A76537E7DAB0572F', '5F01393A5D014FF3A017C1D3F840D8E2', '45px', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T13:57:28.053+0000', 'height');
select pkg_patcher.p_merge_object_attr('75531554477F4A0A9340CF7430D1539C', '9E56968D23B54F76999B44FB699EC380', '1033', 'profile', '-1', '2020-06-09T14:04:44.293+0000', 'ckwindow');
select pkg_patcher.p_merge_object_attr('9AA86529DA0F44019EE3B27296273FA2', '9E56968D23B54F76999B44FB699EC380', '140', 'onWindowOpen', '-1', '2020-06-09T14:04:44.293+0000', 'handler');
select pkg_patcher.p_merge_object_attr('F9269A42455743D3BE4C1444AD992903', '9E56968D23B54F76999B44FB699EC380', '1695', 'true', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T14:10:09.304+0000', 'onlyicon');
select pkg_patcher.p_merge_object_attr('FD516FD4D0AF4E0F90822A4FD4A11A6F', '9E56968D23B54F76999B44FB699EC380', '992', 'user', '-1', '2020-06-09T14:04:44.293+0000', 'iconfont');
select pkg_patcher.p_merge_object_attr('4EABF2F33B184CC688C007D803D348F9', '51370A5B19FF49AFA52276D38113856B', '24169', '"//github.com/essence-community/core"', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T15:38:38.149+0000', 'redirecturl');
select pkg_patcher.p_merge_object_attr('82C99E05C8FB4CAF8EA69E3376963515', '51370A5B19FF49AFA52276D38113856B', '992', 'github', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T13:58:27.004+0000', 'iconfont');
select pkg_patcher.p_merge_object_attr('8AF115F71DAB47A8975C0870DE5CCE35', '080A4280BE994B798E6B57497C469179', '1695', 'true', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T13:55:22.140+0000', 'onlyicon');
select pkg_patcher.p_merge_object_attr('92B923C7A6FC4CAC8B28A3EAFDD98F2A', '080A4280BE994B798E6B57497C469179', '24169', 'g_sess_session ? "redirect/pages" : "redirect/auth"', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-10T14:16:42.191+0000', 'redirecturl');
select pkg_patcher.p_merge_object_attr('4BDDF039B5964CBAAB0CD122D39DE70C', '080A4280BE994B798E6B57497C469179', '992', 'sign-in', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T13:55:04.658+0000', 'iconfont');
select pkg_patcher.p_merge_object_attr('C509EC77FE0142A39C0429B5D9D9A996', '83E97BE579434D03A92C51CBADB35C86', '6145FC24CDCD49EE97C24B1A7AF17C19', '100px', '-1', '2020-06-09T14:08:15.876+0000', 'height');
select pkg_patcher.p_merge_object_attr('7D7EB827EF06414CB50ACD21C8732F4C', '83E97BE579434D03A92C51CBADB35C86', 'EC07783AE2E8459EBE2E6772E439D782', 'profile', '-1', '2020-06-09T14:08:15.876+0000', 'ckwindow');
select pkg_patcher.p_merge_object_attr('9B4F3BCAD47F4707ADA9163663F268DB', '83E97BE579434D03A92C51CBADB35C86', 'FF9AC3D8E746481687532056DAB095AB', 'right', '-1', '2020-06-09T14:08:15.876+0000', 'align');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('955785099DB7440D862B8BECF84FD267', '182033F620954FD3B4052BE7CBFD4071', '2491A10BC0604CDAB122F43A0E396F2E', 10, null, null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-10T15:00:52.953+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C4209233A8C3456AA5016BAF2041750F', '182033F620954FD3B4052BE7CBFD4071', '313CA48BDEF94CB7A76537E7DAB0572F', 10, '955785099DB7440D862B8BECF84FD267', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T09:17:06.345+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('BACFF5A76D9C4EB99E9C753FA3FB9530', '182033F620954FD3B4052BE7CBFD4071', '5FD02A0DA5F344A6BAC3B2E995765281', 20, '955785099DB7440D862B8BECF84FD267', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T09:17:06.345+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('15E54E263C51445298E903ED92483985', '182033F620954FD3B4052BE7CBFD4071', '83E97BE579434D03A92C51CBADB35C86', 120, '955785099DB7440D862B8BECF84FD267', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T09:17:06.345+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('A7F1F99EE165488C9CCE6FA0BC6531D9', '182033F620954FD3B4052BE7CBFD4071', '79AAB1A792CC44F5BC994101AF166BF1', 10, 'C4209233A8C3456AA5016BAF2041750F', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T09:17:06.345+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('ABC08B6C8BEB46A48B3D5898B0BF8949', '182033F620954FD3B4052BE7CBFD4071', '0631A84F42044FCA915D4CB4CBE42D72', 10, '15E54E263C51445298E903ED92483985', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T09:17:06.345+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('B117C7B74F8945409B92BEB1C7288516', '182033F620954FD3B4052BE7CBFD4071', 'A97A899D290D44E0BBF0D0A2980D25C5', 20, 'C4209233A8C3456AA5016BAF2041750F', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T09:17:06.345+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('713AA96C15F545B79DCC0AA055254905', '182033F620954FD3B4052BE7CBFD4071', '9E56968D23B54F76999B44FB699EC380', 50, 'B117C7B74F8945409B92BEB1C7288516', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T15:32:35.319+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('C600CDE4CD384D3EAA8E603FA3BFBB8A', '182033F620954FD3B4052BE7CBFD4071', '51370A5B19FF49AFA52276D38113856B', 80, 'B117C7B74F8945409B92BEB1C7288516', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T09:17:06.345+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('F6CC0AFEFF0B40B4A99CE9E49532E482', '182033F620954FD3B4052BE7CBFD4071', '080A4280BE994B798E6B57497C469179', 100, 'B117C7B74F8945409B92BEB1C7288516', null, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-09T09:17:06.345+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_page_object_attr('433836D6C9E64EA3971E1A9E72E013CB', '955785099DB7440D862B8BECF84FD267', 'B4952B6F8DA34BEFB04D244268B674F1', 'cv_url === "promo" && g_sys_show_promo === "true"', '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-06-10T12:21:40.565+0000', 'activerules');
update s_mt.t_page_object set ck_master='955785099DB7440D862B8BECF84FD267' where ck_id='713AA96C15F545B79DCC0AA055254905';
INSERT INTO s_mt.t_localization (ck_id, ck_d_lang, cr_namespace, cv_value, ck_user, ct_change)
select t.ck_id, t.ck_d_lang, t.cr_namespace, t.cv_value, t.ck_user, t.ct_change::timestamp from (
    select 'e571d8599bc8466aac42ade8b1891e44' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Профиль' as cv_value, '-11' as ck_user, '2019-12-10T00:00:00.000+0000' as ct_change
    union all
    select 'eb5f0456bee64d60ba3560e6f7a9f332' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Тема' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-01-30T00:00:00.000+0000' as ct_change
    union all
    select 'fd0b2b0f99cf4423bb2a3bd0284548f4' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'Promo' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-09T08:41:47.712+0000' as ct_change
    union all
    select '67209b3397fe48368477aeda7bb2e397' as ck_id, 'ru_RU' as ck_d_lang, 'meta' as cr_namespace, 'GitHub' as cv_value, '4fd05ca9-3a9e-4d66-82df-886dfa082113' as ck_user, '2020-06-09T14:28:31.826+0000' as ct_change
) as t 
 join s_mt.t_d_lang dl
 on t.ck_d_lang = dl.ck_id
on conflict on constraint cin_u_localization_1 do update set ck_id = excluded.ck_id, ck_d_lang = excluded.ck_d_lang, cr_namespace = excluded.cr_namespace, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
