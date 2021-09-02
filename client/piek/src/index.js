import React, { createContext } from 'react';
import ReactDOM from 'react-dom';

import App from './App';
import reportWebVitals from './reportWebVitals';
import Store from './store/store';
// import 'react-notifications/lib/notifications.css';
import { BrowserRouter } from 'react-router-dom';
import jwt from 'jsonwebtoken'
//UI
import './theme.css';
import './index.sass';

//apollo 
import { WebSocketLink} from 'apollo-link-ws';
import { onError } from "@apollo/client/link/error";
import { ApolloLink, Observable } from 'apollo-link';  // add Observable
import { setContext } from "@apollo/client/link/context";

import {
  ApolloClient,
  InMemoryCache,
  ApolloProvider,
  from,
} from "@apollo/client";


const store = new Store();

export const Context = createContext({
  store,
});


let webSocketLink = new WebSocketLink({
  uri: process.env.REACT_APP_HASURA_WS,
  options: {
    reconnect: true,
    lazy: true,
    reconnectionAttempts: 5,
    inactivityTimeout: 1000,
    connectionCallback: async (error) => { error && console.log(error) },
    connectionParams: () => ({
      headers: {
        'Authorization' : `Bearer ${store.inMemoryToken}`
      }
    }),
    
  }
})

const asyncTokenValidation = setContext( async (_, {headers, ...context}) => {
  var token = null 

  if (Date.now() >= jwt.decode(store.inMemoryToken).exp * 1000 ) {
    console.log('Existed access token was expired, request for new token..')
    token = await store.getNewToken()
  }

  return {
    headers: {
      ...headers,
      ...(token ? {Authorization: `Bearer ${token}`} : {}),
    },
    ...context,
  };
});


const apolloClient = new ApolloClient({
  link: from([ asyncTokenValidation, webSocketLink ]),
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
