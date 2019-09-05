import Connection from "@ungate/plugininf/lib/db/Connection";
import ILocalDB from "@ungate/plugininf/lib/db/local/ILocalDB";
import PostgresDB from "@ungate/plugininf/lib/db/postgres";
import ErrorException from "@ungate/plugininf/lib/errors/ErrorException";
import ErrorGate from "@ungate/plugininf/lib/errors/ErrorGate";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import IGlobalObject from "@ungate/plugininf/lib/IGlobalObject";
import IObjectParam from "@ungate/plugininf/lib/IObjectParam";
import IQuery from "@ungate/plugininf/lib/IQuery";
import { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import ISession from "@ungate/plugininf/lib/ISession";
import NullAuthProvider, {
    IAuthResult,
} from "@ungate/plugininf/lib/NullAuthProvider";
import { ReadStreamToArray } from "@ungate/plugininf/lib/stream/Util";
import { initParams, isEmpty } from "@ungate/plugininf/lib/util/Util";
import * as ActiveDirectory from "activedirectory";
import { X509 } from "jsrsasign";
import { uniq } from "lodash";

const Property = (global as IGlobalObject).property;
const BASIC_PATTERN = "Basic";
const PASSWORD_PATTERN_NGINX_GSS = "bogus_auth_gss_passwd";

export default class PKOAuth extends NullAuthProvider {
    public static getParamsInfo(): IParamsInfo {
        return {
            ...NullAuthProvider.getParamsInfo(),
            ...PostgresDB.getParamsInfo(),
            adBaseDN: {
                name: "Начальный уровень поиска в ldap",
                type: "string",
            },
            adDefaultAction: {
                description:
                    "Список экшенов которые назначаются любому авторизованому пользователю",
                name: "Список экшенов по умолчанию",
                type: "string",
            },
            adLogin: {
                name: "Логин УЗ доступа к ldap",
                type: "string",
            },
            adMapGroups: {
                description:
                    "Мапинг групп AD c Core Экшенами, Пример: NameGroup=900,200;NameGroup=100,215",
                name: "Мапинг групп и экшенов пользователя",
                type: "string",
            },
            adMapUserAttr: {
                defaultValue:
                    "cv_login=sAMAccountName;cv_name=cn;cv_surname=sn;cv_email=mail;cv_cert=userCertificate",
                description:
                    "Пример: cv_login=sAMAccountName;cv_name=cn;cv_surname=sn;cv_email=email;cv_cert=userCertificate",
                name: "Мапинг атрибутов пользователя",
                type: "string",
            },
            adPassword: {
                name: "Пароль УЗ доступа к ldap",
                type: "password",
            },
            adUrl: {
                description: "Пример: ldap://dc.domain.com",
                name: "Урл к ldap",
                required: true,
                type: "string",
            },
        };
    }

    public dataSource: PostgresDB;

    private dbUsers: ILocalDB;
    private dbDepartments: ILocalDB;
    private ad: ActiveDirectory;
    private mapUserAttr: IObjectParam = {};
    private mapGroupActions: IObjectParam = {};
    private listDefaultActions: number[] = [];
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.params = {
            ...this.params,
            ...initParams(PKOAuth.getParamsInfo(), params),
        };
        this.dataSource = new PostgresDB(`${this.name}_provider`, {
            connectString: this.params.connectString,
            connectionTimeoutMillis: this.params.connectionTimeoutMillis,
            idleTimeoutMillis: this.params.idleTimeoutMillis,
            partRows: this.params.partRows,
            poolMax: this.params.poolMax,
            queryTimeout: this.params.queryTimeout,
        });
        const userAttr = [
            "dn",
            "sAMAccountName",
            "objectSID",
            "mail",
            "sn",
            "givenName",
            "initials",
            "cn",
            "displayName",
            "comment",
            "description",
            "userCertificate",
        ];
        this.params.adMapUserAttr.split(";").forEach((val) => {
            const [bdkey, adkey] = val.split("=");
            this.mapUserAttr[adkey] = bdkey;
            if (!userAttr.includes(adkey)) {
                userAttr.push(adkey);
            }
        });
        if (this.params.adMapGroups) {
            this.params.adMapGroups.split(";").forEach((val) => {
                const [bdkey, adkey] = val.split("=");
                this.mapGroupActions[bdkey] = adkey
                    .split(",")
                    .map((action) => parseInt(action, 10));
            });
        }
        if (this.params.adDefaultAction) {
            this.listDefaultActions = this.params.adDefaultAction
                .split(",")
                .map((val) => parseInt(val, 10));
        }
        this.ad = new ActiveDirectory({
            attributes: {
                user: userAttr,
            },
            baseDN: this.params.adBaseDN,
            password: this.params.adPassword,
            url: this.params.adUrl,
            username: this.params.adLogin,
        });
    }
    public async afterSession(
        gateContext: IContext,
        sessionId: string,
        session: ISession,
    ): Promise<ISession> {
        if (
            isEmpty(session) &&
            gateContext.actionName !== "auth" &&
            gateContext.request.headers.authorization &&
            gateContext.request.headers["forwarded-ssl-client-m-serial"] &&
            gateContext.request.headers.authorization.indexOf(BASIC_PATTERN) >
                -1
        ) {
            return new Promise((resolve, reject) => {
                const basic = Buffer.from(
                    gateContext.request.headers.authorization.split(" ")[1],
                    "base64",
                ).toString("ascii");
                const [username, password] = basic.split(":");
                if (password === PASSWORD_PATTERN_NGINX_GSS) {
                    this.initSession(resolve, reject, username, gateContext);
                    return;
                }
                this.ad.authenticate(username, password, (err, isAuth) => {
                    if (err || !isAuth) {
                        this.log.error(
                            err ? err.message : "Invalid password or login",
                        );
                        reject(new ErrorException(ErrorGate.AUTH_DENIED));
                        return;
                    }
                    this.initSession(resolve, reject, username, gateContext);
                });
            });
        }
        return session;
    }
    public getConnection(): Promise<Connection> {
        return this.dataSource.getConnection();
    }
    public async processAuth(
        context: IContext,
        query: IGateQuery,
    ): Promise<IAuthResult> {
        const res = await context.connection.executeStmt(
            query.queryStr,
            query.inParams,
            query.outParams,
        );
        const arr = await ReadStreamToArray(res.stream);
        if (isEmpty(arr)) {
            return new Promise((resolve, reject) => {
                this.ad.authenticate(
                    query.inParams.cv_login,
                    query.inParams.cv_password,
                    (err, isAuth) => {
                        if (err || !isAuth) {
                            this.log.error(
                                err ? err.message : "Invalid password or login",
                            );
                            reject(new ErrorException(ErrorGate.AUTH_DENIED));
                            return;
                        }
                        this.initSession(
                            resolve,
                            reject,
                            query.inParams.cv_login,
                            context,
                            true,
                        );
                    },
                );
            }).then((user: IObjectParam) => ({
                ck_user: user.ck_id,
                data: user,
            }));
        }
        return {
            ck_user: arr[0].ck_id,
            data: arr[0],
        };
    }
    public async init(reload?: boolean): Promise<void> {
        if (!this.dbDepartments) {
            this.dbDepartments = await Property.getDepartments();
        }
        if (!this.dbUsers) {
            this.dbUsers = await Property.getUsers();
        }
        await this.dataSource.createPool();
        const users = {};
        return this.dataSource
            .executeStmt(
                "select u.ck_id, u.cv_login, u.cv_name, u.cv_surname, u.cv_patronymic\n" +
                    "  from t_user u",
                null,
                null,
                null,
                {
                    resultSet: true,
                },
            )
            .then(
                (resUser) =>
                    new Promise((resolve, reject) => {
                        resUser.stream.on("error", (err) => reject(err));
                        resUser.stream.on("data", (chunk) => {
                            users[chunk.ck_id] = {
                                ...chunk,
                                ca_actions: [],
                                cv_timezone: "+03:00",
                            };
                        });
                        resUser.stream.on("end", () => {
                            this.dataSource
                                .executeStmt(
                                    "select distinct ur.ck_user, dra.ck_d_action from t_user_role ur\n" +
                                        "  join t_d_role dr on dr.ck_id = ur.ck_d_role\n" +
                                        "  join t_d_role_action dra on dra.ck_d_role = dr.ck_id",
                                    null,
                                    null,
                                    null,
                                    {
                                        resultSet: true,
                                    },
                                )
                                .then(
                                    (resAction) =>
                                        new Promise(
                                            (resolveAction, rejectAction) => {
                                                resAction.stream.on(
                                                    "error",
                                                    (err) => rejectAction(err),
                                                );
                                                resAction.stream.on(
                                                    "data",
                                                    (val) => {
                                                        if (
                                                            users[val.ck_user]
                                                        ) {
                                                            users[
                                                                val.ck_user
                                                            ].ca_actions.push(
                                                                parseInt(
                                                                    val.ck_d_action,
                                                                    10,
                                                                ),
                                                            );
                                                        }
                                                    },
                                                );
                                                resAction.stream.on(
                                                    "end",
                                                    () => {
                                                        resolveAction();
                                                    },
                                                );
                                            },
                                        ),
                                )
                                .then(
                                    () => resolve(users),
                                    (err) => reject(err),
                                );
                        });
                    }),
            )
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
            .then(async () => {
                await this.authController.updateUserInfo(this.name);
            });
    }
    public async initContext(
        context: IContext,
        query: IQuery = {},
    ): Promise<IQuery> {
        const res = await super.initContext(context, query);
        if (isEmpty(query.queryStr)) {
            throw new ErrorException(ErrorGate.NOTFOUND_QUERY);
        }
        if (context.actionName !== "auth") {
            throw new ErrorException(ErrorGate.UNSUPPORTED_METHOD);
        }
        context.connection = await this.getConnection();
        return res;
    }
    private initSession(
        resolve: any,
        reject: any,
        username: string,
        gateContext: IContext,
        isUserData: boolean = false,
    ): void {
        this.ad.findUser(username, (err, user) => {
            if (err || !user) {
                this.log.error(
                    err ? err.message : `Not found user ${username}`,
                    err,
                );
                reject(new ErrorException(ErrorGate.AUTH_DENIED));
                return;
            }
            const x509 = new X509();
            x509.readCertPEM(user.userCertificate);
            if (
                x509.getSerialNumberHex().toLocaleUpperCase() !==
                (gateContext.request.headers[
                    "forwarded-ssl-client-m-serial"
                ] as string).toLocaleUpperCase()
            ) {
                this.log.error(
                    `Not valid certificate Serial-ad: ${x509
                        .getSerialNumberHex()
                        .toLocaleUpperCase()}, Serial-forwarded: ${(gateContext
                        .request.headers[
                        "forwarded-ssl-client-m-serial"
                    ] as string).toLocaleUpperCase()}`,
                );
                reject(new ErrorException(ErrorGate.AUTH_DENIED));
                return;
            }
            this.authController
                .getUserDb()
                .findOne(
                    {
                        $and: [
                            {
                                ck_d_provider: this.name,
                            },
                            {
                                "data.cv_login": username,
                            },
                        ],
                    },
                    true,
                )
                .then(async (userData = {}) => {
                    const data = Object.keys(this.mapUserAttr).reduce(
                        (obj, val) => ({
                            ...obj,
                            [this.mapUserAttr[val]]: user[val],
                        }),
                        {
                            ...userData.data,
                            ca_actions: this.getActionUser(user, [
                                ...(userData.data || {}).ca_actions,
                                ...this.listDefaultActions,
                            ]),
                            ck_id:
                                (userData.data || {}).ck_id || user.objectSID,
                            cv_timezone:
                                (userData.data || {}).cv_timezone || "+03:00",
                        },
                    );
                    if (!(userData.data || {}).ck_id) {
                        await this.authController.addUser(
                            data.ck_id,
                            this.name,
                            data,
                        );
                    }
                    if (isUserData) {
                        return resolve(data);
                    }
                    const session = await this.authController.loadSession(
                        null,
                        userData.ck_id || user.objectSID,
                        this.name,
                    );
                    if (session) {
                        return resolve(session);
                    }
                    return this.createSession(data.ck_id, data)
                        .then((res) =>
                            this.authController.loadSession(res.session),
                        )
                        .then((sess) => resolve(sess));
                })
                .catch((errFind) => {
                    this.log.error(errFind.message, errFind);
                    reject(new ErrorException(ErrorGate.AUTH_DENIED));
                });
        });
    }
    private getActionUser(user: any, actions?: number[]) {
        const groups = Object.keys(this.mapGroupActions);
        if (groups.length) {
            return uniq(
                groups.reduce(
                    (arr, group) =>
                        user.isMemberOf(group)
                            ? [...arr, this.mapGroupActions[group]]
                            : arr,
                    actions,
                ),
            );
        }
        return actions;
    }
}
