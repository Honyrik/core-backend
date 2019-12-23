--liquibase formatted sql
--changeset patcher-core:Page_5868BCACDD034DFF9DC9B0C3170CB720 dbms:postgresql runOnChange:true splitStatements:false stripComments:false
select pkg_patcher.p_remove_page('5868BCACDD034DFF9DC9B0C3170CB720');

INSERT INTO s_mt.t_page (ck_id, ck_parent, cr_type, cv_name, cn_order, cl_static, cv_url, ck_icon, ck_user, ct_change, cl_menu)VALUES('5868BCACDD034DFF9DC9B0C3170CB720', '6230F0855D6648C9A0CDBE62ED1B1811', 2, 'ae1b949d62474f46a1ec976fdd735030', 10, 0, null, '438', '1', '2019-07-04T00:00:00.000+0000', 1) on conflict (ck_id) do update set ck_parent = excluded.ck_parent, cr_type = excluded.cr_type, cv_name = excluded.cv_name, cn_order = excluded.cn_order, cl_static = excluded.cl_static, cv_url = excluded.cv_url, ck_icon = excluded.ck_icon, ck_user = excluded.ck_user, ct_change = excluded.ct_change, cl_menu = excluded.cl_menu;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('72D3A2BD212B4C11BE799F1BCA6E5E06', '5868BCACDD034DFF9DC9B0C3170CB720', 'edit', 516, '1', '2019-07-03T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_action (ck_id, ck_page, cr_type, cn_action, ck_user, ct_change)VALUES('714037478C4143CD804883EA496975EC', '5868BCACDD034DFF9DC9B0C3170CB720', 'view', 515, '1', '2019-07-03T00:00:00.000+0000') on conflict (ck_id) do update set ck_page = excluded.ck_page, cr_type = excluded.cr_type, cn_action = excluded.cn_action, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
select pkg_patcher.p_merge_object('4F5D25DB7DF4494CA7095C69C67A8CEB', '35', null, 'Action Tabs << DO NOT CHANGE', 1000010, null, 'Action Tabs', null, null, null, '1', '2019-08-13T00:00:00.000+0000');
select pkg_patcher.p_merge_object('956DC9B6D34842CDA613285C25A3C1D2', '8', null, 'Action Grid << DO NOT CHANGE', 1000020, 'AuthShowAction', 'Справочник действий', null, 'pkg_json_account.f_modify_action', 'authcore', '1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object('9BE87355051B48C39EB9AF15F50B24A1', '58', '956DC9B6D34842CDA613285C25A3C1D2', 'Filter', 5, null, 'Filter', null, null, null, '1', '2019-07-03T00:00:00.000+0000');
select pkg_patcher.p_merge_object('48C32AF385F64A3EA301E2BAEE3B396E', '19', '956DC9B6D34842CDA613285C25A3C1D2', 'Add Button', 10, null, 'Добавить', '3a5239ee97d9464c9c4143c18fda9815', null, null, '1', '2019-07-03T00:00:00.000+0000');
select pkg_patcher.p_merge_object('5879C913B8BA462EA26E5553B3E8D874', '8', '4F5D25DB7DF4494CA7095C69C67A8CEB', 'Roles Grid', 10, 'AuthShowSelectedRoleAction', 'Справочник ролей', '7444bf57e2044a2cb3fd266398ff7371', null, null, '1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object('231CDD084F0C409EAAE14B6415B5E1C8', '16', '956DC9B6D34842CDA613285C25A3C1D2', 'Edit Button', 15, null, 'Edit Button', null, null, null, '1', '2019-07-03T00:00:00.000+0000');
select pkg_patcher.p_merge_object('A60489F21EB84EDF8AFCA3E390342B96', '77', '956DC9B6D34842CDA613285C25A3C1D2', 'cn_action', 20, null, 'Код действия', '3755233db59d4305861c327dab09f8b0', null, null, '1', '2019-07-03T00:00:00.000+0000');
select pkg_patcher.p_merge_object('CCB0712056BF4CC2A11404E82193FAD9', '9', '956DC9B6D34842CDA613285C25A3C1D2', 'cv_name', 40, null, 'Наименование', '3a0b8d771a0d497e8aa1c44255fa6e83', null, null, '1', '2019-07-03T00:00:00.000+0000');
select pkg_patcher.p_merge_object('F3CA568B9B1948439CF82324850F69F3', '9', '956DC9B6D34842CDA613285C25A3C1D2', 'cv_description', 50, null, 'Описание', '900d174d0a994374a01b0005756521bc', null, null, '1', '2019-07-03T00:00:00.000+0000');
select pkg_patcher.p_merge_object('4EBEA143E0A44269B8F6453B5BC2CFD6', '27', '9BE87355051B48C39EB9AF15F50B24A1', 'cn_action', 10, null, 'cn_action', '3755233db59d4305861c327dab09f8b0', null, null, '1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object('2890F3943D934AF4829E5F9EE8E0CA41', '26', '9BE87355051B48C39EB9AF15F50B24A1', 'cv_name', 20, null, 'Наименование', '3a0b8d771a0d497e8aa1c44255fa6e83', null, null, '1', '2019-07-03T00:00:00.000+0000');
select pkg_patcher.p_merge_object('55951E1D952845F9B0099C0DF3757E05', '9', '5879C913B8BA462EA26E5553B3E8D874', 'cv_name', 40, null, 'cv_name', '3a0b8d771a0d497e8aa1c44255fa6e83', null, null, '1', '2019-07-04T00:00:00.000+0000');
select pkg_patcher.p_merge_object('C343BA92C0ED4E298A782EBB30C1F3DD', '9', '5879C913B8BA462EA26E5553B3E8D874', 'cv_description', 50, null, 'cv_description', '900d174d0a994374a01b0005756521bc', null, null, '1', '2019-07-04T00:00:00.000+0000');
select pkg_patcher.p_merge_object('C9B9CED565D04CB7A37259231E315B1E', '32', '5879C913B8BA462EA26E5553B3E8D874', 'Settings Window', 150, null, 'Settings Window', 'd0de4c458cbe41aab061c96b5e7301fb', null, null, '1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object('FA5A40E6315844A087A99338C050D616', '19', '5879C913B8BA462EA26E5553B3E8D874', 'Settings Button', 250, null, 'Settings Button', '270f59f23c734ae6b47cd0f24db2abfc', null, null, '1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object('5E5245E846AC4AD695CAC04FB57AAF40', '317', 'C9B9CED565D04CB7A37259231E315B1E', 'Field Item Selector', 10, null, 'Field Item Selector', null, 'pkg_json_account.f_modify_action_role', 'authcore', '1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object('7AB6267772BF488480E0443B7CBD647A', '19', 'C9B9CED565D04CB7A37259231E315B1E', 'Close Button', 20, null, 'Close Button', '1711e8b1d1d949be913b12a878ba0482', null, null, '1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object('5AD2E6DDF8EC47138D6A65A159F6F7F4', '8', '5E5245E846AC4AD695CAC04FB57AAF40', 'Roles Grid', 10, 'AuthShowAvailableRoleAction', 'Доступные роли', '2b19abe7224749beb18fb2bcee339556', null, null, '1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object('A1D1FE7951D54A408A9C54B282E731CB', '8', '5E5245E846AC4AD695CAC04FB57AAF40', 'Roles Grid', 20, 'AuthShowSelectedRoleAction', 'Выбранные роли', '5b12d684f3624f0b918a93ff98a57be2', null, null, '1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object('E221AE08EEA049068ECBA29A3106EF0E', '9', '5AD2E6DDF8EC47138D6A65A159F6F7F4', 'cv_name', 40, null, 'cv_name', '3a0b8d771a0d497e8aa1c44255fa6e83', null, null, '1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object('1A881454BF0340C386E2176F8B5EF59A', '9', 'A1D1FE7951D54A408A9C54B282E731CB', 'cv_name', 40, null, 'cv_name', '3a0b8d771a0d497e8aa1c44255fa6e83', null, null, '1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object('85E24E152C884021A61E975F2E267F24', '9', 'A1D1FE7951D54A408A9C54B282E731CB', 'cv_description', 50, null, 'cv_description', '900d174d0a994374a01b0005756521bc', null, null, '1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object('043BDA853E3A4C60821946A95FF30901', '9', '5AD2E6DDF8EC47138D6A65A159F6F7F4', 'cv_description', 50, null, 'cv_description', '900d174d0a994374a01b0005756521bc', null, null, '1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('4A284115DD40456BB1C49A6624562612', '4EBEA143E0A44269B8F6453B5BC2CFD6', '1434', '20%', '1', '2019-07-03T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('D9EFD5E74EDB46C2BE9CAB0FE562A871', '5879C913B8BA462EA26E5553B3E8D874', '1491', 'true', '1', '2019-08-15T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1C832939FD5B41059BA73436FF18214A', '48C32AF385F64A3EA301E2BAEE3B396E', '155', '1', '1', '2019-07-03T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('F0A8E36E72C24E698EE0AF763A6AB87A', '5879C913B8BA462EA26E5553B3E8D874', '1643', 'false', '1', '2019-07-07T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('00779B713BBA46649BF128EDB90CCC78', '5879C913B8BA462EA26E5553B3E8D874', '401', '15', '-1', '2019-07-04T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('F3F09D3AD1AD4F5AAD730454B88B708F', '956DC9B6D34842CDA613285C25A3C1D2', '401', '15', '1', '2019-08-22T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('086C028F8EE440C7B5795C12B5BE3299', '5879C913B8BA462EA26E5553B3E8D874', '407', 'modalwindow', '1', '2019-07-04T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('E31B926650B5422188BCC104AA9043AB', '4EBEA143E0A44269B8F6453B5BC2CFD6', '85', 'cn_action', '1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('DCD4252AD6194114AC9F87540D8E08A6', '5879C913B8BA462EA26E5553B3E8D874', '852', 'cv_name', '1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('BA70A901A90A40C4AF3ED95E7FD78EDB', '956DC9B6D34842CDA613285C25A3C1D2', '852', 'ck_id', '1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('9E0F29EF6DD947F1B11DF1E01BF24B58', '956DC9B6D34842CDA613285C25A3C1D2', '853', 'asc', '1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('F6B30099A5E741FDA0796A63E08E1FDB', '48C32AF385F64A3EA301E2BAEE3B396E', '992', 'fa-plus', '1', '2019-07-03T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('C6DA6B61F3AF42F8AFFD504ADB69A628', '5AD2E6DDF8EC47138D6A65A159F6F7F4', '1440', 'false', '1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('584EBEF61F3B42FCAC6BBEC2A78BD28C', '5AD2E6DDF8EC47138D6A65A159F6F7F4', '1449', 'false', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('9931A208D4E3400DA20C6A750298A76F', '5AD2E6DDF8EC47138D6A65A159F6F7F4', '1643', 'false', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('6CAC285C247D4C40B7F43C0CD7F699CC', '5AD2E6DDF8EC47138D6A65A159F6F7F4', '401', '15', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('2E4AAADC68E04C37BAFECE3C4EE05239', '5AD2E6DDF8EC47138D6A65A159F6F7F4', '852', 'cv_name', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('DA2EF4A144C7496980477AE0C29E81CC', '5AD2E6DDF8EC47138D6A65A159F6F7F4', '853', 'asc', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('C235DCD6E321479DB4D983761A318E5D', 'A1D1FE7951D54A408A9C54B282E731CB', '1449', 'false', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('ADBB223651AD400CBDADE9C5878D1C12', 'A1D1FE7951D54A408A9C54B282E731CB', '1643', 'false', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('9245B7E1088D4A53A778B4A560BF2F14', 'A1D1FE7951D54A408A9C54B282E731CB', '401', '15', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1E86C2AF88DE4D99B4399FBAC9334099', 'A1D1FE7951D54A408A9C54B282E731CB', '852', 'cv_name', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('5A9154DE01F849538CF816066F59AE7D', 'A1D1FE7951D54A408A9C54B282E731CB', '853', 'asc', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('EFC38C3C3F8A44EE9ED3C5DD9E59358E', '2890F3943D934AF4829E5F9EE8E0CA41', '1054', '25%', '1', '2019-07-03T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('7BDC544102524AE2BFA1AFED2D3191CE', 'A60489F21EB84EDF8AFCA3E390342B96', '1390', '55a1171b5e1e4a0097ffdb0f424e4fe7', '1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('33D3171C93524771B8D817922463850D', '7AB6267772BF488480E0443B7CBD647A', '140', 'onCloseWindowSilent', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('600F1AD04AE24052A94A03C6991DF585', '7AB6267772BF488480E0443B7CBD647A', '147', '2', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('5F01D81693184EEBA140E57A18B98130', 'A60489F21EB84EDF8AFCA3E390342B96', '444', 'ck_id', '1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('C86652B4F65F4EBF93EA5768AE994971', 'A60489F21EB84EDF8AFCA3E390342B96', '446', 'insert', '1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('CC8F48E612A542BC8E4091ECD16495DC', 'A60489F21EB84EDF8AFCA3E390342B96', '449', '10%', '1', '2019-07-03T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('1DD726A24E024AE1A86F7328C9082AEA', '2890F3943D934AF4829E5F9EE8E0CA41', '86', 'cv_name', '1', '2019-07-03T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('9AD444C2CF5E402FB1026D597D84A904', 'CCB0712056BF4CC2A11404E82193FAD9', '453', 'true', '1', '2019-07-03T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('3D983D27229E4937960F6BBC3B0F3C7F', '55951E1D952845F9B0099C0DF3757E05', '453', 'true', '-1', '2019-07-04T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('B26A57F0C5984B478E45383FD4974883', '1A881454BF0340C386E2176F8B5EF59A', '453', 'true', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('EC530A0E116A4CA5BB4886149C19FB65', 'E221AE08EEA049068ECBA29A3106EF0E', '453', 'true', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('889022CA95E84279B37AF37B78601DEB', '55951E1D952845F9B0099C0DF3757E05', '47', 'cv_name', '-1', '2019-07-04T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('F7EA5BCE909F40769776789D9DAF91AA', 'CCB0712056BF4CC2A11404E82193FAD9', '47', 'cv_name', '1', '2019-07-03T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('E3EBF5FE8422428D80A3258410BF51E5', 'E221AE08EEA049068ECBA29A3106EF0E', '47', 'cv_name', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('003B968C870244FE9E487F17583F8418', '1A881454BF0340C386E2176F8B5EF59A', '47', 'cv_name', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('4C96B89388DE4788B9E067BFFE5208A7', 'F3CA568B9B1948439CF82324850F69F3', '47', 'cv_description', '1', '2019-07-03T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('ABF3960EE1B2459CABE95B5440837781', 'C343BA92C0ED4E298A782EBB30C1F3DD', '47', 'cv_description', '-1', '2019-07-04T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('672033A9EA8D4AD3BA78ABC0D12A4EC2', '85E24E152C884021A61E975F2E267F24', '47', 'cv_description', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('18CA2D4565834392853F8E6238FCE6ED', '043BDA853E3A4C60821946A95FF30901', '47', 'cv_description', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('39EA5B8E98CE4492BC5EC4FE44DEEDB2', 'C9B9CED565D04CB7A37259231E315B1E', '1029', 'set_window', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('14D67E3C19E44EBEB5D8856A14F0BB8E', 'C9B9CED565D04CB7A37259231E315B1E', '146', 'xwide', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('823FB096B46D4329BDFF5AC8906FEFB1', 'FA5A40E6315844A087A99338C050D616', '1033', 'set_window', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('45A78A550E1C4E1394A4690B10AF6C49', 'FA5A40E6315844A087A99338C050D616', '155', '1', '-1', '2019-08-14T00:00:00.000+0000');
select pkg_patcher.p_merge_object_attr('E6A1F766F8054D409D17CCCECFC1D025', 'FA5A40E6315844A087A99338C050D616', '992', 'fa-cogs', '-1', '2019-08-14T00:00:00.000+0000');
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('6F026AB69BBB47D29D0112DDC169A9DF', '5868BCACDD034DFF9DC9B0C3170CB720', '956DC9B6D34842CDA613285C25A3C1D2', 10, null, null, '1', '2019-07-03T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('EAA1B79B6E2C43229C5B5AA4F8B58DB2', '5868BCACDD034DFF9DC9B0C3170CB720', '4F5D25DB7DF4494CA7095C69C67A8CEB', 20, null, null, '1', '2019-08-14T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('2D462C92FE644D65AA17D47BF47AD753', '5868BCACDD034DFF9DC9B0C3170CB720', '9BE87355051B48C39EB9AF15F50B24A1', 5, '6F026AB69BBB47D29D0112DDC169A9DF', null, '1', '2019-07-03T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('399E3D5B20584DFD9ECBE5A2147DE404', '5868BCACDD034DFF9DC9B0C3170CB720', '5879C913B8BA462EA26E5553B3E8D874', 10, 'EAA1B79B6E2C43229C5B5AA4F8B58DB2', null, '1', '2019-08-14T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('1D9D3B83CA9D430E820F07A8527C90F4', '5868BCACDD034DFF9DC9B0C3170CB720', '48C32AF385F64A3EA301E2BAEE3B396E', 10, '6F026AB69BBB47D29D0112DDC169A9DF', null, '1', '2019-07-03T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('FB4572F472F546319ED1474D432CCE75', '5868BCACDD034DFF9DC9B0C3170CB720', '231CDD084F0C409EAAE14B6415B5E1C8', 15, '6F026AB69BBB47D29D0112DDC169A9DF', null, '1', '2019-07-03T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('60DAD453D07E45EC90FDAEC0011F0ED2', '5868BCACDD034DFF9DC9B0C3170CB720', 'A60489F21EB84EDF8AFCA3E390342B96', 20, '6F026AB69BBB47D29D0112DDC169A9DF', null, '1', '2019-07-03T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('FB977463F6384281B6AD6199255CE038', '5868BCACDD034DFF9DC9B0C3170CB720', 'CCB0712056BF4CC2A11404E82193FAD9', 40, '6F026AB69BBB47D29D0112DDC169A9DF', null, '1', '2019-07-03T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('9D8E86160DBD47ECAD23E18D8DCE4DD2', '5868BCACDD034DFF9DC9B0C3170CB720', 'F3CA568B9B1948439CF82324850F69F3', 50, '6F026AB69BBB47D29D0112DDC169A9DF', null, '1', '2019-07-03T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('722238A72E1444ECAFE92516091DF133', '5868BCACDD034DFF9DC9B0C3170CB720', '4EBEA143E0A44269B8F6453B5BC2CFD6', 10, '2D462C92FE644D65AA17D47BF47AD753', null, '1', '2019-07-03T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('EB0F6B8706CF4C5DAE4158410603C053', '5868BCACDD034DFF9DC9B0C3170CB720', '2890F3943D934AF4829E5F9EE8E0CA41', 20, '2D462C92FE644D65AA17D47BF47AD753', null, '1', '2019-07-03T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('90A382FEA9454B189D6B286A584BBCA9', '5868BCACDD034DFF9DC9B0C3170CB720', '55951E1D952845F9B0099C0DF3757E05', 40, '399E3D5B20584DFD9ECBE5A2147DE404', null, '1', '2019-08-14T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('A4EB74282B56441D9E1408A58A2761D2', '5868BCACDD034DFF9DC9B0C3170CB720', 'C343BA92C0ED4E298A782EBB30C1F3DD', 50, '399E3D5B20584DFD9ECBE5A2147DE404', null, '1', '2019-08-14T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7A130FE5D01F41DEB629D1F86396925D', '5868BCACDD034DFF9DC9B0C3170CB720', 'C9B9CED565D04CB7A37259231E315B1E', 150, '399E3D5B20584DFD9ECBE5A2147DE404', null, '1', '2019-08-14T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('4059DF813EFC4ADA84EC0346275717C7', '5868BCACDD034DFF9DC9B0C3170CB720', 'FA5A40E6315844A087A99338C050D616', 250, '399E3D5B20584DFD9ECBE5A2147DE404', null, '1', '2019-08-14T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('42921CE3AF2844AFB51065ACB8759026', '5868BCACDD034DFF9DC9B0C3170CB720', '5E5245E846AC4AD695CAC04FB57AAF40', 12, '7A130FE5D01F41DEB629D1F86396925D', null, '1', '2019-08-14T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7A249B4615A44878BC725D52C85576C4', '5868BCACDD034DFF9DC9B0C3170CB720', '7AB6267772BF488480E0443B7CBD647A', 20, '7A130FE5D01F41DEB629D1F86396925D', null, '1', '2019-08-14T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('F103576B37CE49DE95276DA4A81BA67E', '5868BCACDD034DFF9DC9B0C3170CB720', '5AD2E6DDF8EC47138D6A65A159F6F7F4', 13, '42921CE3AF2844AFB51065ACB8759026', null, '1', '2019-08-14T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('D805958BE0B84A0BAE1106960270D8AA', '5868BCACDD034DFF9DC9B0C3170CB720', 'A1D1FE7951D54A408A9C54B282E731CB', 14, '42921CE3AF2844AFB51065ACB8759026', null, '1', '2019-08-14T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('9770108E15434189A70993BE57AAEAAC', '5868BCACDD034DFF9DC9B0C3170CB720', 'E221AE08EEA049068ECBA29A3106EF0E', 40, 'F103576B37CE49DE95276DA4A81BA67E', null, '1', '2019-08-14T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('677E32FA9C374093A32C04905A37BACE', '5868BCACDD034DFF9DC9B0C3170CB720', '1A881454BF0340C386E2176F8B5EF59A', 40, 'D805958BE0B84A0BAE1106960270D8AA', null, '1', '2019-08-14T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('85FE5E565F144D64AC9D02190F1872CD', '5868BCACDD034DFF9DC9B0C3170CB720', '85E24E152C884021A61E975F2E267F24', 50, 'D805958BE0B84A0BAE1106960270D8AA', null, '1', '2019-08-14T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object (ck_id, ck_page, ck_object, cn_order, ck_parent, ck_master, ck_user, ct_change) VALUES ('7DA320BFB55646B1AA7258F7DD11195D', '5868BCACDD034DFF9DC9B0C3170CB720', '043BDA853E3A4C60821946A95FF30901', 50, 'F103576B37CE49DE95276DA4A81BA67E', null, '1', '2019-08-14T00:00:00.000+0000')  on conflict (ck_id) do update set ck_page = excluded.ck_page, ck_object = excluded.ck_object, cn_order = excluded.cn_order, ck_parent = excluded.ck_parent, ck_master = excluded.ck_master, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
INSERT INTO s_mt.t_page_object_attr (ck_id, ck_page_object, ck_class_attr, cv_value, ck_user, ct_change) VALUES ('07A84C0CDF8B47CAB146097FB1D05723', 'EAA1B79B6E2C43229C5B5AA4F8B58DB2', '572', 'false', '1', '2019-07-09T00:00:00.000+0000')  ON CONFLICT ON CONSTRAINT cin_c_page_object_attr_1 do update set ck_id=excluded.ck_id, ck_page_object = excluded.ck_page_object, ck_class_attr = excluded.ck_class_attr, cv_value = excluded.cv_value, ck_user = excluded.ck_user, ct_change = excluded.ct_change;
update s_mt.t_page_object set ck_master='6F026AB69BBB47D29D0112DDC169A9DF' where ck_id='399E3D5B20584DFD9ECBE5A2147DE404';
update s_mt.t_page_object set ck_master='6F026AB69BBB47D29D0112DDC169A9DF' where ck_id='42921CE3AF2844AFB51065ACB8759026';
update s_mt.t_page_object set ck_master='6F026AB69BBB47D29D0112DDC169A9DF' where ck_id='F103576B37CE49DE95276DA4A81BA67E';
update s_mt.t_page_object set ck_master='6F026AB69BBB47D29D0112DDC169A9DF' where ck_id='D805958BE0B84A0BAE1106960270D8AA';
update s_mt.t_page_object set ck_master='6F026AB69BBB47D29D0112DDC169A9DF' where ck_id='EAA1B79B6E2C43229C5B5AA4F8B58DB2';
