import { useEffect, useState, useContext} from 'react';
import {Route, Redirect} from 'react-router-dom';

import { Context } from '../index';

const PrivateRoute = ({component: Component, ...rest}) => {

    const [isLoaded, setisLoaded] = useState(undefined);
    const [isAuth, setisAuth] = useState(undefined);

    const { store } = useContext(Context)

    async function checkAuth() {
        const res = await store.checkAuth();
        setisAuth(res.isAuth);
        setisLoaded(res.isLoaded)
    }

    useEffect(() => {
      if (store.inMemoryToken) {
        setisAuth(true);
        setisLoaded(true)
      }
      else checkAuth()
      }, [])

  return(
    <Route
      {...rest}
      render={props => {
        if (isLoaded){
            if (isAuth) return <Component {...props} />
            else return <Redirect to='/login'/>;
        }
        
    }}
    />
  )
};


export default PrivateRoute;

