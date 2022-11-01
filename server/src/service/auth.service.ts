import ApiError from '../exceptions/api.error'
import { StaticStringKeys } from '../lib/constants'
import hasuraService from '../repositories/auth.repository'
import tokenService from './token.service'

class AuthService {
  formPayload(o) {
    return {
      'https://hasura.io/jwt/claims': {
        'x-hasura-allowed-roles': ['admin'],
        'x-hasura-default-role': 'admin'
      },
      UserID: o.UserID,
      FirstName: o.FirstName,
      LastName: o.LastName,
      Email: o.Email,
      AccessLevelID: o.AccessLevelID
    }
  }

  async login(email: string, password: string) {
    const users = await hasuraService.getUsers()

    const user = users.find(el => el.Email === email)

    if (!user) {
      throw ApiError.UnauthorizedError(StaticStringKeys.INVALID_CREDENTIAL)
    } else if (password !== user['Password']) {
      throw ApiError.UnauthorizedError(StaticStringKeys.INVALID_CREDENTIAL)
    }
    ///нужно проверить есть ли просроченные токены у этого юзера
    const tokens = tokenService.generateTokens(this.formPayload(user))

    const userCredentials = {
      UserID: user.UserID,
      FirstName: user.FirstName,
      LastName: user.LastName,
      Email: user.Email,
      AccessLevelID: user.AccessLevelID
    }
    await hasuraService.createToken(user.UserID, tokens.refreshToken)
    return { ...tokens, user: userCredentials }
  }

  async logout(refreshToken: string) {
    const userID = await hasuraService.deleteToken(refreshToken)
    return userID
  }

  async refresh(refreshToken: string) {
    if (!tokenService.validateRefreshToken(refreshToken)) {
      throw ApiError.UnauthorizedError(StaticStringKeys.INVALID_REFRESH_TOKEN)
    }

    const tokenFromDb = await tokenService.findToken(refreshToken)

    if (!tokenFromDb) {
      throw ApiError.UnauthorizedError('sdf')
    }

    const user = this.formPayload(tokenFromDb.User)

    const newTokens = tokenService.generateTokens(user)
    await hasuraService.updateToken(tokenFromDb.ID, newTokens.refreshToken)
    return { ...newTokens, user }
  }
}

export default new AuthService()
