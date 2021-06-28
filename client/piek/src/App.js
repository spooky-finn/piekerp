import React, { useContext, useEffect, useState} from 'react';
import { Context } from './index';
import LoginForm from './components/LoginForm/LoginForm';
import {observer} from 'mobx-react-lite';
import UserService from './services/UserService';
import BaseLayout from './components/BaseLayout';
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
    return(
      <div>Загрузка</div>
    )
  }
  if (!store.isAuth) {
    return (
      <LoginForm/>
    )
  }

  return (
    <>
    <div className="App">
    
          <h1>{store.isAuth ? `Пользователь авторизован ${store.user?.Email}` : 'Авторизуйтесь'}</h1>
          <button onClick={() => store.logout()}>Выйти</button>

          {/* <div>
            <button onClick={getUsers}>Get USers</button>
          </div>
          <div>
          {users?.map((user, index) => (
            <div key={index}>{user.Email} -  {user.FirstName} {user.LastName}</div>
          ))}
        </div> */}
      <BaseLayout>
      
      </BaseLayout>
      
      
    </div>
    </>
  );
}

export default observer(App);
