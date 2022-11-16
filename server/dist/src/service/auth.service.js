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
const api_error_1 = __importDefault(require("../exceptions/api.error"));
const constants_1 = require("../lib/constants");
const graphql_client_1 = require("../lib/graphql-client");
const token_service_1 = __importDefault(require("./token.service"));
class AuthService {
    formPayload(o) {
        return {
            'https://hasura.io/jwt/claims': {
                'x-hasura-allowed-roles': ['admin'],
                'x-hasura-default-role': 'admin'
            },
            UserID: o.UserID,
            FirstName: o.FirstName,
            LastName: o.LastName,
            Email: o.Email,
            AccessLevelID: o.AccessLevelID
        };
    }
    login(email, password) {
        return __awaiter(this, void 0, void 0, function* () {
            const users = (yield graphql_client_1.database.AllUsersQuery()).erp_Users;
            const user = users.find(el => el.Email === email);
            if (!user) {
                throw api_error_1.default.UnauthorizedError(constants_1.StaticStringKeys.INVALID_CREDENTIAL);
            }
            else if (password !== user['Password']) {
                throw api_error_1.default.UnauthorizedError(constants_1.StaticStringKeys.INVALID_CREDENTIAL);
            }
            ///нужно проверить есть ли просроченные токены у этого юзера
            const tokens = token_service_1.default.generateTokens(this.formPayload(user));
            const userCredentials = {
                UserID: user.UserID,
                FirstName: user.FirstName,
                LastName: user.LastName,
                Email: user.Email,
                AccessLevelID: user.AccessLevelID
            };
            yield graphql_client_1.database.InsertTokenMutation({ refreshToken: tokens.refreshToken, UserID: user.UserID });
            return Object.assign(Object.assign({}, tokens), { user: userCredentials });
        });
    }
    logout(refreshToken) {
        return __awaiter(this, void 0, void 0, function* () {
            yield graphql_client_1.database.DeleteTokenMutation({ refreshToken });
        });
    }
    refresh(refreshToken) {
        return __awaiter(this, void 0, void 0, function* () {
            if (!token_service_1.default.validateRefreshToken(refreshToken)) {
                throw api_error_1.default.UnauthorizedError(constants_1.StaticStringKeys.INVALID_REFRESH_TOKEN);
            }
            const tokenFromDb = yield token_service_1.default.findToken(refreshToken);
            if (!tokenFromDb) {
                throw api_error_1.default.UnauthorizedError('sdf');
            }
            const user = this.formPayload(tokenFromDb.User);
            const newTokens = token_service_1.default.generateTokens(user);
            yield graphql_client_1.database.UpdateTokenMutation({
                refreshToken: newTokens.refreshToken,
                tokenID: tokenFromDb.ID
            });
            return Object.assign(Object.assign({}, newTokens), { user });
        });
    }
}
exports.default = new AuthService();
//# sourceMappingURL=auth.service.js.map