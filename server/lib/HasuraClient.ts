import fetch from 'node-fetch'
import ApiError from '../exceptions/api-error'
import { config } from '../config/config'

class HasuraClient {
  endpoint = config.HASURA_ENDPOINT

  constructor() {
    if (this.constructor == HasuraClient) {
      throw new Error("Abstract classes can't be instantiated.")
    }
  }

  protected async _send(query, variables?) {
    const responseData = await fetch(this.endpoint, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'x-hasura-admin-secret': config.HASURA_ADMIN_SECRET
      },
      body: JSON.stringify({ query: query, variables: variables })
    })
    const res = await responseData.json()

    if (res.errors) {
      throw ApiError.HasuraServiceError('hasura-service-error')
    }

    return res
  }
}

export default HasuraClient
