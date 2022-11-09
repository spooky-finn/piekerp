"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const api_error_1 = __importDefault(require("../exceptions/api-error"));
function default_1(err, req, res, next) {
    console.log(err, req);
    if (err instanceof api_error_1.default) {
        return res.status(err.status).json({
            error: {
                message: err.message,
                code: err.status,
                detail: err.detail
            }
        });
    }
    return res.status(500).json({
        error: {
            message: err.message,
            code: err.status
        }
    });
}
exports.default = default_1;
