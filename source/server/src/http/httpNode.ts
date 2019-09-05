/**
 * Created by artemov_i on 04.12.2018.
 */
import { IRequest } from "@ungate/plugininf/lib/IContext";
import Logger from "@ungate/plugininf/lib/Logger";
import {
    initProcess,
    sendProcess,
} from "@ungate/plugininf/lib/util/ProcessSender";
import * as compression from "compression";
import * as http from "http";
import { noop } from "lodash";
import * as Router from "router";
import Constants from "../core/Constants";
import PluginManager from "../core/pluginmanager/PluginManager";
import IContextConfig from "../core/property/IContextConfig";
import Property from "../core/property/Property";
import RequestContext from "../core/request/RequestContext";
import GateSession from "../core/session/GateSession";
import BodyParse from "./BodyParse";
import GlobalController from "./controllers/GlobalController";
import MainController from "./controllers/MainController";
import NotificationController from "./controllers/NotificationController";
import ProcessController from "./controllers/ProcessController";
import ResultController from "./controllers/ResultController";
const log = Logger.getLogger("HttpServer");

class HttpServer {
    private route: any;

    /**
     * Инициализация машрутов
     */
    public async initRoute() {
        this.route = Router();
        this.route.use(compression());
        const contextDb = await Property.getContext();
        const contexts = await contextDb.find({});
        contexts.forEach((obj) => {
            const doc = obj as IContextConfig;
            const gateContext = PluginManager.getGateContext(doc.ck_id);
            const route = Router({
                mergeParams: true,
            });
            this.route.use(doc.cv_path, route);
            route.use(BodyParse(gateContext));
            route.all("/", (req, res) => {
                MainController.execute(
                    new RequestContext(req as IRequest, res, gateContext),
                ).then(noop, (err) => log.trace(err));
            });
        });
    }

    /**
     * Запуск сервера
     */
    public async start(): Promise<any> {
        await GateSession.init();
        GlobalController();
        await PluginManager.initGate();
        await this.initRoute();
        await MainController.init();
        await ProcessController.init();
        initProcess(ProcessController, "cluster");
        // tslint:disable-next-line:no-shadowed-variable
        const HttpServer = http.createServer((req, res) => {
            this.route(req, res, (err) => {
                if (err) {
                    log.warn(err);
                }
                if (err && err.gateContext) {
                    ResultController.responseCheck(
                        new RequestContext(
                            req as IRequest,
                            res,
                            err.gateContext,
                        ),
                        null,
                        err,
                    );
                    return;
                }
                const error = JSON.stringify({
                    err_code: 404,
                    err_text: `\`${req.url}\` is not an implemented route`,
                    metaData: { responseTime: 0.0 },
                    success: false,
                });
                res.writeHead(404, {
                    "Content-Length": Buffer.byteLength(error),
                    "Content-Type": Constants.JSON_CONTENT_TYPE,
                });
                res.end(error);
            });
        });
        HttpServer.timeout = 86400000;
        HttpServer.setTimeout(86400000);
        await NotificationController.init(HttpServer);

        HttpServer.listen(Constants.HTTP_PORT);
    }
}
const server = new HttpServer();
server.start().then(
    () => {
        sendProcess({
            command: "startedCluster",
            data: {},
            target: "master",
        });
        log.info("HTTP server started!");
    },
    (err) => log.error(`HTTP Server fail start\n${err.message}`, err),
);

export default server;
