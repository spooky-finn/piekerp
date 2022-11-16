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
const multer_1 = __importDefault(require("multer"));
const multer_s3_1 = __importStar(require("multer-s3"));
const v4_1 = __importDefault(require("uuid/v4"));
const config_1 = require("../config/config");
const s3_clients_1 = require("../lib/s3-clients");
const multerMiddleware = (0, multer_1.default)({
    storage: (0, multer_s3_1.default)({
        s3: s3_clients_1.mainS3Client,
        bucket: config_1.config.S3_BUCKET,
        storageClass: 'COLD',
        contentType: multer_s3_1.AUTO_CONTENT_TYPE,
        key: function (req, file, cb) {
            //generate unique file names to be saved on the server
            cb(null, (0, v4_1.default)());
        }
    })
}).array('files', 20);
exports.default = multerMiddleware;
//# sourceMappingURL=multer.middleware.js.map