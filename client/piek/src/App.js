import React, { useContext, useEffect, useState} from 'react';
import { Context } from './index';
import ReactTooltip from 'react-tooltip';
import BaseLayout from './components/BaseLayout';
import LoginForm from './components/LoginForm/LoginForm';
import {observer} from 'mobx-react-lite';
import UserService from './services/UserService';
import Sidebar from './components/Sidebar/Sidebar';


import { Spinner, Pane, PropertiesIcon } from 'evergreen-ui';

import './theme.css';
import './index.sass';



function App({sessionData}) {
  const {store} = useContext(Context);
  const [users, setUsers] = useState();
  // const usersList = ;

 
  
  

  useEffect( () => {
    if (localStorage.getItem('token')){
      store.checkAuth();
    }
  }, [])

  async function getUsers(){
    try {
      const response = await UserService.fetchUsers();
      setUsers(response.data);
    } catch (e) {
      console.log(e);
    }
  }

  if (store.isLoading){
    return(<Pane><Spinner marginX="auto" marginY="45vh" /></Pane>)
  }
  
  if (!store.isAuth) {
    return (
      <LoginForm/>
    )
  }

  return (
    <>
 
    <div className="App">
      
      <Sidebar/>
          {/* <div>
            <button onClick={getUsers}>Get USers</button>
          </div>
          <div>
          {users?.map((user, index) => (
            <div key={index}>{user.Email} -  {user.FirstName} {user.LastName}</div>
          ))}
        </div> */}

        <BaseLayout/>
     
          <ReactTooltip id='global' type="light" place="bottom" delayShow="300" className='tooltip'/>
           
    </div>
    
    </>
  );
}

export default observer(App);
