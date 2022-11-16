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
Object.defineProperty(exports, "__esModule", { value: true });
const config_1 = require("../config/config");
const s3_clients_1 = require("../lib/s3-clients");
class S3Service {
    deleteObject(key, bucket) {
        return __awaiter(this, void 0, void 0, function* () {
            return s3_clients_1.mainS3Client
                .deleteObject({ Bucket: bucket, Key: key })
                .promise()
                .catch(err => {
                throw new Error(`Could not delete file from S3: ${err.message}`);
            });
        });
    }
    getObject(key) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                return yield s3_clients_1.mainS3Client.getObject({ Bucket: config_1.config.S3_BUCKET, Key: key }).promise();
            }
            catch (e) {
                throw new Error(`Could not retrieve file from S3: ${e.message}`);
            }
        });
    }
}
exports.default = new S3Service();
//# sourceMappingURL=s3.service.js.map