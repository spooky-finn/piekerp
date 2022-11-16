"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const http_status_codes_1 = __importDefault(require("http-status-codes"));
class ApiError extends Error {
    constructor(status, message, details, stack) {
        super(message);
        this.status = status;
        this.details = details;
        this.stack = stack;
    }
    static UnauthorizedError(message) {
        return new ApiError(http_status_codes_1.default.UNAUTHORIZED, message);
    }
    static BadRequest(message) {
        return new ApiError(http_status_codes_1.default.BAD_REQUEST, message);
    }
    static HasuraServiceError(message, details, stack) {
        return new ApiError(http_status_codes_1.default.INTERNAL_SERVER_ERROR, message, details, stack);
    }
}
exports.default = ApiError;
//# sourceMappingURL=api.error.js.map