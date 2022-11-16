"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.UserController = exports.S3Controller = exports.OrderController = void 0;
var order_controller_1 = require("./order.controller");
Object.defineProperty(exports, "OrderController", { enumerable: true, get: function () { return __importDefault(order_controller_1).default; } });
var s3_controller_1 = require("./s3.controller");
Object.defineProperty(exports, "S3Controller", { enumerable: true, get: function () { return __importDefault(s3_controller_1).default; } });
var auth_controller_1 = require("./auth.controller");
Object.defineProperty(exports, "UserController", { enumerable: true, get: function () { return __importDefault(auth_controller_1).default; } });
//# sourceMappingURL=index.js.map