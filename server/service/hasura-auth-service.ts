import HasuraClient from '../lib/HasuraClient'

class HasuraAuthService extends HasuraClient {
  async getUsers() {
    const query = `{
            erp_Users {
                UserID
                FirstName
                LastName
                Email
                Password
                AccessLevelID
            }
               }`

    const res = await this._send(query)
    return res.data.erp_Users
  }

  async getTokens() {
    const query = `{
            erp_Tokens {
            ID
            RefreshToken
            User {
                UserID
                FirstName
                LastName
                Email
                AccessLevelID
            }
            }
        }`

    const res = await this._send(query)
    return res.data.erp_Tokens
  }

  async createToken(UserID, refreshToken) {
    var query = `mutation myMytation($UserID: Int!, $refreshToken: String!){
        insert_erp_Tokens(objects: {UserID: $UserID, RefreshToken: $refreshToken}) {
            returning {
                UserID
            }
        }
        }`

    const variables = { UserID, refreshToken }
    const res = await this._send(query, variables)
    return res.data.insert_erp_Tokens.returning
  }

  async deleteToken(refreshToken) {
    var query = `mutation myMytation($refreshToken: String!){
            delete_erp_Tokens(where: {RefreshToken: {_eq: $refreshToken}}) {
            returning {
                UserID
            }
            }
        }`

    const variables = { refreshToken }
    const res = await this._send(query, variables)
    console.log('dd', res.data.delete_erp_Tokens.returning)
    return res.data.delete_erp_Tokens.returning
  }

  async updateToken(tokenID, refreshToken) {
    var query = `mutation myMytation($tokenID: Int!, $refreshToken: String!){
        update_erp_Tokens_by_pk(pk_columns: {ID: $tokenID}, _set: {RefreshToken: $refreshToken}) {
          ID
          UserID
        }
     }`

    const variables = { tokenID, refreshToken }
    const res = await this._send(query, variables)
    return res.data.update_erp_Tokens_by_pk
  }
}
export default new HasuraAuthService()
