const hasuraQuery = require("../hasura-queries/users")
const ApiError = require('../exceptions/api-error')
const tokenService = require('./token-service');

class UserService {

    jwtPayload(o) {
        return {
            'UserID': o.UserID,
            'FirstName': o.FirstName,
            'LastName': o.LastName,
            'Email': o.Email,
        }
    }

    async login(req){
        const {email, password} = req.body;
        const users = await hasuraQuery.getUsers();
        const user = users.find(el => el.Email === email);

        if (!user) {
            throw ApiError.BadRequest('Нет пользователя с таким email)');
        }
        if (password !== user["Password"]) {
            throw ApiError.BadRequest('Упс.. Похоже вы ошиблись паролем');
        }
        ///проверить есть ли просроченные токены у этого юзера
        const tokens = tokenService.generateTokens(this.jwtPayload(user));
        hasuraQuery.createToken(user.UserID, tokens.refreshToken);
        return {...tokens, user};
    }

    async logout(refreshToken) {
        const userID = await hasuraQuery.deleteToken(refreshToken);
        return userID;
    }

    async refresh(refreshToken){
        if (!refreshToken){
            throw ApiError.UnauthorizedError();
        }
        const responce = tokenService.validateRefreshToken(refreshToken); //responce: User or null
        const tokenFromDb = await tokenService.findToken(refreshToken);

        if (!responce || !tokenFromDb){
            throw ApiError.UnauthorizedError();
        }
        const user = this.jwtPayload(tokenFromDb.User);

        const newTokens = tokenService.generateTokens(user);
        await hasuraQuery.updateToken(tokenFromDb.ID, newTokens.refreshToken);
        return {...newTokens, user};
        
    }

    async getAllUsers(){
        const users = await hasuraQuery.getUsers();
        return users;
    }
}

module.exports = new UserService();