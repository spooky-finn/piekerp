import { useState, useContext } from 'react';
// import {NotificationContainer, NotificationManager} from 'react-notifications';
import { Context } from '../../index';

import {TextField, Button} from '@material-ui/core';
import './LoginForm.sass'
import '../../theme.css'

import { useHistory } from "react-router-dom";

const LoginForm = (props) => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    
    const {store} = useContext(Context);
    const history = useHistory();

    // const setNotification = () => {
    //     NotificationManager.error('Похоже вы ошиблись', '	(ಥ﹏ಥ)', 3000);
    // }

    const login = (e) => {
      store.login(email, password).then( () =>  history.push("/") )

    }
    return(
        <>
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
     
        {/* <NotificationContainer/> */}
        </>
    );
}

export default LoginForm
