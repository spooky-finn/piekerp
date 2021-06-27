const jwt = require('jsonwebtoken');
const hasuraQuery = require("../hasura-queries/users")
class TokenService {
    generateTokens(payload) {
        const accessToken = jwt.sign(payload, process.env.JWT_ACCESS_SECRET, {expiresIn: 3600})
        const refreshToken = jwt.sign(payload, process.env.JWT_REFRESH_SECRET, {expiresIn: 36000})
        return {
            accessToken, 
            refreshToken
        }
    }

    validateAccessToken(token){
        try {
            const userData = jwt.verify(token, process.env.JWT_ACCESS_SECRET);
            return userData;
        } catch (error) {
            return null;
        }
    }

    validateRefreshToken(token){
        try {
            const userData = jwt.verify(token, process.env.JWT_REFRESH_SECRET);
            return userData;
        } catch (error) {
            return null;
        }
    }

    async removeToken(refreshToken) {
        const users = await hasuraQuery.getUsers();
        const user = users.find(el => el.RefreshToken === refreshToken);
        const tokenData = hasuraQuery.updateToken(user.UserID, '');
        return tokenData;
    }   

    async findToken(refreshToken) {
        const users = await hasuraQuery.getUsers();
        const user = users.find(el => el.RefreshToken === refreshToken);
        return user;
    }

}

module.exports = new TokenService();