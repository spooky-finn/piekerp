import { Response, Request, NextFunction } from 'express'
import ApiError from '../exceptions/api-error'
import TokenService from '../service/token-service'

export default function (req: Request, res: Response, next: NextFunction) {
  try {
    const authorizationHeader = req.headers.authorization
    if (!authorizationHeader) {
      return next(ApiError.UnauthorizedError('invalid-credential'))
    }
    const accessToken = authorizationHeader.split(' ')[1]
    if (!accessToken) {
      return next(ApiError.UnauthorizedError('invalid-token'))
    }

    const userData = TokenService.validateAccessToken(accessToken)
    if (!userData) {
      return next(ApiError.UnauthorizedError('invalid-token'))
    }
    // req.user = userData
    next()
  } catch (e) {
    next(ApiError.UnauthorizedError('user-unauthorized'))
  }
}
