const errio = require("errio");
const utils = require("nedb-multi/lib/utils");
const MSG = require("msgpack-lite");

module.exports = function rpc(socket, options, method, args) {
    const dataOnlyArgs = args;
    let callback;

    if (utils.endsWithCallback(args)) {
        callback = dataOnlyArgs.pop();
    }

    socket.send(options, method, MSG.encode(dataOnlyArgs), (BReplyArgs) => {
        const replyArgs = MSG.decode(BReplyArgs);
        if (callback) {
            if (replyArgs[0] !== null) {
                replyArgs[0] = errio.parse(replyArgs[0]); // eslint-disable-line no-param-reassign
            }

            callback(...replyArgs);
        }
    });
};
