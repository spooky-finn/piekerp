"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
var router = (0, express_1.Router)();
const user_controller_1 = __importDefault(require("../controllers/user-controller"));
const s3_controller_1 = __importDefault(require("../controllers/s3-controller"));
const express_validator_1 = require("express-validator");
const auth_middleware_1 = __importDefault(require("../middlewares/auth-middleware"));
const multer_middleware_1 = __importDefault(require("../middlewares/multer-middleware"));
const order_controller_1 = __importDefault(require("../controllers/order-controller"));
router.post('/login', (0, express_validator_1.body)('email').isEmail(), user_controller_1.default.login);
router.post('/logout', user_controller_1.default.logout);
router.get('/refresh', user_controller_1.default.refresh);
// Yandex Cloud Object Storage
// Upload
router.put('/s3', [multer_middleware_1.default, s3_controller_1.default.uploadBinaryFiles]);
// GetFile
router.get('/s3/:key', s3_controller_1.default.getBinaryFile);
// DeleteFile
router.delete('/s3/:key', auth_middleware_1.default, s3_controller_1.default.removeSingleFile);
router.get('/backup/:key', s3_controller_1.default.getHasuraBackup);
router.get('/orders/unpaid', order_controller_1.default.getUnpaidOrders);
exports.default = router;
