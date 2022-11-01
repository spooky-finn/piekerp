import fetch from 'node-fetch'
import ApiError from '../exceptions/api.error'
import { config } from '../config/config'
import { getSdk, Requester } from '../../generated/schema-typedefs'
import { DocumentNode, parse, print as stringifyGraphqlNode } from 'graphql'

type GraphQLErrorResult = {
  errors: {
    extensions: {
      path: string
      code: string
    }
    message: string
  }[]
}

type GrapqhQLDataResult<RData> = {
  data: RData
}

const resolver: Requester = async <RData, Vars>(doc: DocumentNode, vars?: Vars): Promise<RData> => {
  return fetch(config.HASURA_ENDPOINT, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'x-hasura-admin-secret': config.HASURA_ADMIN_SECRET
    },
    body: JSON.stringify({ query: stringifyGraphqlNode(doc), variables: vars })
  })
    .then(res => res.json() as unknown as GrapqhQLDataResult<RData> & GraphQLErrorResult)
    .then(json => {
      if (json.errors) {
        console.error(JSON.stringify(json.errors))
        throw ApiError.HasuraServiceError('hasura-service-error')
      }
      return json.data
    })
}

export const database = getSdk(resolver)
