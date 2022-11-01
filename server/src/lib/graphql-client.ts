import fetch from 'node-fetch'
import ApiError from '../exceptions/api.error'
import { config } from '../config/config'
import { getSdk, Requester } from '../../generated/schema-typedefs'
import { DocumentNode } from 'graphql'

class GraphQLClient {
  endpoint = config.HASURA_ENDPOINT

  constructor() {
    if (this.constructor == GraphQLClient) {
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

export default GraphQLClient

// “errors”: [{
//   “extensions”: {
//     “path”: “$.selectionSet.post.selectionSet.name”,
//     “code”: “validation-failed”
//   },
//     “message”: “field \”name\” not found in type: ‘post’”
//   }]
type ErrorResponse = {
  errors: {
    extensions: {
      path: string
      code: string
    }
    message: string
  }[]
}

const resolver: Requester = async <Responce, Vars>(
  doc: DocumentNode,
  vars?: Vars
): Promise<Responce> => {
  return fetch(config.HASURA_ENDPOINT, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'x-hasura-admin-secret': config.HASURA_ADMIN_SECRET
    },
    body: JSON.stringify({ query: doc, variables: vars })
  })
    .then(res => res.json() as unknown as Responce & ErrorResponse)
    .then(json => {
      if (json.errors) {
        console.error(json.errors[0].message)
        throw ApiError.HasuraServiceError('hasura-service-error')
      }
      return json
    })
}

export const database = getSdk(resolver)
