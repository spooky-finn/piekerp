import jwt from 'jsonwebtoken'
import { config } from '../config/config'
import hasuraService from './hasura-auth-service'

class TokenService {
  generateTokens(payload: any) {
    const accessToken = jwt.sign(payload, config.JWT_ACCESS_SECRET, {
      expiresIn: config.JWT_ACCESS_SECRET_EXPIRES
    })
    const refreshToken = jwt.sign(payload, config.JWT_REFRESH_SECRET, {
      expiresIn: config.JWT_REFRESH_SECRET_EXPIRES
    })
    return {
      accessToken,
      refreshToken
    }
  }

  validateAccessToken(token: string) {
    try {
      const userData = jwt.verify(token, config.JWT_ACCESS_SECRET)
      return userData
    } catch (error) {
      return null
    }
  }

  validateRefreshToken(token: string) {
    try {
      const userData = jwt.verify(token, config.JWT_REFRESH_SECRET)
      return userData
    } catch (error) {
      return null
    }
  }

  async findToken(refreshToken: string) {
    const tokens = await hasuraService.getTokens()
    const obj = tokens.find(el => el.RefreshToken === refreshToken)
    return obj
  }
}

export default new TokenService()
