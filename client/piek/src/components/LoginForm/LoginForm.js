import { observer } from 'mobx-react-lite';
import React, { useState, useContext } from 'react';
import { Context } from '../../index';
import './LoginForm.sass'
import '../../theme.css'


const LoginForm = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const {store} = useContext(Context);

    return(
        <div className="LoginForm">
            <input 
            onChange={e => setEmail(e.target.value)}
            value={email}
            type='text'
            placeholder='Email' />

            <input 
            onChange={e => setPassword(e.target.value)}
            value={password}
            type='text'
            placeholder='Password' />

            <button onClick={() => store.login(email, password)}>Log in</button>
        </div>
    );
}

export default observer(LoginForm);