import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams, { IParamInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import {
    filterFilesData,
    isEmpty,
    sortFilesData,
} from "@ungate/plugininf/lib/util/Util";
import { isObject } from "lodash";
import uuidv4 = require("uuidv4");
import PluginManager from "../../core/pluginmanager/PluginManager";
import Property from "../../core/property/Property";
import resetAction from "./ResetAction";
import RiakAction from "./RiakAction";

export default class AdminAction {
    public params: ICCTParams;
    public name: string;
    public riakAction: RiakAction;
    public dbUsers: ILocalDB;
    public dbContexts: ILocalDB;
    public dbEvents: ILocalDB;
    public dbSessions: ILocalDB;
    public dbProviders: ILocalDB;
    public dbSchedulers: ILocalDB;
    public dbPlugins: ILocalDB;
    public dbQuerys: ILocalDB;
    public dbServers: ILocalDB;
    constructor(name: string, params: ICCTParams) {
        this.name = name;
        this.params = params;
        this.riakAction = new RiakAction(params);
    }

    public async init(): Promise<void> {
        this.dbUsers = await Property.getUsers();
        this.dbContexts = await Property.getContext();
        this.dbEvents = await Property.getEvents();
        this.dbSessions = await Property.getSessions();
        this.dbProviders = await Property.getProviders();
        this.dbSchedulers = await Property.getSchedulers();
        this.dbPlugins = await Property.getPlugins();
        this.dbQuerys = await Property.getQuery();
        this.dbServers = await Property.getServers();
    }
    public gtresetdefaultconfig = (gateContext: IContext) =>
        gateContext.gateContextPlugin.init(true).then(() =>
            Promise.resolve([
                {
                    ck_id: undefined,
                    cv_error: null,
                },
            ]),
        );
    public gtrestartgate = (gateContext) =>
        resetAction(gateContext, "ck_id", "restartCluster", "master", "ck_id");
    public gtrestartfullgate = (gateContext) =>
        resetAction(gateContext, "ck_id", "restartAll", "master", "ck_id");
    public gtgetusers = (gateContext: IContext) =>
        this.dbUsers.find().then((docs) =>
            Promise.resolve(
                docs
                    .map((val) => ({
                        ...val,
                        ...Object.entries(val.data).reduce(
                            (obj, arr) => ({
                                ...obj,
                                [`data.${arr[0]}`]: arr[1],
                            }),
                            {},
                        ),
                        cv_actions:
                            val.data && val.data.ca_actions
                                ? val.data.ca_actions.join(", ")
                                : "",
                        cv_departments:
                            val.data && val.data.ca_department
                                ? val.data.ca_department.join(", ")
                                : "",
                    }))
                    .sort(sortFilesData(gateContext))
                    .filter(filterFilesData(gateContext)),
            ),
        );
    public gtgetsessions = (gateContext: IContext) =>
        this.dbSessions.find().then((docs) =>
            Promise.resolve(
                docs
                    .map((val) => ({
                        ...val,
                        data: undefined,
                        ...Object.entries(val.data).reduce(
                            (obj, arr) => ({
                                ...obj,
                                [`data.${arr[0]}`]: arr[1],
                            }),
                            {},
                        ),
                    }))
                    .sort(sortFilesData(gateContext))
                    .filter(filterFilesData(gateContext)),
            ),
        );
    public gtgetservers = (gateContext: IContext) =>
        this.dbServers
            .find()
            .then((docs) =>
                Promise.resolve(
                    docs
                        .sort(sortFilesData(gateContext))
                        .filter(filterFilesData(gateContext)),
                ),
            );
    public gtgetconfproviders = (gateContext: IContext) =>
        this.dbProviders.find().then((docs) =>
            Promise.resolve(
                docs
                    .map((val) => ({
                        ...val,
                        cct_params: this.ParamsToString(
                            PluginManager.getGateProviderClass,
                            val.ck_d_plugin,
                            val.cct_params,
                        ),
                        ck_d_plugin: val.ck_d_plugin.toLowerCase(),
                    }))
                    .sort(sortFilesData(gateContext))
                    .filter(filterFilesData(gateContext)),
            ),
        );
    public gtgetconfigs = (gateContext: IContext) =>
        this.dbContexts.find().then((docs) =>
            Promise.resolve(
                docs
                    .map((val) => ({
                        ...val,
                        cct_params: this.ParamsToString(
                            PluginManager.getGateContextClass,
                            val.ck_d_plugin,
                            val.cct_params,
                        ),
                        ck_d_plugin: val.ck_d_plugin.toLowerCase(),
                    }))
                    .sort(sortFilesData(gateContext))
                    .filter(filterFilesData(gateContext)),
            ),
        );
    public gtgetconfplugins = (gateContext: IContext) =>
        this.dbPlugins.find().then((docs) =>
            Promise.resolve(
                docs
                    .map((val) => ({
                        ...val,
                        cct_params: this.ParamsToString(
                            PluginManager.getGatePluginsClass,
                            val.ck_d_plugin,
                            val.cct_params,
                        ),
                        ck_d_plugin: val.ck_d_plugin.toLowerCase(),
                    }))
                    .sort(sortFilesData(gateContext))
                    .filter(filterFilesData(gateContext)),
            ),
        );
    public gtgetconfquery = (gateContext: IContext) =>
        this.dbQuerys.find().then((docs) =>
            Promise.resolve(
                docs
                    .map((val) => ({
                        ...val,
                    }))
                    .sort(sortFilesData(gateContext))
                    .filter(filterFilesData(gateContext)),
            ),
        );
    public gtgetschedulers = (gateContext: IContext) =>
        this.dbSchedulers.find().then((docs) =>
            Promise.resolve(
                docs
                    .map((val) => ({
                        ...val,
                        cct_params: this.ParamsToString(
                            PluginManager.getGateSchedulerClass,
                            val.ck_d_plugin,
                            val.cct_params,
                        ),
                        ck_d_plugin: val.ck_d_plugin.toLowerCase(),
                    }))
                    .sort(sortFilesData(gateContext))
                    .filter(filterFilesData(gateContext)),
            ),
        );
    public gtgetpluginsclass = (gateContext: IContext) =>
        Promise.resolve(
            PluginManager.getGateAllPluginsClass()
                .map((val) => ({ ck_id: val }))
                .sort(sortFilesData(gateContext))
                .filter(filterFilesData(gateContext)),
        );
    public gtgetprovidersclass = (gateContext: IContext) =>
        Promise.resolve(
            PluginManager.getGateAllProvidersClass()
                .map((val) => ({ ck_id: val }))
                .sort(sortFilesData(gateContext))
                .filter(filterFilesData(gateContext)),
        );
    public gtgetconfigclass = (gateContext: IContext) =>
        Promise.resolve(
            PluginManager.getGateAllContextClass()
                .map((val) => ({ ck_id: val }))
                .sort(sortFilesData(gateContext))
                .filter(filterFilesData(gateContext)),
        );
    public gtgetschedulerclass = (gateContext: IContext) =>
        Promise.resolve(
            PluginManager.getGateAllSchedulersClass()
                .map((val) => ({ ck_id: val }))
                .sort(sortFilesData(gateContext))
                .filter(filterFilesData(gateContext)),
        );
    public gtreloadpluginsclass = (gateContext: IContext) =>
        resetAction(gateContext, "ck_id", "resetPluginClass", "cluster");
    public gtreloadprovidersclass = (gateContext: IContext) =>
        resetAction(gateContext, "ck_id", "resetProviderClass", "cluster");
    public gtreloadconfigclass = (gateContext: IContext) =>
        resetAction(gateContext, "ck_id", "resetContextClass", "cluster");
    public gtresetprovider = (gateContext: IContext) =>
        resetAction(gateContext, "ck_id", "reloadProvider", "cluster");
    public gtresetallprovider = (gateContext: IContext) =>
        resetAction(gateContext, "ck_id", "reloadAllProvider", "cluster");
    public gtresetconfig = (gateContext: IContext) =>
        resetAction(gateContext, "ck_id", "reloadContext", "cluster");
    public gtresetallconfig = (gateContext: IContext) =>
        resetAction(gateContext, "ck_id", "reloadAllContext", "cluster");
    public gtresetscheduler = (gateContext: IContext) =>
        resetAction(gateContext, "ck_id", "reloadScheduler", "schedulerNode");
    public gtresetallscheduler = (gateContext: IContext) =>
        resetAction(
            gateContext,
            "ck_id",
            "reloadAllScheduler",
            "schedulerNode",
        );
    public gtgetriakbuckets = (...arg) =>
        this.riakAction.gtgetriakbuckets.apply(this.riakAction, arg);
    public gtgetriakfiles = (gateContext: IContext) =>
        this.riakAction.loadRiakFiles(gateContext);
    public gtgetriakfileinfo = (gateContext: IContext) =>
        this.riakAction.loadRiakFileInfo(gateContext);
    public gtdownloadriakfile = (gateContext: IContext) =>
        this.riakAction.downloadRiakFile(gateContext);
    public gtgetprovidersetting = (gateContext: IContext) =>
        this.loadSetting(
            gateContext,
            "ck_id",
            PluginManager.getGateProviderClass,
            this.dbProviders,
        );
    public gtgetcontextsetting = (gateContext: IContext) =>
        this.loadSetting(
            gateContext,
            "ck_id",
            PluginManager.getGateContextClass,
            this.dbContexts,
        );
    public gtgetpluginsetting = (gateContext: IContext) =>
        this.loadSetting(
            gateContext,
            "ck_id",
            PluginManager.getGatePluginsClass,
            this.dbPlugins,
        );
    public gtgetschedulersetting = (gateContext: IContext) =>
        this.loadSetting(
            gateContext,
            "ck_id",
            PluginManager.getGateSchedulerClass,
            this.dbSchedulers,
        );
    public gtgetboolean = () =>
        Promise.resolve([
            {
                ck_id: true,
            },
            {
                ck_id: false,
            },
        ]);
    public ParamsToString(method: any, ckDPlugin: string, cctParams = {}) {
        const PClass = method(ckDPlugin.toLowerCase());
        let params = {};
        if (PClass && PClass.getParamsInfo) {
            params = PClass.getParamsInfo();
        }
        return Object.entries(cctParams).reduce((str, arr) => {
            if (params[arr[0]] && params[arr[0]].type === "password") {
                return `${str}${arr[0]}=***<br/>`;
            }
            return `${str}${arr[0]}=${
                isObject(arr[1]) ? JSON.stringify(arr[1]) : arr[1]
            }<br/>`;
        }, "");
    }
    /**
     * Загрузка меню настроек
     * @param gateContext
     * @param method
     * @param db
     * @returns
     */
    public loadSetting(gateContext: IContext, column: string, method, db) {
        if (isEmpty(gateContext.query.inParams.json)) {
            return Promise.reject(new ErrorException(ErrorGate.JSON_PARSE));
        }
        const json = JSON.parse(
            gateContext.query.inParams.json,
            (key, value) => {
                if (value === null) {
                    return undefined;
                }
                return value;
            },
        );
        const PClass = method(json.master.ck_id);
        if (PClass && PClass.getParamsInfo) {
            const params = PClass.getParamsInfo();
            return (json.filter.cv_name
                ? db.findOne({
                      [column]: json.filter.cv_name,
                  })
                : Promise.resolve({})
            ).then((doc) =>
                Promise.resolve([
                    {
                        childs: Object.entries(params)
                            .map((arr) =>
                                this.createFields(
                                    gateContext,
                                    arr[0],
                                    json.filter.ck_page,
                                    (json.filter.childs || [])[0],
                                    arr[1] as IParamInfo,
                                    doc.cct_params,
                                ),
                            )
                            .filter((val) => !isEmpty(val)),
                        ck_page: json.filter.ck_page,
                        ck_page_object: uuidv4(),
                        column: "cct_params",
                        contentview: "vbox",
                        datatype: "array",
                        type: "FIELDSET",
                    },
                ]),
            );
        }
        return Promise.resolve([]);
    }

    /**
     * Создаем поля ввода
     * @param gateContext
     * @param name
     * @param ckPage
     * @param [child]
     * @param conf
     * @param [params]
     * @returns
     */
    public createFields(
        gateContext: IContext,
        name: string,
        ckPage: number | string,
        child = {
            ck_page_object: uuidv4(),
        },
        conf: IParamInfo,
        params = {},
    ) {
        switch (conf.type) {
            case "string": {
                return {
                    ck_page: ckPage,
                    ck_page_object: uuidv4(),
                    column: name,
                    cv_displayed: conf.name,
                    datatype: "text",
                    defaultvalue: isObject(params[name])
                        ? JSON.stringify(params[name])
                        : params[name] || conf.defaultValue,
                    info: conf.description,
                    required: conf.required ? "true" : "false",
                    type: "IFIELD",
                };
            }
            case "password": {
                return {
                    ck_page: ckPage,
                    ck_page_object: uuidv4(),
                    column: name,
                    cv_displayed: conf.name,
                    datatype: "password",
                    defaultvalue: isEmpty(params[name])
                        ? ""
                        : "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8",
                    info: conf.description,
                    required: conf.required ? "true" : "false",
                    type: "IFIELD",
                };
            }
            case "integer": {
                return {
                    ck_page: ckPage,
                    ck_page_object: uuidv4(),
                    column: name,
                    cv_displayed: conf.name,
                    datatype: "integer",
                    defaultvalue: params[name] || conf.defaultValue,
                    info: conf.description,
                    required: conf.required ? "true" : "false",
                    type: "IFIELD",
                };
            }
            case "boolean": {
                if (isEmpty(conf.defaultValue)) {
                    return {
                        autoload: "true",
                        ck_page: ckPage,
                        ck_page_object: child.ck_page_object,
                        ck_query: "GTGetBoolean",
                        cl_dataset: 1,
                        column: name,
                        cv_displayed: conf.name,
                        datatype: "combo",
                        defaultvalue: params[name] || conf.defaultValue,
                        displayfield: "ck_id",
                        info: conf.description,
                        required: conf.required ? "true" : "false",
                        type: "IFIELD",
                        valuefield: "ck_id",
                    };
                }
                return {
                    ck_page: ckPage,
                    ck_page_object: uuidv4(),
                    column: name,
                    cv_displayed: conf.name,
                    datatype: "checkbox",
                    defaultvalue: +(params[name] || conf.defaultValue),
                    info: conf.description,
                    required: conf.required ? "true" : "false",
                    type: "IFIELD",
                };
            }
            default: {
                gateContext.warn(name, conf.type);
                return undefined;
            }
        }
    }
}