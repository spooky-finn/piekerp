import {WebSocketLink} from 'apollo-link-ws';
import React, { createContext } from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';
import Store from './store/store';
import 'react-notifications/lib/notifications.css';
import { PropertiesIcon } from 'evergreen-ui';

import {
  ApolloClient,
  InMemoryCache,
  ApolloProvider,
} from "@apollo/client";

const store = new Store();

export const Context = createContext({
  store,
});

const createApolloClient = () => {
  return new ApolloClient({
    link: new WebSocketLink({
      uri: 'ws://45.10.110.168:8080/v1/graphql',
      // options: {
      //   reconnect: true,
      //   connectionParams: {
      //     headers: {
      //       'x-hasura-admin-secret': ''
      //     }
      //   }
      // }
    }),
    cache: new InMemoryCache()
  });
};

const root = document.getElementById('root');

ReactDOM.render(
  
  
  <ApolloProvider client={createApolloClient()}>
    <App sessionData={root.dataset.session}>
    <Context.Provider value={store}>
    
    
    </Context.Provider>
    </App>
    </ApolloProvider>
,
  root
);

reportWebVitals();
