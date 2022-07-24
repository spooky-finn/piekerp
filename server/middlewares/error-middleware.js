const ApiError = require("../exceptions/api-error");

module.exports = function (err, req, res, next) {
    if (err instanceof ApiError) {
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
    })
}