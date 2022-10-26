import { onError } from '@apollo/client/link/error'
import { setContext } from '@apollo/client/link/context'
import { HttpLink, Observable } from '@apollo/client'

import { getInMemoryToken, getNewInMemoryToken } from '../../index'

const http_protocol = process.env.REACT_APP_NODE_ENV === 'development' ? 'http://' : 'https://'

export const httpErrorLink = onError(({ graphQLErrors, networkError, operation, forward }) => {
  return new Observable(observer => {
    getNewInMemoryToken()
      .then(newToken => {
        operation.setContext(({ headers = {} }) => ({
          headers: {
            // Re-add old headers
            ...headers,
            // Switch out old access token for new one
            Authorization: `Bearer ${newToken}` || null
          }
        }))
      })
      .then(() => {
        const subscriber = {
          next: observer.next.bind(observer),
          error: observer.error.bind(observer),
          complete: observer.complete.bind(observer)
        }
        // Retry last failed request
        forward(operation).subscribe(subscriber)
      })
      .catch(error => {
        // No refresh or client token available, we force user to login
        observer.error(error)
      })
  })
})

export const httpAuthLink = setContext((_, { headers }) => ({
  headers: {
    ...headers,
    Authorization: getInMemoryToken() ? `Bearer ${getInMemoryToken()}` : ''
  }
}))

export const httpLink = new HttpLink({
  uri: http_protocol + process.env.REACT_APP_HASURA_ENDPOINT
})
