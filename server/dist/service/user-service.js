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
const hasura_auth_service_1 = __importDefault(require("./hasura-auth-service"));
const api_error_1 = __importDefault(require("../exceptions/api-error"));
const token_service_1 = __importDefault(require("./token-service"));
class UserService {
    jwtPayload(o) {
        return {
            "https://hasura.io/jwt/claims": {
                "x-hasura-allowed-roles": ["admin"],
                "x-hasura-default-role": "admin",
            },
            'UserID': o.UserID,
            'FirstName': o.FirstName,
            'LastName': o.LastName,
            'Email': o.Email,
            'AccessLevelID': o.AccessLevelID,
        };
    }
    login(req) {
        return __awaiter(this, void 0, void 0, function* () {
            const { email, password } = req.body;
            const users = yield hasura_auth_service_1.default.getUsers();
            const user = users.find(el => el.Email === email);
            if (!user)
                throw api_error_1.default.UnauthorizedError('user-not-found');
            else if (password !== user["Password"])
                throw api_error_1.default.UnauthorizedError("wrong-password");
            ///нужно проверить есть ли просроченные токены у этого юзера
            const tokens = token_service_1.default.generateTokens(this.jwtPayload(user));
            const userCredentials = {
                UserID: user.UserID,
                FirstName: user.FirstName,
                LastName: user.LastName,
                Email: user.Email,
                AccessLevelID: user.AccessLevelID,
            };
            yield hasura_auth_service_1.default.createToken(user.UserID, tokens.refreshToken);
            return Object.assign(Object.assign({}, tokens), { user: userCredentials });
        });
    }
    logout(refreshToken) {
        return __awaiter(this, void 0, void 0, function* () {
            const userID = yield hasura_auth_service_1.default.deleteToken(refreshToken);
            return userID;
        });
    }
    refresh(refreshToken) {
        return __awaiter(this, void 0, void 0, function* () {
            if (!refreshToken) {
                throw api_error_1.default.UnauthorizedError();
            }
            const responce = token_service_1.default.validateRefreshToken(refreshToken); //responce: User or null
            const tokenFromDb = yield token_service_1.default.findToken(refreshToken);
            if (!responce || !tokenFromDb) {
                throw api_error_1.default.UnauthorizedError();
            }
            const user = this.jwtPayload(tokenFromDb.User);
            const newTokens = token_service_1.default.generateTokens(user);
            yield hasura_auth_service_1.default.updateToken(tokenFromDb.ID, newTokens.refreshToken);
            return Object.assign(Object.assign({}, newTokens), { user });
        });
    }
    getAllUsers() {
        return __awaiter(this, void 0, void 0, function* () {
            const users = yield hasura_auth_service_1.default.getUsers();
            return users;
        });
    }
}
exports.default = new UserService();
