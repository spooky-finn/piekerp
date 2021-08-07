import {WebSocketLink} from 'apollo-link-ws';
import React, { createContext } from 'react';
import ReactDOM from 'react-dom';
import './theme.css';
import './index.sass';
import App from './App';
import reportWebVitals from './reportWebVitals';
import Store from './store/store';
import 'react-notifications/lib/notifications.css';
import { BrowserRouter } from 'react-router-dom';
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
      uri: 'wss://45.10.110.168:8080/v1/graphql',
      options: {
        reconnect: true,
        connectionParams: {
          headers: {
            'x-hasura-admin-secret': '44UL1UoEAr'
          }
        }
      }
    }),
    cache: new InMemoryCache()
  });
};

const root = document.getElementById('root');

ReactDOM.render(
  
  
  <ApolloProvider client={createApolloClient()}>
    <BrowserRouter>
      <App sessionData={root.dataset.session}>
        <Context.Provider value={store}>
        
        </Context.Provider>
      
    </App>
    </BrowserRouter>
    </ApolloProvider>
,
  root
);

reportWebVitals();
