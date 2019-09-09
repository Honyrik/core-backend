/**
 * Created by artemov_i on 05.12.2018.
 */

import {
    forEach,
    isArray,
    isNumber,
    isString,
    toNumber,
    toString,
} from "lodash";
import moment = require("moment");
import ErrorException from "../errors/ErrorException";
import ErrorGate from "../errors/ErrorGate";
import { IParamInfo, IParamsInfo } from "../ICCTParams";
import ICCTParams from "../ICCTParams";
import IContext from "../IContext";

export function isEmpty(value: any, allowEmptyString: boolean = false) {
    return (
        value == null ||
        (allowEmptyString ? false : value === "") ||
        (isArray(value) && value.length === 0)
    );
}

export function dateBetween(date: Date, fromDate: Date, toDate: Date) {
    return date >= fromDate && date <= toDate;
}

function parseParam(conf: IParamInfo, value: any) {
    switch (conf.type) {
        case "string":
        case "password":
            return toString(value);
        case "boolean": {
            if (isString(value)) {
                return value === "true";
            }
            return !!value;
        }
        case "integer":
        case "numeric":
            return toNumber(value);
        case "date":
            return moment(value).toDate();
    }
}
/**
 * Функция для инициализации параметров в случаеесли нет обязательных параметров выкинет ErrorException
 * @param conf Настройки плагинов
 * @param param Параметры
 * @returns params Объект с параметрами
 */
export function initParams(conf: IParamsInfo, param: ICCTParams = {}): any {
    const notFound = [];
    const result = { ...param };
    forEach(conf, (value, key) => {
        if (!isEmpty(param[key])) {
            result[key] = parseParam(value, param[key]);
        } else if (
            isEmpty(param[key]) &&
            isEmpty(value.defaultValue) &&
            value.required
        ) {
            notFound.push(key);
        } else if (isEmpty(param[key]) && !isEmpty(value.defaultValue)) {
            result[key] = value.defaultValue;
        }
    });
    if (notFound.length) {
        throw new ErrorException(
            ErrorGate.compileErrorResult(
                -1,
                `Not found require params ${notFound.join(",")}`,
            ),
        );
    }
    return result;
}

const formatStr = {
    1: "year",
    2: "month",
    3: "day",
    4: "hour",
    5: "minute",
    6: "second",
};

export function sortFilesData(gateContext: IContext) {
    if (isEmpty(gateContext.params.json)) {
        return (obj1, obj2) => obj1 > obj2;
    }
    const json = JSON.parse(gateContext.params.json, (key, value) => {
        if (value === null) {
            return undefined;
        }
        return value;
    });
    const jlSort = json.filter.jl_sort;
    if (!isEmpty(jlSort)) {
        return (obj1, obj2) =>
            jlSort.reduce((val, item) => {
                if (isEmpty(item.property) || isEmpty(item.direction)) {
                    return obj1 > obj2;
                }
                const { datatype, format = "3", property } = item;
                const nmColumn = property;
                const direction = item.direction.toUpperCase();
                const val1 = obj1[nmColumn];
                const val2 = obj2[nmColumn];
                if (
                    datatype === "date" ||
                    nmColumn.startsWith("cd_") ||
                    nmColumn.startsWith("ct_")
                ) {
                    return (
                        val +
                        moment(direction === "ASC" ? val1 : val2).diff(
                            moment(direction === "ASC" ? val2 : val1),
                            formatStr[format],
                        )
                    );
                }
                if (isNumber(val1) && isNumber(val2)) {
                    return (
                        val + (direction === "ASC" ? val1 - val2 : val2 - val1)
                    );
                }
                if (isString(val1) && isString(val2)) {
                    return (
                        val +
                        (
                            (direction === "ASC" ? val1 : val2) || ""
                        ).localeCompare(
                            (direction === "ASC" ? val2 : val1) || "",
                        )
                    );
                }
                return +(direction === "ASC" ? val1 > val2 : val2 > val1);
            }, 0);
    }
    return (obj1, obj2) => obj1 > obj2;
}

export function filterFilesData(gateContext: IContext) {
    if (isEmpty(gateContext.params.json)) {
        return () => true;
    }
    const json = JSON.parse(gateContext.params.json, (key, value) => {
        if (value === null) {
            return undefined;
        }
        return value;
    });
    const jlFilter = json.filter.jl_filter;
    if (!isEmpty(jlFilter)) {
        return (obj) =>
            jlFilter.every((item) => {
                if (isEmpty(item.property)) {
                    return true;
                }
                if (isEmpty(item.operator)) {
                    return true;
                }
                const { datatype, format = "3", property } = item;
                const nmColumn = property;
                const operator = item.operator.toLowerCase();
                let value = item.value;
                if (isEmpty(value)) {
                    return true;
                }

                if (
                    datatype === "date" ||
                    nmColumn.startsWith("cd_") ||
                    nmColumn.startsWith("ct_")
                ) {
                    value = moment(value);
                }

                switch (operator) {
                    case "gt":
                    case ">":
                        if (
                            datatype === "date" ||
                            nmColumn.startsWith("cd_") ||
                            nmColumn.startsWith("ct_")
                        ) {
                            return moment(obj[nmColumn]).isAfter(
                                value,
                                formatStr[format],
                            );
                        }
                        return obj[nmColumn] > value;
                    case "ge":
                    case ">=":
                        if (
                            datatype === "date" ||
                            nmColumn.startsWith("cd_") ||
                            nmColumn.startsWith("ct_")
                        ) {
                            return moment(obj[nmColumn]).isSameOrAfter(
                                value,
                                formatStr[format],
                            );
                        }
                        return obj[nmColumn] >= value;
                    case "lt":
                    case "<":
                        if (
                            datatype === "date" ||
                            nmColumn.startsWith("cd_") ||
                            nmColumn.startsWith("ct_")
                        ) {
                            return moment(obj[nmColumn]).isBefore(
                                value,
                                formatStr[format],
                            );
                        }
                        return obj[nmColumn] < value;
                    case "le":
                    case "<=":
                        if (
                            datatype === "date" ||
                            nmColumn.startsWith("cd_") ||
                            nmColumn.startsWith("ct_")
                        ) {
                            return moment(obj[nmColumn]).isSameOrBefore(
                                value,
                                formatStr[format],
                            );
                        }
                        return obj[nmColumn] <= value;
                    case "eq":
                    case "=":
                        if (
                            datatype === "date" ||
                            nmColumn.startsWith("cd_") ||
                            nmColumn.startsWith("ct_")
                        ) {
                            return moment(obj[nmColumn]).isSame(
                                value,
                                formatStr[format],
                            );
                        }
                        return `${obj[nmColumn]}` === `${value}`;
                    case "like": {
                        const reg = new RegExp(value, "gi");
                        return reg.test(`${obj[nmColumn]}`);
                    }
                    case "in":
                        return value.indexOf(obj[nmColumn]) > -1;
                    case "not in":
                        return value.indexOf(obj[nmColumn]) === -1;
                    default:
                        return true;
                }
            });
    }
    return () => true;
}