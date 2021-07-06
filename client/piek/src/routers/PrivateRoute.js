import { useEffect, useState } from 'react';
import {Route, Redirect} from 'react-router-dom';



const PrivateRoute = ({component: Component, ...rest}) => {
    const [isLoaded, setisLoaded] = useState(undefined);
    const [isAuth, setisAuth] = useState(undefined);


    async function checkAuth() {
        const res = await rest.store.checkAuth();
        setisAuth(res.isAuth);
        setisLoaded(res.isLoaded)
    }

    useEffect(() => {
        checkAuth();
    }, [])

  

  return(
    <Route
      {...rest}
      render={props => {
        if (isLoaded){
            if (isAuth){
                console.log('PrivateRoute: return a component')
                return <Component {...props} />
            } else {
                rest.store.prevPath = props.history.location.pathname;
               return <Redirect to='/login'/>;
            }
           
        } else {
            console.log('PrivateRoute: awaiting a response from checkAuth() ')
        }
    }}
    />
  )
};


export default PrivateRoute;

