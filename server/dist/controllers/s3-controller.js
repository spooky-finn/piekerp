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
const api_error_1 = __importDefault(require("../exceptions/api-error"));
const hasura_s3_service_1 = __importDefault(require("../service/hasura-s3-service"));
const S3Clients_1 = __importDefault(require("../lib/S3Clients"));
class S3Controller {
    removeSingleFile(req, res, next) {
        return __awaiter(this, void 0, void 0, function* () {
            /**
            * Incoming request must contain a 'orderid'(integer) parameter in request headers.
            * The `Request` object will be populated with a `files` object containing
            * information about the processed file.
            *
            * hasuraUpload method adds file metadata into database using graphql server.
            */
            try {
                const key = req.params.key;
                const data = yield S3.deleteObject(key, process.env.S3_BUCKET).then((s3_responce) => __awaiter(this, void 0, void 0, function* () {
                    return yield hasura_s3_service_1.default.removeFileInformation(key);
                }));
                res.json(data);
            }
            catch (error) {
                next(error);
            }
        });
    }
    uploadBinaryFiles(req, res, next) {
        return __awaiter(this, void 0, void 0, function* () {
            /**
            * Incoming request must contain a 'orderid'(integer) parameter in request headers.
            * The `Request` object will be populated with a `files` object containing
            * information about the processed file.
            *
            * hasuraUpload method adds file metadata into database using graphql server.
            */
            try {
                const array_of_files = req.files.map(each => ({
                    'Key': each.key,
                    'OrderID': (req.headers.orderid),
                    'FileName': each.originalname,
                    'Size': each.size
                }));
                const data = yield hasura_s3_service_1.default.addFileInformation(array_of_files);
                res.send(data);
            }
            catch (error) {
                next(error);
            }
        });
    }
    getBinaryFile(req, res, next) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const data = yield S3Clients_1.default.mainS3Client.getObject(req.params.key, process.env.S3_BUCKET);
                const fileName = encodeURI(data.Metadata.originalname);
                res.set('Content-Type', data.ContentType);
                res.set('Content-Disposition', `inline;filename*=utf-8''${fileName}`);
                res.send(data.Body);
            }
            catch (error) {
                next(error);
            }
        });
    }
    getHasuraBackup(req, res, next) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const hasuraAdminSectret = req.query.hasura_admin_secret;
                const key = req.params.key;
                if (!hasuraAdminSectret)
                    throw api_error_1.default.BadRequest('query-didnt-contain-hasura_admin_secret');
                if (hasuraAdminSectret != process.env.HASURA_ADMIN_SECRET)
                    throw api_error_1.default.BadRequest('wrong-hasura_admin_secret-in-query');
                const params = { Bucket: process.env.S3_BACKUP_SERVICE_BUCKET, Key: key };
                const data = yield S3Clients_1.default.backupS3Client.getObject(params).promise();
                res.set('Content-Type', 'text/plain');
                res.set('Content-Disposition', `attachment; filename="db_dump.sql"`);
                return res.send(JSON.parse(data.Body));
            }
            catch (error) {
                next(error);
            }
        });
    }
}
exports.default = new S3Controller();
