"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const http_status_codes_1 = require("http-status-codes");
const api_error_1 = __importDefault(require("../exceptions/api.error"));
const constants_1 = require("../lib/constants");
function default_1(err, req, res, next) {
    if (err instanceof api_error_1.default) {
        return res.status(err.status).json({
            error: {
                message: err.message,
                code: err.status
            }
        });
    }
    return res
        .status(http_status_codes_1.StatusCodes.INTERNAL_SERVER_ERROR)
        .send(constants_1.StaticStringKeys.UNKNOWN_ERROR_TRY_AGAIN);
}
exports.default = default_1;
//# sourceMappingURL=error.middleware.js.map