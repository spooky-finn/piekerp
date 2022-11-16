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
exports.database = void 0;
const node_fetch_1 = __importDefault(require("node-fetch"));
const api_error_1 = __importDefault(require("../exceptions/api.error"));
const config_1 = require("../config/config");
const schema_typedefs_1 = require("../../generated/schema-typedefs");
const graphql_1 = require("graphql");
const resolver = (doc, vars) => __awaiter(void 0, void 0, void 0, function* () {
    return (0, node_fetch_1.default)(config_1.config.HASURA_ENDPOINT, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'x-hasura-admin-secret': config_1.config.HASURA_ADMIN_SECRET
        },
        body: JSON.stringify({ query: (0, graphql_1.print)(doc), variables: vars })
    })
        .then(res => res.json())
        .then(json => {
        if (json.errors) {
            console.error(JSON.stringify(json.errors));
            throw api_error_1.default.HasuraServiceError('hasura-service-error', JSON.stringify(json.errors));
        }
        return json.data;
    });
});
exports.database = (0, schema_typedefs_1.getSdk)(resolver);
//# sourceMappingURL=graphql-client.js.map