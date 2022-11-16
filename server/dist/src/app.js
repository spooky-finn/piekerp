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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.app = void 0;
const cookie_parser_1 = __importDefault(require("cookie-parser"));
const cors_1 = __importDefault(require("cors"));
const express_1 = __importStar(require("express"));
const path_1 = require("path");
const config_1 = require("./config/config");
const error_middleware_1 = __importDefault(require("./middlewares/error.middleware"));
const routes_1 = require("./routes");
const CLIENT_BUILD_PATH = '../client/build';
exports.app = (0, express_1.default)();
// Static files
exports.app.use((0, express_1.static)(CLIENT_BUILD_PATH));
exports.app.use((0, express_1.urlencoded)({ extended: false }));
//Middlewares
exports.app.use((0, express_1.json)());
exports.app.use((0, cookie_parser_1.default)());
exports.app.use((0, cors_1.default)({
    credentials: true,
    origin: config_1.config.CORS_CLIENT_URL
}));
exports.app.use('/api', routes_1.router);
exports.app.use(error_middleware_1.default);
// All remaining requests return the React app, so it can handle routing.
exports.app.get('*', function (request, response) {
    response.sendFile((0, path_1.join)(CLIENT_BUILD_PATH, 'index.html'));
});
//# sourceMappingURL=app.js.map