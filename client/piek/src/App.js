import React, { useContext, useEffect, useState} from 'react';
import { Context } from './index';
import LoginForm from './components/LoginForm/LoginForm';
import {observer} from 'mobx-react-lite';
import UserService from './services/UserService';
import PriorityLayout from './components/PriorityLayout/PriorityLayout';
import Sidebar from './components/Sidebar/Sidebar';

import { Spinner, Pane } from 'evergreen-ui';

import './theme.css';
import './index.sass';

function App() {
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

   

          <PriorityLayout>
          </PriorityLayout>
     
      
      
    </div>
    </>
  );
}

export default observer(App);
