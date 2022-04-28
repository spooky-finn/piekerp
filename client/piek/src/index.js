import React, { createContext } from 'react';
import ReactDOM from 'react-dom';

import App from './App';
import reportWebVitals from './reportWebVitals';
import Store from './store/store';

import { BrowserRouter } from 'react-router-dom';
//UI
import './theme.css';
import './index.sass';


import { ApolloProvider } from "@apollo/client";
import { apolloClient } from './http/apollo/apolloClient';

const store = new Store();

export const Context = createContext({
  store,
});

export function getInMemoryToken(){
  return store.inMemoryToken
}
export async function getNewInMemoryToken(){
  const token = await store.getNewToken()
  return token
}


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
