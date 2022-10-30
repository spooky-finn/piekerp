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
const HasuraClient_1 = __importDefault(require("../lib/HasuraClient"));
class HasuraAuthService extends HasuraClient_1.default {
    getUsers() {
        return __awaiter(this, void 0, void 0, function* () {
            const query = `{
            erp_Users {
                UserID
                FirstName
                LastName
                Email
                Password
                AccessLevelID
            }
               }`;
            const res = yield this._send(query);
            return res.data.erp_Users;
        });
    }
    getTokens() {
        return __awaiter(this, void 0, void 0, function* () {
            const query = `{
            erp_Tokens {
            ID
            RefreshToken
            User {
                UserID
                FirstName
                LastName
                Email
                AccessLevelID
            }
            }
        }`;
            const res = yield this._send(query);
            return res.data.erp_Tokens;
        });
    }
    createToken(UserID, refreshToken) {
        return __awaiter(this, void 0, void 0, function* () {
            var query = `mutation myMytation($UserID: Int!, $refreshToken: String!){
        insert_erp_Tokens(objects: {UserID: $UserID, RefreshToken: $refreshToken}) {
            returning {
                UserID
            }
        }
        }`;
            const variables = { UserID, refreshToken };
            const res = yield this._send(query, variables);
            return res.data.insert_erp_Tokens.returning;
        });
    }
    deleteToken(refreshToken) {
        return __awaiter(this, void 0, void 0, function* () {
            var query = `mutation myMytation($refreshToken: String!){
            delete_erp_Tokens(where: {RefreshToken: {_eq: $refreshToken}}) {
            returning {
                UserID
            }
            }
        }`;
            const variables = { refreshToken };
            const res = yield this._send(query, variables);
            console.log('dd', res.data.delete_erp_Tokens.returning);
            return res.data.delete_erp_Tokens.returning;
        });
    }
    updateToken(tokenID, refreshToken) {
        return __awaiter(this, void 0, void 0, function* () {
            var query = `mutation myMytation($tokenID: Int!, $refreshToken: String!){
        update_erp_Tokens_by_pk(pk_columns: {ID: $tokenID}, _set: {RefreshToken: $refreshToken}) {
          ID
          UserID
        }
     }`;
            const variables = { tokenID, refreshToken };
            const res = yield this._send(query, variables);
            return res.data.update_erp_Tokens_by_pk;
        });
    }
}
exports.default = new HasuraAuthService();
