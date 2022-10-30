"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
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
const node_fetch_1 = __importDefault(require("node-fetch"));
const api_error_1 = __importDefault(require("../exceptions/api-error"));
const dotenv = __importStar(require("dotenv"));
dotenv.config({ path: `../.env` });
class HasuraClient {
    constructor() {
        this.endpoint = process.env.HASURA_ENDPOINT;
        if (this.constructor == HasuraClient) {
            throw new Error("Abstract classes can't be instantiated.");
        }
    }
    _send(query, variables) {
        return __awaiter(this, void 0, void 0, function* () {
            let responseData = yield (0, node_fetch_1.default)(this.endpoint, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    'x-hasura-admin-secret': process.env.HASURA_ADMIN_SECRET,
                },
                body: JSON.stringify({ query: query, variables: variables })
            });
            const res = yield responseData.json();
            if (res.errors) {
                throw api_error_1.default.HasuraServiceError('hasura-service-error', res.errors);
            }
            return res;
        });
    }
}
exports.default = HasuraClient;
