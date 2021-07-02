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

        const tokens = tokenService.generateTokens(this.jwtPayload(user));
        hasuraQuery.updateToken(user.UserID, tokens.refreshToken);
        return {...tokens, 'user': this.jwtPayload(user)};
    }

    async logout(refreshToken) {
        const token = await tokenService.removeToken(refreshToken);
        return token;
    }

    async refresh(refreshToken){
        if (!refreshToken){
            throw ApiError.UnauthorizedError();
        }
        const userData = tokenService.validateRefreshToken(refreshToken);
        const userFromDb = await tokenService.findToken(refreshToken);
     
        if (!userData || !userFromDb){
            throw ApiError.UnauthorizedError();
        }

        const tokens = tokenService.generateTokens(this.jwtPayload(userFromDb));
        hasuraQuery.updateToken(userFromDb.UserID, tokens.refreshToken);
        return {...tokens, 'user': this.jwtPayload(userFromDb)};
        
    }

    async getAllUsers(){
        const users = await hasuraQuery.getUsers();
        return users;
    }
}

module.exports = new UserService();