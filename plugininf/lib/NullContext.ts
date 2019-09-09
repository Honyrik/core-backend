import ErrorGate from "./errors/ErrorGate";
import ICCTParams, { IParamsInfo } from "./ICCTParams";
import IContext from "./IContext";
import IContextPlugin, { IContextPluginResult } from "./IContextPlugin";
import { IGateQuery } from "./IQuery";
import IResult from "./IResult";
import ResultStream from "./stream/ResultStream";
import { initParams } from "./util/Util";

export default abstract class NullContext implements IContextPlugin {
    public static getParamsInfo(): IParamsInfo {
        return {
            attachmentType: {
                defaultValue: "attachment",
                name: "Mimetype file download",
                type: "string",
            },
            maxFileSize: {
                defaultValue: 10485760,
                name: "Размер файла в байтах",
                type: "integer",
            },
            maxLogParamLen: {
                defaultValue: 2048,
                name: "Максимальная длина лога",
                type: "integer",
            },
            maxPostSize: {
                defaultValue: 10485760,
                name: "Размер POST в байтах",
                type: "integer",
            },
        };
    }
    public name: string;
    public params: ICCTParams;
    public get maxPostSize(): number {
        return this.params.maxPostSize || 10485760;
    }
    public get maxFileSize(): number {
        return this.params.maxFileSize || 10485760;
    }
    public get maxLogParamLen(): number {
        return this.params.maxLogParamLen || 2048;
    }
    public get attachmentType(): string {
        return this.params.attachmentType || "attachment";
    }
    constructor(name: string, params: ICCTParams) {
        this.name = name;
        this.params = initParams(NullContext.getParamsInfo(), params);
    }
    public abstract init(reload?: boolean): Promise<void>;
    public abstract initContext(
        gateContext: IContext,
    ): Promise<IContextPluginResult>;
    public async checkQueryAccess(
        gateContext: IContext,
        query: IGateQuery,
    ): Promise<boolean> {
        if (query.needSession && !gateContext.session) {
            return false;
        }
        return true;
    }
    public async handleResult(
        gateContext: IContext,
        result: IResult,
    ): Promise<IResult> {
        return result;
    }
    public async maskResult(): Promise<IResult> {
        const result = {
            data: ResultStream([ErrorGate.MAINTENANCE_WORK]),
            type: "error",
        };
        return result as IResult;
    }
    public abstract destroy(): Promise<void>;
}