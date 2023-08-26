import {
  ApolloClient,
  HttpLink,
  InMemoryCache,
  NormalizedCacheObject,
  Observable,
  from,
  split
} from '@apollo/client'
import { setContext } from '@apollo/client/link/context'
import { onError } from '@apollo/client/link/error'
import { RetryLink } from '@apollo/client/link/retry'
import { WebSocketLink } from '@apollo/client/link/ws'
import { getMainDefinition } from '@apollo/client/utilities'
import axios, { AxiosInstance } from 'axios'
import { makeAutoObservable } from 'mobx'

export type TApolloClient = ApolloClient<NormalizedCacheObject>

interface TransportOpts {
  refreshAccessToken: () => Promise<string>
}

const apolloCache = new InMemoryCache({
  typePolicies: {
    erp_Orders: {
      keyFields: ['OrderID']
    },
    erp_CheckListUnits: {
      keyFields: ['CheckListUnitID']
    },
    erp_Comments: {
      keyFields: ['CommentID']
    },
    erp_Docs: {
      keyFields: ['ID']
    },
    erp_PaymentHistory: {
      keyFields: ['ID']
    }
  }
})

export const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:9000/api'
export const S3_URL = process.env.REACT_APP_API_URL + '/s3' || 'http://localhost:9000/api/s3'

const http_protocol = process.env.REACT_APP_NODE_ENV === 'development' ? 'http://' : 'https://'
const ws_protocol = process.env.REACT_APP_NODE_ENV === 'development' ? 'ws://' : 'wss://'

export default class Transport {
  public readonly apolloClient: TApolloClient
  public readonly restClient: AxiosInstance
  public accessToken: string | null = null

  constructor(opts: TransportOpts) {
    makeAutoObservable(this, {
      restClient: false
    })

    this.restClient = axios.create({
      withCredentials: true,
      baseURL: API_URL
    })

    this.restClient.interceptors.request.use(config => {
      config.headers = config.headers ?? {}
      config.headers.Authorization = `Bearer ${this.accessToken}`
      return config
    })

    const httpErrorLink = onError(({ graphQLErrors, networkError, operation, forward }) => {
      return new Observable(observer => {
        opts
          .refreshAccessToken()
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

    const httpAuthLink = setContext((_, { headers }) => ({
      headers: {
        ...headers,
        Authorization: this.accessToken ? `Bearer ${this.accessToken}` : ''
      }
    }))

    const httpLink = new HttpLink({
      uri: http_protocol + process.env.REACT_APP_HASURA_ENDPOINT
    })

    const webSocketLink = new WebSocketLink({
      uri: ws_protocol + process.env.REACT_APP_HASURA_ENDPOINT,
      // https://github.com/apollographql/subscriptions-transport-ws/issues/171
      options: {
        reconnect: true,
        lazy: true,
        // reconnectionAttempts: 5,
        // inactivityTimeout: 10000000,
        connectionParams: () => ({
          headers: {
            authorization: `Bearer ${this.accessToken}`
          }
        })
      }
    })

    const wsRetryLink = new RetryLink({
      delay: {
        initial: 300,
        max: Infinity,
        jitter: true
      },
      attempts: {
        max: 100,
        retryIf: (error, _operation) => !!error
      }
    })

    const wsErrorLink = onError(({ graphQLErrors, networkError, operation, forward }) => {
      // Error when jwt token expired
      if (networkError) {
        console.log('[Network error]: ', networkError)
      }

      if (graphQLErrors)
        graphQLErrors.forEach(({ message, locations, path }) =>
          console.log(`[GraphQL error]: Message: ${message}, Location: ${locations}, Path: ${path}`)
        )
    })

    const splitLink = split(
      ({ query }) => {
        const definition = getMainDefinition(query)

        return definition.kind === 'OperationDefinition' && definition.operation === 'subscription'
      },
      from([wsRetryLink, wsErrorLink, webSocketLink]),
      from([httpErrorLink, httpAuthLink, httpLink])
    )

    this.apolloClient = new ApolloClient({
      link: from([wsRetryLink, wsErrorLink, webSocketLink]),
      cache: apolloCache
    })
  }

  get ready(): boolean {
    return Boolean(this.accessToken && this.apolloClient && this.restClient)
  }
}
