"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const api_error_1 = __importDefault(require("../exceptions/api.error"));
const constants_1 = require("../lib/constants");
const token_service_1 = __importDefault(require("../service/token.service"));
function default_1(req, res, next) {
    try {
        const authorizationHeader = req.headers.authorization;
        if (!authorizationHeader) {
            return next(api_error_1.default.UnauthorizedError(constants_1.StaticStringKeys.MISSING_AUTH_HEADER));
        }
        const accessToken = authorizationHeader.split(' ')[1];
        if (!accessToken) {
            return next(api_error_1.default.UnauthorizedError(constants_1.StaticStringKeys.MISSING_AUTH_HEADER));
        }
        const userData = token_service_1.default.validateAccessToken(accessToken);
        if (!userData) {
            return next(api_error_1.default.UnauthorizedError(constants_1.StaticStringKeys.INVALID_ACCESS_TOKEN));
        }
        next();
    }
    catch (e) {
        next(api_error_1.default.UnauthorizedError(constants_1.StaticStringKeys.UNKNOWN_ERROR_TRY_AGAIN));
    }
}
exports.default = default_1;
//# sourceMappingURL=auth.middleware.js.map