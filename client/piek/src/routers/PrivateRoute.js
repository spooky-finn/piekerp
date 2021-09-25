import { useEffect, useState, useContext} from 'react';
import {Route, Redirect} from 'react-router-dom';

import { Context } from '../index';

const PrivateRoute = ({component: Component, ...rest}) => {
  const { store } = useContext(Context)
  const [isLoaded, setisLoaded] = useState(false);
  const [token, setToken] = useState(store.inMemoryToken);

    async function getToken() {
      store.checkAuth().then(
        (res) => {
          setToken(res)
          setisLoaded(true)
        }
      )
    }

    useEffect(() => {
      if (token) setisLoaded(true)
      else getToken();
      }, [])

  return(
    <Route
      {...rest}
      render={props => {
        if (isLoaded){
          if (token) return <Component {...props} />
          else return <Redirect to='/login'/>;
        }
    }}
    />
  )
};


export default PrivateRoute;

