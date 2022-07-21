const userService = require("../service/user-service");

const { validationResult } = require('express-validator');
const ApiError = require("../exceptions/api-error");

class UserController {
    async login(req, res, next) {
        try {
            const emailVerificationError = validationResult(req);

            if (!emailVerificationError)
                throw ApiError.BadRequest('invalid-email-verified')

            const userCredentials = await userService.login(req);

            res.cookie('refreshToken', userCredentials.refreshToken, { maxAge: 30 * 24 * 60 * 60 * 1000, httpOnly: true });
            return res.json(userCredentials);
        } catch (e) {
            next(e);
        }

    }

    async logout(req, res, next) {
        try {
            var refreshToken = req.cookies.refreshToken;
            if (!refreshToken)
                throw ApiError.BadRequest('refrestToken not specified')

            const userID = await userService.logout(refreshToken);
            res.clearCookie('refreshToken');
            return res.json(userID);
        } catch (e) {
            next(e);
        }
    }

    async refresh(req, res, next) {
        try {
            const { refreshToken } = req.cookies;
            const userData = await userService.refresh(refreshToken);
            res.cookie('refreshToken', userData.refreshToken, { maxAge: 30 * 24 * 60 * 60 * 1000, httpOnly: true });
            return res.json(userData);
        } catch (e) {
            next(e);
        }

    }

    async getUsers(req, res, next) {
        try {
            const users = await userService.getAllUsers();
            return res.json(users);
        } catch (e) {
            next(e);
        }
    }
}

module.exports = new UserController();