import UserService from '../service/user-service'
import { validationResult } from 'express-validator'
import ApiError from '../exceptions/api-error'
import { Request, Response, NextFunction } from 'express'

class UserController {
  async login(req: Request, res: Response, next: NextFunction) {
    try {
      const emailVerificationError = validationResult(req)

      if (!emailVerificationError) throw ApiError.BadRequest('invalid-email-verified')

      const userCredentials = await UserService.login(req.body.email, req.body.password)

      res.cookie('refreshToken', userCredentials.refreshToken, {
        maxAge: 30 * 24 * 60 * 60 * 1000,
        httpOnly: true
      })
      return res.json(userCredentials)
    } catch (e) {
      next(e)
    }
  }

  async logout(req: Request, res: Response, next: NextFunction) {
    try {
      var refreshToken = req.cookies.refreshToken
      if (!refreshToken) throw ApiError.BadRequest('refrestToken not specified')

      const userID = await UserService.logout(refreshToken)
      res.clearCookie('refreshToken')
      return res.json(userID)
    } catch (e) {
      next(e)
    }
  }

  async refresh(req: Request, res: Response, next: NextFunction) {
    try {
      const { refreshToken } = req.cookies
      const userData = await UserService.refresh(refreshToken)
      res.cookie('refreshToken', userData.refreshToken, {
        maxAge: 30 * 24 * 60 * 60 * 1000,
        httpOnly: true
      })
      return res.json(userData)
    } catch (e) {
      next(e)
    }
  }

  async getUsers(req: Request, res: Response, next: NextFunction) {
    try {
      const users = await UserService.getAllUsers()
      return res.json(users)
    } catch (e) {
      next(e)
    }
  }
}

export default new UserController()
