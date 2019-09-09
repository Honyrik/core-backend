import OracleDB from "@ungate/plugininf/lib/db/oracle";
import ICCTParams, { IParamsInfo } from "@ungate/plugininf/lib/ICCTParams";
import IContext from "@ungate/plugininf/lib/IContext";
import IQuery, { IGateQuery } from "@ungate/plugininf/lib/IQuery";
import { IResultProvider } from "@ungate/plugininf/lib/IResult";
import NullProvider from "@ungate/plugininf/lib/NullProvider";
import { initParams } from "@ungate/plugininf/lib/util/Util";
import { isEmpty } from "@ungate/plugininf/lib/util/Util";
import * as moment from "moment";
import CoreOracle from "./CoreOracle";
import IOracleController from "./IOracleController";
import OldOracle from "./OldOracle";
import Oracle from "./Oracle";

export default class OracleDBPlugin extends NullProvider {
    public static getParamsInfo(): IParamsInfo {
        return {
            ...OracleDB.getParamsInfo(),
            ...NullProvider.getParamsInfo(),
            core: {
                defaultValue: false,
                name: "Инициализация согласно проекту Core",
                type: "boolean",
            },
            defaultSchema: {
                description: "Схема по умолчаниюв режиме old",
                name: "Схема по умолчанию в режиме old",
                type: "string",
            },
            old: {
                defaultValue: false,
                name: "Работа по аналогии Java json",
                type: "boolean",
            },
        };
    }
    public dataSource: OracleDB;
    private controller: IOracleController;
    constructor(name: string, params: ICCTParams) {
        super(name, params);
        this.params = {
            ...this.params,
            ...initParams(OracleDBPlugin.getParamsInfo(), params),
        };
        this.dataSource = new OracleDB(`${this.name}_provider`, {
            connectString: this.params.connectString,
            maxRows: this.params.maxRows,
            partRows: this.params.partRows,
            password: this.params.password,
            poolMax: this.params.poolMax,
            poolMin: this.params.poolMin,
            prefetchRows: this.params.prefetchRows,
            queryTimeout: this.params.queryTimeout,
            queueTimeout: this.params.queueTimeout,
            user: this.params.user,
        });
        if (params.core) {
            this.controller = new CoreOracle(
                this.name,
                this.params,
                this.dataSource,
            );
        } else if (params.old) {
            this.controller = new OldOracle(
                this.name,
                this.params,
                this.dataSource,
            );
        } else {
            this.controller = new Oracle(
                this.name,
                this.params,
                this.dataSource,
            );
        }
    }
    /**
     * Переводим массив в правильный тип для провайдера
     * @param array
     * @returns {{dir: (BIND_IN|{value, enumerable}), val: *}}
     */
    public arrayInParams(array): any {
        return {
            dir: this.dataSource.oracledb.BIND_IN,
            val: array,
        };
    }
    /**
     * Переводим дату в правильный тип для провайдера
     * @param array
     * @returns {{dir: (BIND_IN|{value, enumerable}), val: *}}
     */
    public dateInParams(value): any {
        return isEmpty(value)
            ? ""
            : {
                  dir: this.dataSource.oracledb.BIND_IN,
                  type: this.dataSource.oracledb.DATE,
                  val: moment(value).toDate(),
              };
    }
    /**
     * Переводим файл/buffer в правильный тип для провайдера
     * @param array
     * @returns {{dir: (BIND_IN|{value, enumerable}), val: *}}
     */
    public fileInParams(value): any {
        return {
            dir: this.dataSource.oracledb.BIND_IN,
            type: this.dataSource.oracledb.BLOB,
            val: value,
        };
    }
    public processSql(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return this.controller.processSql(context, query);
    }
    public processDml(
        context: IContext,
        query: IGateQuery,
    ): Promise<IResultProvider> {
        return this.controller.processDml(context, query);
    }
    public async init(reload?: boolean): Promise<void> {
        await this.dataSource.createPool();
        return this.controller.init();
    }
    public async initContext(
        context: IContext,
        query: IQuery = {},
    ): Promise<IQuery> {
        const res = await super.initContext(context, query);
        context.connection = await this.controller.getConnection(context);
        if (!isEmpty(res.modifyMethod) && res.modifyMethod !== "_") {
            res.queryStr =
                "begin\n" +
                `:result := ${res.modifyMethod}(:sess_ck_id, :sess_session, :json);\n` +
                "end;";
            return res;
        } else if (res.modifyMethod === "_") {
            return res;
        }
        if (!isEmpty(query.queryStr)) {
            return res;
        }
        return this.controller.initContext(context, context.connection, res);
    }

    public destroy(): Promise<void> {
        return this.dataSource.resetPool();
    }
}