"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const aws_sdk_1 = __importDefault(require("aws-sdk"));
class S3Clients {
    constructor() {
        this.mainS3Client = new aws_sdk_1.default.S3({
            accessKeyId: process.env.S3_ACCESS_KEY_ID,
            secretAccessKey: process.env.S3_SECRET_ACCESS_KEY,
            endpoint: process.env.S3_ENDPOINT,
            s3ForcePathStyle: true,
            signatureVersion: 'v4',
        });
        this.backupS3Client = new aws_sdk_1.default.S3({
            accessKeyId: process.env.S3_BACKUP_SERVICE_ACCESS_KEY_ID,
            secretAccessKey: process.env.S3_BACKUP_SERVICE_SECRET_ACCESS_KEY,
            endpoint: process.env.S3_ENDPOINT,
            s3ForcePathStyle: true,
            signatureVersion: 'v4',
        });
    }
}
exports.default = new S3Clients();
