import { observer } from 'mobx-react-lite';
import React, { useState, useContext } from 'react';
// import {NotificationContainer, NotificationManager} from 'react-notifications';
import { Context } from '../../index';

import {Heading, TextInputField, Pane, minorScale, Button } from 'evergreen-ui';
import './LoginForm.sass'
import '../../theme.css'


const LoginForm = (props) => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const {store} = useContext(Context);

    // const setNotification = () => {
    //     NotificationManager.error('Похоже вы ошиблись', '	(ಥ﹏ಥ)', 3000);
    // }

    return(
        <>
          <Pane className='loginCard'>
                <Heading marginBottom={24} size={20} fontWeight={900} >Войти</Heading>
                <TextInputField
                className='LoginInput'
                width='300px'
                inputHeight={minorScale(10)}
                label="Email"
                value={email}
                onChange={e => setEmail(e.target.value)}
              />
              <TextInputField
                label="Пароль"
                className='LoginInput'
                inputHeight={minorScale(10)}
                value={password}
                onChange={e => setPassword(e.target.value) }
              />
               <Button className="Button"
                width='300px'
                size="large"
                onClick={() => store.login(email, password) }
               >Войти</Button>
          </Pane>
     
        {/* <NotificationContainer/> */}
        </>
    );
}

export default observer(LoginForm);
