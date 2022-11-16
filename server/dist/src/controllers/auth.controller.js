"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_validator_1 = require("express-validator");
const api_error_1 = __importDefault(require("../exceptions/api.error"));
const constants_1 = require("../lib/constants");
const auth_service_1 = __importDefault(require("../service/auth.service"));
class UserController {
    login(req, res, next) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const errors = (0, express_validator_1.validationResult)(req);
                if (!errors.isEmpty() && errors.array().every(each => each.param == 'email')) {
                    throw api_error_1.default.BadRequest(constants_1.StaticStringKeys.INVALID_EMAIL);
                }
                const userCredentials = yield auth_service_1.default.login(req.body.email, req.body.password);
                res.cookie('refreshToken', userCredentials.refreshToken, {
                    maxAge: 30 * 24 * 60 * 60 * 1000,
                    httpOnly: true
                });
                return res.json(userCredentials);
            }
            catch (e) {
                next(e);
            }
        });
    }
    logout(req, res, next) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const refreshToken = req.cookies.refreshToken;
                if (!refreshToken) {
                    throw api_error_1.default.BadRequest(constants_1.StaticStringKeys.INVALID_REFRESH_TOKEN);
                }
                const userID = yield auth_service_1.default.logout(refreshToken);
                res.clearCookie('refreshToken');
                return res.json(userID);
            }
            catch (e) {
                next(e);
            }
        });
    }
    refresh(req, res, next) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const { refreshToken } = req.cookies;
                if (!refreshToken) {
                    throw api_error_1.default.BadRequest(constants_1.StaticStringKeys.INVALID_REFRESH_TOKEN);
                }
                const userData = yield auth_service_1.default.refresh(refreshToken);
                res.cookie('refreshToken', userData.refreshToken, {
                    maxAge: 30 * 24 * 60 * 60 * 1000,
                    httpOnly: true
                });
                return res.json(userData);
            }
            catch (e) {
                next(e);
            }
        });
    }
}
exports.default = new UserController();
//# sourceMappingURL=auth.controller.js.map