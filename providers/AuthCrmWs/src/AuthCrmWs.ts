import CrmWsCaller from "@ungate/plugininf/lib/caller/CrmWsCaller";
import JsonGateCaller from "@ungate/plugininf/lib/caller/JsonGateCaller";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import IQuery, { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import NullAuthProvider, {
    IAuthResult,
} from "@ungate/plugininf/lib/NullAuthProvider";
import NullProvider from "@ungate/plugininf/lib/NullProvider";
import ResultStream from "@ungate/plugininf/lib/stream/ResultStream";
import { ReadStreamToArray } from "@ungate/plugininf/lib/stream/Util";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";

export default class AuthCrmWs extends NullAuthProvider {
    public static getParamsInfo(): IParamsInfo {
        return {
            ...CrmWsCaller.getParamsInfo(),
            ...NullProvider.getParamsInfo(),
            clAudit: {
                defaultValue: true,
                name: "Признак аудита",
                type: "boolean",
            },
            cnSystem: {
                name: "Ид системы",
                required: true,
                type: "integer",
            },
            nsiGateUrl: {
                name: "Ссылка на гейт NSI",
                type: "string",
            },
            queryAuth: {
                name: "Наименовани запроса проверки авторизации",
                required: true,
                type: "string",
            },
            queryGetCrmUrl: {
                name: "Имя запроса получения ссылки на сувк",
                required: true,
                type: "string",
            },
            queryMetaUsers: {
                name: "Наименование запроса получения мета информации",
                required: true,
                type: "string",
            },
            queryToken: {
                name: "Наименование запроса получения token",
                required: true,
                type: "string",
            },
            queryUsersActions: {
                name: "Наименование запроса получения всех экшенов",
                required: true,
                type: "string",
            },
            queryUsersDepartments: {
                name: "Наименование запроса получения департаментов по юзеру",
                required: true,
                type: "string",
            },
            sessionDuration: {
                defaultValue: 60,
                name: "Время жизни сессии в минутах по умолчанию 60 минут",
                type: "integer",
            },
            urlCrmTemplate: {
                name: "Шаблон ссылки",
                type: "string",
            },
        };
    }
    private crmWSCaller: CrmWsCaller;
    private nsiJsonGateCaller: JsonGateCaller;
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.params = {
            ...this.params,
            ...initParams(AuthCrmWs.getParamsInfo(), params),
        };
        this.crmWSCaller = new CrmWsCaller(this.params);
        this.nsiJsonGateCaller = new JsonGateCaller({
            jsonGateUrl: this.params.nsiGateUrl,
        });
    }
    public async processAuth(
        context: IContext,
        query: IGateQuery,
    ): Promise<IAuthResult> {
        try {
            const params = Object.assign({}, query.inParams, {
                cl_audit: +this.params.clAudit,
                cn_system: this.params.cnSystem,
            });
            const result = await this.crmWSCaller.getData(
                this.params.queryAuth,
                params,
            );
            if (!result || !result.length) {
                throw new ErrorException(ErrorGate.AUTH_DENIED);
            }
            return {
                ck_user: result[0].cn_user,
            };
        } catch (e) {
            context.error("Ошибка вызова внешнего сервиса авторизации", e);
            throw new ErrorException(ErrorGate.AUTH_CALL_REMOTE);
        }
    }
    public processSql(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return this[query.queryStr](context, query);
    }
    public processDml(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return this[query.queryStr](context, query);
    }
    /**
     * Получаем ссылку на Сувк
     * @param gateContext
     * @returns {*|Promise.<TResult>}
     */
    public async getCrmUrl(gateContext: IContext): Promise<IResultProvider> {
        const params = {
            cn_user: gateContext.session.ck_id,
        };
        const res = await this.crmWSCaller.getData(
            this.params.queryToken,
            params,
        );
        if (!res.length) {
            return {
                stream: ResultStream([
                    {
                        ck_id: null,
                        cv_error: {
                            513: [],
                        },
                    },
                ]),
            };
        }
        const [obj] = res;
        return {
            stream: ResultStream([
                {
                    ck_id: null,
                    cv_error: null,
                    cv_url: (this.params.urlCrmTemplate || "").replace(
                        /{([^}]+)}/g,
                        (req, value) => obj[value],
                    ),
                },
            ]),
        };
    }
    public async getUrlForNsi(gateContext: IContext): Promise<IResultProvider> {
        return this.getNsiUrl(gateContext, false);
    }
    public async getUrlForNsiByTable(
        gateContext: IContext,
    ): Promise<IResultProvider> {
        return this.getNsiUrl(gateContext, true);
    }
    public async initContext(
        context: IContext,
        query: IQuery = {},
    ): Promise<IQuery> {
        const res = await super.initContext(context, query);
        if (context.actionName === "auth") {
            return {
                ...res,
                queryStr: "authCrm",
            };
        }
        switch (context.queryName) {
            case this.params.queryGetCrmUrl.toLowerCase(): {
                return {
                    ...res,
                    queryStr: "getCrmUrl",
                };
            }
            case "geturlfornsi": {
                return {
                    ...res,
                    queryStr: "getUrlForNsi",
                };
            }
            case "geturlfornsibytable": {
                return {
                    ...res,
                    queryStr: "getUrlForNsiByTable",
                };
            }
            default:
                throw new ErrorException(ErrorGate.NOTFOUND_QUERY);
        }
    }
    public async init(reload?: boolean): Promise<any> {
        await this.crmWSCaller.init();
        const params = {
            cn_system: this.params.cnSystem,
        };
        const users = {};
        const usersArr = await this.crmWSCaller.getData(
            this.params.queryMetaUsers,
            params,
        );
        const rows = [];
        if (!usersArr.length) {
            throw new ErrorException(
                -1,
                `Данных о пользователях не вернулось, провайдер: ${this.name}`,
            );
        }
        usersArr.forEach((item) => {
            users[item.ck_id] = {
                ...item,
                ca_actions: [],
                ca_department: [],
            };
        });

        // загружаем экшены пользователей
        rows.push(
            this.crmWSCaller
                .getData(this.params.queryUsersActions, params)
                .then((res) => {
                    if (res && res.length) {
                        res.forEach((item) => {
                            item.cv_actions.split(",").forEach((cnAction) => {
                                if (users[item.ck_user]) {
                                    users[item.ck_user].ca_actions.push(
                                        parseInt(cnAction, 10),
                                    );
                                }
                            });
                        });
                        return Promise.resolve();
                    }
                    throw new ErrorException(
                        -1,
                        `Данных о доступах не вернулось, провайдер: ${this.name}`,
                    );
                }),
        );
        // загружаем департаменты пользователей
        rows.push(
            this.crmWSCaller
                .getData(this.params.queryUsersDepartments, params)
                .then((res) => {
                    if (res && res.length) {
                        res.forEach((item) => {
                            item.cv_departments
                                .split(",")
                                .forEach((ckDepartment) => {
                                    if (users[item.ck_user]) {
                                        users[item.ck_user].ca_department.push(
                                            parseInt(ckDepartment, 10),
                                        );
                                    }
                                });
                        });
                    }
                    return Promise.resolve();
                }),
        );
        return Promise.all(rows)
            .then(() =>
                Promise.all(
                    Object.values(users).map((user) =>
                        this.authController.addUser(
                            (user as any).ck_id,
                            this.name,
                            user,
                        ),
                    ),
                ),
            )
            .then(() => this.authController.updateHashAuth())
            .then(() => {
                this.authController.updateUserInfo(this.name);
                return Promise.resolve();
            });
    }
    /**
     * Получаем ссылку на НСИ
     * @param gateContext
     * @returns {*|Promise.<TResult>}
     */
    private async getNsiUrl(
        gateContext: IContext,
        isTable = false,
    ): Promise<IResultProvider> {
        if (isEmpty(this.params.nsiGateUrl)) {
            throw new ErrorException(
                -1,
                "Require params(nsiGateUrl) not found",
            );
        }
        const json = JSON.parse(gateContext.params.json || "{}");
        const params = {
            cn_user: gateContext.session.ck_id,
        };
        const jsonCaller = await this.nsiJsonGateCaller.callGet(
            gateContext,
            "sql",
            isTable ? "GetUrlDocReqCreate" : "GetUrlDocReqList",
            isTable
                ? {
                      nm_table: json.filter.cv_table,
                  }
                : undefined,
        );
        const respData = await ReadStreamToArray(jsonCaller.stream);
        if (respData.length) {
            const [urlObj] = respData;
            const resJson = await this.crmWSCaller.getData(
                this.params.queryToken,
                params,
            );
            if (resJson.length) {
                const [obj] = resJson;
                return {
                    stream: ResultStream([
                        {
                            ck_id: null,
                            cv_error: null,
                            cv_url: urlObj.nm_url.replace(
                                /\[token\]/g,
                                obj.cv_token,
                            ),
                        },
                    ]),
                };
            }
        }
        return {
            stream: ResultStream([
                {
                    ck_id: null,
                    cv_error: {
                        513: [],
                    },
                },
            ]),
        };
    }
}