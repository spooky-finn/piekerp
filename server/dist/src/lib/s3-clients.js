"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.mainS3Client = exports.backupS3Client = void 0;
const aws_sdk_1 = __importDefault(require("aws-sdk"));
const config_1 = require("../config/config");
exports.backupS3Client = new aws_sdk_1.default.S3({
    accessKeyId: config_1.config.S3_BACKUP_SERVICE_ACCESS_KEY_ID,
    secretAccessKey: config_1.config.S3_BACKUP_SERVICE_SECRET_ACCESS_KEY,
    endpoint: config_1.config.S3_ENDPOINT,
    s3ForcePathStyle: true,
    signatureVersion: 'v4'
});
exports.mainS3Client = new aws_sdk_1.default.S3({
    accessKeyId: config_1.config.S3_ACCESS_KEY_ID,
    secretAccessKey: config_1.config.S3_SECRET_ACCESS_KEY,
    endpoint: config_1.config.S3_ENDPOINT,
    s3ForcePathStyle: true,
    signatureVersion: 'v4'
});
//# sourceMappingURL=s3-clients.js.map