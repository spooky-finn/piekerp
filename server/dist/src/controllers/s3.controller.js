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
const config_1 = require("../config/config");
const api_error_1 = __importDefault(require("../exceptions/api.error"));
const constants_1 = require("../lib/constants");
const graphql_client_1 = require("../lib/graphql-client");
const s3_clients_1 = require("../lib/s3-clients");
const s3_service_1 = __importDefault(require("../service/s3.service"));
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
                const data = yield s3_service_1.default.deleteObject(key, config_1.config.S3_BUCKET).then((s3_responce) => __awaiter(this, void 0, void 0, function* () {
                    return yield graphql_client_1.database.DeleteDocsMutation({ Key: key });
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
            if (!req.headers.orderid) {
                throw api_error_1.default.BadRequest(constants_1.StaticStringKeys.MISSING_ORDERID_HEADER);
            }
            try {
                const array_of_files = req.files.map(each => ({
                    Key: each.key,
                    OrderID: parseInt(req.headers.orderid),
                    FileName: each.originalname,
                    Size: each.size
                }));
                const data = (yield graphql_client_1.database.InsertDocsArrayMutation({ objects: array_of_files }))
                    .insert_erp_Docs.returning;
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
                const data = yield s3_service_1.default.getObject(req.params.key);
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
                const hasuraAdminSecret = req.query.hasura_admin_secret;
                const key = req.params.key;
                if (!hasuraAdminSecret) {
                    throw api_error_1.default.BadRequest('query-didnt-contain-hasura_admin_secret');
                }
                if (hasuraAdminSecret != config_1.config.HASURA_ADMIN_SECRET)
                    throw api_error_1.default.BadRequest('wrong-hasura_admin_secret-in-query');
                const data = yield s3_clients_1.backupS3Client
                    .getObject({
                    Bucket: config_1.config.S3_BACKUP_SERVICE_BUCKET,
                    Key: key,
                    ResponseContentEncoding: 'utf-8'
                })
                    .promise();
                res.set('Content-Type', 'text/plain');
                res.set('Content-Disposition', `attachment; filename="db_dump.sql"`);
                return res.json(data.Body.toString('utf-8'));
            }
            catch (error) {
                next(error);
            }
        });
    }
}
exports.default = new S3Controller();
//# sourceMappingURL=s3.controller.js.map