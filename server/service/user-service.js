const hasuraService = require("./hasura-auth-service")
const ApiError = require('../exceptions/api-error')
const tokenService = require('./token-service');

class UserService {

    jwtPayload(o) {
        return {
            "https://hasura.io/jwt/claims": {
                "x-hasura-allowed-roles": ["admin"],
                "x-hasura-default-role": "admin",
            },
            'UserID': o.UserID,
            'FirstName': o.FirstName,
            'LastName': o.LastName,
            'Email': o.Email,
            'AccessLevelID': o.AccessLevelID,
        }
    }

    async login(req) {
        const { email, password } = req.body;
        const users = await hasuraService.getUsers();

        const user = users.find(el => el.Email === email);

        if (!user)
            throw ApiError.UnauthorizedError('user-not-found')
        else if (password !== user["Password"])
            throw ApiError.UnauthorizedError("wrong-password")

        ///нужно проверить есть ли просроченные токены у этого юзера

        const tokens = tokenService.generateTokens(this.jwtPayload(user));

        const userCredentials = {
            UserID: user.UserID,
            FirstName: user.FirstName,
            LastName: user.LastName,
            Email: user.Email,
            AccessLevelID: user.AccessLevelID,
        }
        await hasuraService.createToken(user.UserID, tokens.refreshToken)
        return { ...tokens, user: userCredentials };
    }

    async logout(refreshToken) {
        const userID = await hasuraService.deleteToken(refreshToken);
        return userID;
    }

    async refresh(refreshToken) {
        if (!refreshToken) {
            throw ApiError.UnauthorizedError();
        }
        const responce = tokenService.validateRefreshToken(refreshToken); //responce: User or null
        const tokenFromDb = await tokenService.findToken(refreshToken);

        if (!responce || !tokenFromDb) {
            throw ApiError.UnauthorizedError();
        }
        const user = this.jwtPayload(tokenFromDb.User);

        const newTokens = tokenService.generateTokens(user);
        await hasuraService.updateToken(tokenFromDb.ID, newTokens.refreshToken);
        return { ...newTokens, user };

    }

    async getAllUsers() {
        const users = await hasuraService.getUsers();
        return users;
    }
}

module.exports = new UserService();