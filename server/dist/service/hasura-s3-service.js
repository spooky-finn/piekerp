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
class HasuraS3Service extends HasuraClient_1.default {
    // add file metadata to hasura
    addFileInformation(objects) {
        return __awaiter(this, void 0, void 0, function* () {
            const query = ` 
        mutation MyMutation($objects: [erp_Docs_insert_input!]!) {
            insert_erp_Docs(objects: $objects) {
                returning {
                ID
                Key
                }
            }
        }`;
            const variables = { objects };
            const res = yield this._send(query, variables);
            return res.data.insert_erp_Docs.returning;
        });
    }
    removeFileInformation(Key) {
        return __awaiter(this, void 0, void 0, function* () {
            const query = `
        mutation MyMutation($Key: String!) {
            delete_erp_Docs(where: {Key: {_eq: $Key} }) {
                returning {
                Key
                }
            }
        }`;
            const variables = { Key };
            const res = yield this._send(query, variables);
            return res.data.delete_erp_Docs.returning;
        });
    }
}
exports.default = new HasuraS3Service();
