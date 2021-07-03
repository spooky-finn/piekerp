import { createContext } from "react";

import Store from './store'

export const AppState = ({children}) => {

    const store = new Store();

    const Context = createContext({
        store,
    });
    return(
        <Context.Provider value={store}>
            {children}
        </Context.Provider>
    )
}