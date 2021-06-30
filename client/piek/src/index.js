import React, { createContext } from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';
import Store from './store/store';

import 'react-notifications/lib/notifications.css';

const store = new Store();

export const Context = createContext({
  store,
});


ReactDOM.render(
  <Context.Provider value={{store}}>
  <App/>
  </Context.Provider>,
  document.getElementById('root')
);

reportWebVitals();
