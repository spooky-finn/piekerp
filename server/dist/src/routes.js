"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.router = void 0;
const express_1 = require("express");
const express_validator_1 = require("express-validator");
const auth_middleware_1 = __importDefault(require("./middlewares/auth.middleware"));
const multer_middleware_1 = __importDefault(require("./middlewares/multer.middleware"));
const controllers_1 = require("./controllers");
exports.router = (0, express_1.Router)();
exports.router.post('/login', (0, express_validator_1.body)('email').isEmail(), controllers_1.UserController.login);
exports.router.post('/logout', controllers_1.UserController.logout);
exports.router.get('/refresh', controllers_1.UserController.refresh);
// Yandex Cloud Object Storage
// Upload
exports.router.put('/s3', [multer_middleware_1.default, controllers_1.S3Controller.uploadBinaryFiles]);
// GetFile
exports.router.get('/s3/:key', controllers_1.S3Controller.getBinaryFile);
// DeleteFile
exports.router.delete('/s3/:key', auth_middleware_1.default, controllers_1.S3Controller.removeSingleFile);
exports.router.get('/backup/:key', controllers_1.S3Controller.getHasuraBackup);
exports.router.get('/orders/unpaid', controllers_1.OrderController.getUnpaidOrders);
//# sourceMappingURL=routes.js.map