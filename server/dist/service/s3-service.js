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
const s3_client_1 = __importDefault(require("../lib/s3-client"));
const querystring_1 = require("querystring");
class S3Service {
    deleteObject(key, bucket) {
        return __awaiter(this, void 0, void 0, function* () {
            const params = { Bucket: bucket, Key: key };
            return s3_client_1.default.deleteObject(params, function (err, data) {
                if (err)
                    throw new Error(`Could not delete file from S3: ${err.message}`);
                return data;
            });
        });
    }
    getObject(key) {
        return __awaiter(this, void 0, void 0, function* () {
            const params = { Bucket: process.env.S3_BUCKET, Key: key };
            try {
                const data = yield s3_client_1.default.getObject(params).promise();
                data.Metadata.originalname = (0, querystring_1.unescape)(data.Metadata.originalname);
                return data;
            }
            catch (e) {
                throw new Error(`Could not retrieve file from S3: ${e.message}`);
            }
        });
    }
}
exports.default = new S3Service();
