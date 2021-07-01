--liquibase formatted sql
--changeset patcher-core:View_docs dbms:postgresql runOnChange:true splitStatements:false stripComments:false
INSERT INTO s_mt.t_view(ck_id, cv_description, cct_config, cct_manifest, cl_available, ck_user, ct_change) VALUES ('docs', 'Essence Core Doc', '{"bc": {"type": "APPLICATION", "childs": [{"type": "APP_BAR", "childs": [{"type": "BTN_GROUP", "childs": [{"type": "BTN", "reqsel": false, "uitype": "1", "ck_page": "AB115A267226428A9B23F1E7BE09028D", "cv_name": "Button Favorite", "handler": "onWindowOpen", "maxfile": 5242880, "ckwindow": "favorite", "cn_order": 10, "iconfont": "star", "onlyicon": true, "ck_master": "C99780A37AF74E98B26183D4A454328B", "ck_object": "2F3954CB3EAF443CB3D40FE7EB78B18E", "ck_parent": "C068FAF77FBF44EC81A78C6F426D1FDE", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "iconfontname": "fa", "ck_page_object": "53CAC3EB7EA041B19E6A472C7B58BED3", "cv_description": "Открытие закладок", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}], "ck_page": "AB115A267226428A9B23F1E7BE09028D", "cv_name": "Button Group Left", "cn_order": 10, "onlyicon": true, "ck_object": "B085536AE0754E7EBD6E37F4972D7C10", "ck_parent": "540F9C04453E4AEBB291B8E0ECE286F6", "cl_dataset": 0, "contentview": "hbox", "ck_page_object": "C068FAF77FBF44EC81A78C6F426D1FDE", "cv_description": "Секция кнопок слева"}, {"type": "OPEN_PAGE_TABS", "width": "100%", "height": "45px", "ck_page": "AB115A267226428A9B23F1E7BE09028D", "cv_name": "Docs Open Page Tabs", "cn_order": 20, "ck_object": "0ADBC859505D4651B936684A864DC34C", "ck_parent": "540F9C04453E4AEBB291B8E0ECE286F6", "cl_dataset": 0, "contentview": "hbox", "ck_page_object": "E3F83D3AD75846B59D6AD793C0FE7004", "cv_description": "Docs Open Page Tabs"}, {"type": "BTN_GROUP", "childs": [{"type": "BTN", "reqsel": false, "uitype": "1", "ck_page": "AB115A267226428A9B23F1E7BE09028D", "cv_name": "Button Promo", "maxfile": 5242880, "cn_order": 50, "iconfont": "home", "onlyicon": true, "ck_object": "7A93258A975244DEB5104E18994C058B", "ck_parent": "ED18B798EE574E63BF9753AD3216C09D", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "redirecturl": "redirect/promo", "iconfontname": "fa", "ck_page_object": "20D20D5DD4774742AE45B74956C91318", "cv_description": "Button Promo", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}, {"type": "BTN", "reqsel": false, "uitype": "1", "ck_page": "AB115A267226428A9B23F1E7BE09028D", "cv_name": "Button Auth", "maxfile": 5242880, "cn_order": 100, "iconfont": "sign-in", "onlyicon": true, "ck_object": "BA632D5FA0C44447B37DEE7C4749CC73", "ck_parent": "ED18B798EE574E63BF9753AD3216C09D", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "redirecturl": "g_sess_session ? \"redirect/pages\" : \"redirect/auth\"", "iconfontname": "fa", "ck_page_object": "323A33A9498340478AAC98060C05B8C0", "cv_description": "Button Auth", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}, {"type": "BTN", "reqsel": false, "uitype": "1", "ck_page": "AB115A267226428A9B23F1E7BE09028D", "cv_name": "Button About", "handler": "onWindowOpen", "maxfile": 5242880, "ckwindow": "about", "cn_order": 200, "iconfont": "info-circle ", "onlyicon": true, "ck_master": "C99780A37AF74E98B26183D4A454328B", "ck_object": "8B75939BE5054D009B2520870DAC3A04", "ck_parent": "ED18B798EE574E63BF9753AD3216C09D", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "cv_displayed": "66eeff41c0c94c5ca52909fb9d97e0aa", "iconfontname": "fa", "ck_page_object": "D93A41DFD42E48379BDC45D4DFA28279", "cv_description": "О программе", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}], "ck_page": "AB115A267226428A9B23F1E7BE09028D", "cv_name": "Button Group Right", "cn_order": 30, "ck_object": "B285428583D74A9E80179D4443EADFA7", "ck_parent": "540F9C04453E4AEBB291B8E0ECE286F6", "cl_dataset": 0, "contentview": "hbox", "ck_page_object": "ED18B798EE574E63BF9753AD3216C09D", "cv_description": "Button Group Right"}], "height": "45px", "uitype": "1", "ck_page": "AB115A267226428A9B23F1E7BE09028D", "cv_name": "App Bar Docs", "cn_order": 10, "position": "relative", "ck_object": "9DEEB415991744B585D5D66B44D61362", "ck_parent": "C99780A37AF74E98B26183D4A454328B", "cl_dataset": 0, "contentview": "hbox", "ck_page_object": "540F9C04453E4AEBB291B8E0ECE286F6", "cv_description": "App Bar Docs"}, {"type": "BOX", "childs": [{"type": "BOX", "width": "30%", "childs": [{"type": "PAGES_TREE", "uitype": "1", "ck_page": "AB115A267226428A9B23F1E7BE09028D", "cv_name": "Pages Tree", "cn_order": 10, "ck_object": "48CE1DF9590B41E9B8AF9ABF4B3EFA70", "ck_parent": "8DF4FA9536194C6FAF329ABE0DBE410D", "cl_dataset": 0, "ck_page_object": "7A5AF71DCB3149A098BB312DF012B141", "cv_description": "Pages Tree"}], "height": "100%", "reqsel": true, "ck_page": "AB115A267226428A9B23F1E7BE09028D", "cv_name": "Box Pager Tree", "cn_order": 10, "ck_object": "4BF66E79AD474510A4F48588473C0097", "ck_parent": "CDD3012642F34465AF6C45F973AC732C", "cl_dataset": 0, "contentview": "hbox", "ck_page_object": "8DF4FA9536194C6FAF329ABE0DBE410D", "cv_description": "Box Pager Tree"}, {"type": "PAGES", "childs": [{"type": "DOCUMENTATION", "hidden": false, "ck_page": "AB115A267226428A9B23F1E7BE09028D", "cv_name": "Documentation", "autoload": false, "ck_query": "MTClassDoc", "cn_order": 10, "disabled": false, "ck_modify": "modify", "ck_object": "A0F6F56A96314FD685755D278A212C93", "ck_parent": "027420C353034165B39FC19225F77F56", "cl_dataset": 1, "defaultvalue": "##first##", "ck_page_object": "052BCDF9BC9346C594CF18F8D364BEED", "cv_description": "Documentation", "cv_helper_color": "yellow", "defaultvaluelocalization": "##first##"}], "height": "100%", "ck_page": "AB115A267226428A9B23F1E7BE09028D", "cv_name": "Pages", "cn_order": 40, "ck_object": "2C014F2BF97A443994FFC147DA5A3C96", "ck_parent": "CDD3012642F34465AF6C45F973AC732C", "cl_dataset": 0, "ck_page_object": "027420C353034165B39FC19225F77F56", "cv_description": "Список отображаемых страниц"}], "height": "100%", "reqsel": true, "ck_page": "AB115A267226428A9B23F1E7BE09028D", "cv_name": "Box Page Content", "cn_order": 30, "ck_object": "046E8E9C7ED641CD89726F6141D8168B", "ck_parent": "C99780A37AF74E98B26183D4A454328B", "cl_dataset": 0, "contentview": "hbox", "ck_page_object": "CDD3012642F34465AF6C45F973AC732C", "cv_description": "Box Page Content"}], "ck_page": "AB115A267226428A9B23F1E7BE09028D", "cv_name": "SYS Application - Docs", "ck_query": "DTRoute", "cn_order": 10, "ck_modify": "modify", "ck_object": "0A7BD5B1D90C44B8904F6808D7217FC9", "cl_dataset": 1, "idproperty": "ck_id", "activerules": "cv_url === \"docs\"", "childwindow": [{"top": 45, "type": "WIN", "align": "left", "width": "20%", "childs": [{"type": "PAGES_TREE", "uitype": "3", "ck_page": "AB115A267226428A9B23F1E7BE09028D", "cv_name": "Pages Tree", "cn_order": 1, "ck_object": "8F78CB94849A42DC800013765DF49E3B", "ck_parent": "DD85C628D7B14CF48A8F6E6D8743BAEA", "cl_dataset": 0, "ck_page_object": "DAE53A04F70E4199B6BF4C377C49940F", "cv_description": "Дерево страниц"}], "height": "100%", "ck_page": "AB115A267226428A9B23F1E7BE09028D", "cv_name": "Drawer Menu", "ckwindow": "menu", "cn_order": 110, "datatype": "DRAWER", "ck_object": "4EA909980F0942449E115F4BE0980AA0", "ck_parent": "C99780A37AF74E98B26183D4A454328B", "cl_dataset": 0, "ck_page_object": "DD85C628D7B14CF48A8F6E6D8743BAEA", "cv_description": "Drawer для меню"}, {"type": "WIN", "childs": [{"type": "IFRAME", "width": "100%", "column": "cv_app_info", "ck_page": "AB115A267226428A9B23F1E7BE09028D", "cv_name": "About IFrame", "autoload": true, "ck_query": "MTGetMainAppInfo", "cn_order": 20, "ck_modify": "modify", "ck_object": "877D85060B1B4688B3C973348E487CBC", "ck_parent": "4E675B899DE84C41B52985CA9D19CAD7", "cl_dataset": 1, "idproperty": "ck_id", "typeiframe": "\"HTML\"", "noglobalmask": true, "ck_page_object": "A4917DB589544A728873BF1A8FEECE62", "cv_description": "About IFrame", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "cv_helper_color": "yellow", "getglobaltostore": [{"in": "g_sys_front_branch_date_time"}, {"in": "g_sys_front_branch_name"}, {"in": "g_sys_front_commit_id"}, {"in": "g_sys_lang"}]}], "ck_page": "AB115A267226428A9B23F1E7BE09028D", "cv_name": "Window About", "wintype": "default", "ckwindow": "about", "cn_order": 210, "datatype": "WINDOW", "bottombtn": [{"type": "BTN", "hidden": true, "reqsel": false, "uitype": "1", "ck_page": "AB115A267226428A9B23F1E7BE09028D", "cv_name": "Close Silent", "handler": "onCloseWindowSilent", "maxfile": 5242880, "cn_order": 30, "ck_object": "3B8E28D4C0654DED977579351066A8E9", "ck_parent": "4E675B899DE84C41B52985CA9D19CAD7", "filetypes": "doc,docx,pdf,zip,txt,ods,odt,xls,xlsx", "cl_dataset": 0, "iconfontname": "fa", "ck_page_object": "7A293ED5A8F848DF909CB9E1C0175F01", "cv_description": "Close Silent", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "skipvalidation": false}], "ck_object": "1D5E2008386949CF880FE00EDF6DCF02", "ck_parent": "C99780A37AF74E98B26183D4A454328B", "cl_dataset": 0, "cv_displayed": "66eeff41c0c94c5ca52909fb9d97e0aa", "ck_page_object": "4E675B899DE84C41B52985CA9D19CAD7", "cv_description": "О программе", "collectionvalues": "object"}, {"top": 45, "type": "WIN", "align": "left", "width": "20%", "childs": [{"type": "FAVORITE_PAGES", "ck_page": "AB115A267226428A9B23F1E7BE09028D", "cv_name": "Favorite Pages", "cn_order": 10, "ck_object": "535E001C1A1E4C8C8535424D569D710A", "ck_parent": "B514BE10C4F2441CADDC396381AFA3ED", "cl_dataset": 0, "ck_page_object": "54F0F84675F7481A951B882DF7A54011", "cv_description": "Избранные страницы"}], "height": "100%", "ck_page": "AB115A267226428A9B23F1E7BE09028D", "cv_name": "Favorite Pages", "ckwindow": "favorite", "cn_order": 310, "datatype": "DRAWER", "ck_object": "6CAD5516D17B40ECBD1CF9958DB4B7C7", "ck_parent": "C99780A37AF74E98B26183D4A454328B", "cl_dataset": 0, "ck_page_object": "B514BE10C4F2441CADDC396381AFA3ED", "cv_description": "Избранные страницы"}], "cl_is_master": 1, "defaultvalue": "home-docs", "ck_page_object": "C99780A37AF74E98B26183D4A454328B", "cv_description": "Application Docs", "getmastervalue": [{"in": "ck_id", "out": "ck_id"}], "cv_helper_color": "yellow", "defaultvaluelocalization": "home"}}'::jsonb, '{}'::jsonb, 1, '4fd05ca9-3a9e-4d66-82df-886dfa082113', '2020-12-10T13:13:44.000+0000')  on conflict (ck_id) do update set cl_available = excluded.cl_available, cct_config = excluded.cct_config, cct_manifest = excluded.cct_manifest, cv_description = excluded.cv_description, ck_user = excluded.ck_user, ct_change = excluded.ct_change;