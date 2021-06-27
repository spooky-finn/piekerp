const userService = require("../service/user-service");
const hasuraQuery = require("../hasura-queries/users")
const {validationResult} = require('express-validator');
const ApiError = require("../exceptions/api-error");



class UserController {

    async login(req, res, next){
        try{
            const errors = validationResult(req);
            if (!errors.isEmpty()){
                return next(ApiError.BadRequest('Ошибка валидации email', errors.array()))
            }
            
            const userData= await userService.login(req);

            res.cookie('refreshToken', userData.refreshToken, {maxAge: 30*24*60*60*1000, httpOnly: true});
            return res.json(userData);
        } catch(e){
            next(e);
        }

    }

    async logout(req, res, next){
        try {
            const {refreshToken} = req.cookies;
            const token = await userService.logout(refreshToken);
            res.clearCookie('refreshToken');
            return res.json(token);
        } catch (e) {
            next(e);
        }
    }

    async refresh(req, res, next){
       try {
           const {refreshToken} = req.cookies;
           const userData = await userService.refresh(refreshToken);
           res.cookie('refreshToken', userData.refreshToken, {maxAge: 30*24*60*60*1000, httpOnly: true});
           return res.json(userData);
       } catch (e) {
           next(e);
       }
 
    }

    async getUsers(req, res, next){
        try {
            const users = await userService.getAllUsers();
            return res.json(users);
        } catch (e) {
            next(e);
        }
    }
}

module.exports = new UserController();