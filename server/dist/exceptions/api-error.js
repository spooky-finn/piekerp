"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class ApiError extends Error {
    constructor(status, message, detail) {
        super(message);
        this.status = status;
        this.detail = detail;
    }
    static UnauthorizedError(message) {
        return new ApiError(401, message);
    }
    static BadRequest(message) {
        return new ApiError(400, message);
    }
    static HasuraServiceError(message, detail) {
        return new ApiError(500, message, detail);
    }
}
exports.default = ApiError;
