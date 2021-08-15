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


const webSocketLink = new WebSocketLink({
  uri: process.env.REACT_APP_HASURA_WS,
  options: {
    reconnect: true,
    lazy: true,
    minTimeout: 1000,
    inactivityTimeout: 30000,
    connectionCallback: async () => {
        console.log('gql error. Request new access token');
        await store.checkAuth()
    },
    connectionParams: () => ({
      headers: {
        'Authorization' : `Bearer ${store.inMemoryToken}`
      }
    }),
    
  }
})


const apolloClient = new ApolloClient({
  link: webSocketLink,
  cache: new InMemoryCache()
})

const root = document.getElementById('root');

ReactDOM.render(
  <ApolloProvider client={apolloClient}>
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
