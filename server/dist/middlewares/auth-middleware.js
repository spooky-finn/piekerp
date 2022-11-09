"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const api_error_1 = __importDefault(require("../exceptions/api-error"));
const token_service_1 = __importDefault(require("../service/token-service"));
function default_1(req, res, next) {
    try {
        const authorizationHeader = req.headers.authorization;
        if (!authorizationHeader) {
            return next(api_error_1.default.UnauthorizedError('invalid-credential'));
        }
        const accessToken = authorizationHeader.split(' ')[1];
        if (!accessToken) {
            return next(api_error_1.default.UnauthorizedError('invalid-token'));
        }
        const userData = token_service_1.default.validateAccessToken(accessToken);
        if (!userData) {
            return next(api_error_1.default.UnauthorizedError('invalid-token'));
        }
        // req.user = userData
        next();
    }
    catch (e) {
        next(api_error_1.default.UnauthorizedError());
    }
}
exports.default = default_1;
