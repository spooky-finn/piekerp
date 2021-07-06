const jwt = require('jsonwebtoken');
const hasuraQuery = require("../hasura-queries/users")

class TokenService {
    generateTokens(payload) {
        const accessToken = jwt.sign(payload, process.env.JWT_ACCESS_SECRET, {expiresIn: process.env.JWT_ACCESS_SECRET_EXPIRES})
        const refreshToken = jwt.sign(payload, process.env.JWT_REFRESH_SECRET, {expiresIn: process.env.JWT_REFRESH_SECRET_EXPIRES})
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

    async findToken(refreshToken) {
        const tokens = await hasuraQuery.getTokens();
        const obj = tokens.find(el => el.RefreshToken === refreshToken);
        return obj;
    }

}

module.exports = new TokenService();