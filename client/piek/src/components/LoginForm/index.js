import { useState, useContext } from 'react';
import { Context } from '../../index';
import { useHistory } from "react-router-dom";

import ReactNotification from 'react-notifications-component'
import { TextField, Button } from '@material-ui/core';
import './LoginForm.sass'
import { notif } from '../_core/notification'

const LoginForm = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    
    
    const { store } = useContext(Context);
    const history = useHistory();


    const login = async () => {
      const res = await store.login(email, password)

      if (res?.status === 200){
        history.push('/')
      }
      else{
        console.error('Invalig email or password')
        notif('warning', 'Unauthorized error', 'Invalig email or password')
       
      }
      
    }

    return(<>
      <ReactNotification />
      <div className='loginCard'>
        <TextField
        className='loginInput'
        label="Email"
        onChange={e => setEmail(e.target.value)}
        />
        <TextField
          label="Password"
          type="password"
          className='loginInput'
          onChange={e => setPassword(e.target.value) }
        />
        <Button
          className="Button"
          variant="outlined"
          width='300px'
          onClick={login}
        >Войти</Button>
      </div>
    </>);
}

export default LoginForm
