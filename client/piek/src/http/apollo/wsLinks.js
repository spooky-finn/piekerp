import { onError } from '@apollo/client/link/error';
import { WebSocketLink } from '@apollo/client/link/ws';
import { RetryLink } from "@apollo/client/link/retry";

import { getInMemoryToken, getNewInMemoryToken } from '../../index'

const ws_protocol = process.env.REACT_APP_NODE_ENV === 'development' ? 'ws://' : 'wss://'

export const wsRetryLink = new RetryLink({
  delay: {
    initial: 300,
    max: Infinity,
    jitter: true
  },
  attempts: {
    max: 100,
    retryIf: (error, _operation) => !!error
  }
});

export const wsErrorLink = onError( ({ graphQLErrors, networkError, operation, forward}) => {
  // Error when jwt token expired
  if (networkError) {
    console.log('[Network error]: ', networkError);
    // if (networkError.extensions.code === 'start-failed'){

    // }
  }

  if (graphQLErrors)
    graphQLErrors.forEach(({ message, locations, path }) =>
      console.log(
        `[GraphQL error]: Message: ${message}, Location: ${locations}, Path: ${path}`
      )
    );
});

export const webSocketLink = new WebSocketLink({
  uri: ws_protocol + process.env.REACT_APP_HASURA_ENDPOINT,
  // https://github.com/apollographql/subscriptions-transport-ws/issues/171
  options: {
    reconnect: true,
    lazy: true,
    // reconnectionAttempts: 5,
    // inactivityTimeout: 10000000,
    connectionParams: () => ({
      headers: {
        'authorization' : `Bearer ${getInMemoryToken()}`
      }
    }),
    
  }
})

webSocketLink.subscriptionClient.onReconnecting(() => {
  getNewInMemoryToken().then(
    newToken => {
      reinitWSConnection(newToken)
      console.log('Reiniting websocket connection, probably, because jwt token was expired')

    }
  );
})

function reinitWSConnection(newToken) {
  webSocketLink.subscriptionClient.connectionParams.headers = {
    'authorization': `Bearer ${newToken}`
  };
  webSocketLink.subscriptionClient.close(true);
  webSocketLink.subscriptionClient.connect();
}
