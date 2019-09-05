import ILocalDB from "./db/local/ILocalDB";
import IObjectParam from "./IObjectParam";
import ISession from "./ISession";

export interface IAuthController {
    /**
     * Обновляем кеш о юзерах
     */
    updateHashAuth(): Promise<void>;
    /**
     * Добавляем пользователей в кэш
     * @param idUser индификатор пользователя
     * @param nameProvider наименование провайдера
     * @param data Данные пользователя
     */
    addUser(
        idUser: string,
        nameProvider: string,
        data: IObjectParam,
    ): Promise<void>;
    /**
     * Получаем данные о пользователе
     * @param idUser индификатор пользователя
     * @param nameProvider наименование провайдера
     */
    getDataUser(
        idUser: string,
        nameProvider: string,
        isAccessErrorNotFound?: boolean,
    ): Promise<IObjectParam | null>;
    /**
     * Создание сессии
     * @param idUser индификатор пользователя
     * @param nameProvider наименование провайдера
     * @param data данные пользователя
     * @param sessionDuration время жизни сессии в минутах
     */
    createSession(
        idUser: string,
        nameProvider: string,
        data: IObjectParam,
        sessionDuration: number,
    ): Promise<IObjectParam>;
    /**
     * Обновление информации у пользователя/пользователей
     * @param nameProvider наименование провайдера
     * @param ckUser индификатор пользовател
     */
    updateUserInfo(nameProvider?: string, ckUser?: string);
    /**
     * Локальная база пользователей
     * @returns user db
     */
    getUserDb(): ILocalDB;
    /**
     * Загрузка сессии
     * @param [sessionId]
     * @returns session
     */
    loadSession(
        sessionId?: string,
        idUser?: string,
        nameProvider?: string,
    ): ISession;
}
export default interface IGlobalObject extends NodeJS.Global {
    homedir: string;
    maskgate: any;
    property: any;
    authController: IAuthController;
    /**
     * Создание или загрузка ранее созданой темповой таблицы
     * @param name наименование
     */
    createTempTable(name: string): Promise<ILocalDB>;
}
