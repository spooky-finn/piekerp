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
const user_service_1 = __importDefault(require("../service/user-service"));
const express_validator_1 = require("express-validator");
const api_error_1 = __importDefault(require("../exceptions/api-error"));
class UserController {
    login(req, res, next) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const emailVerificationError = (0, express_validator_1.validationResult)(req);
                if (!emailVerificationError)
                    throw api_error_1.default.BadRequest('invalid-email-verified');
                const userCredentials = yield user_service_1.default.login(req);
                res.cookie('refreshToken', userCredentials.refreshToken, { maxAge: 30 * 24 * 60 * 60 * 1000, httpOnly: true });
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
                var refreshToken = req.cookies.refreshToken;
                if (!refreshToken)
                    throw api_error_1.default.BadRequest('refrestToken not specified');
                const userID = yield user_service_1.default.logout(refreshToken);
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
                const userData = yield user_service_1.default.refresh(refreshToken);
                res.cookie('refreshToken', userData.refreshToken, { maxAge: 30 * 24 * 60 * 60 * 1000, httpOnly: true });
                return res.json(userData);
            }
            catch (e) {
                next(e);
            }
        });
    }
    getUsers(req, res, next) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const users = yield user_service_1.default.getAllUsers();
                return res.json(users);
            }
            catch (e) {
                next(e);
            }
        });
    }
}
exports.default = new UserController();
