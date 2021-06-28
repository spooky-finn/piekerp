import { observer } from 'mobx-react-lite';
import React, { useState, useContext } from 'react';
import { Button, Form, Grid, Header, Segment } from 'semantic-ui-react'
import {NotificationContainer, NotificationManager} from 'react-notifications';
import { Context } from '../../index';
import './LoginForm.sass'
import '../../theme.css'


const LoginForm = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const {store} = useContext(Context);
    let authResponse;
    const setNotification = () => {
        NotificationManager.error('Поля пустые', 'Ошибка', 3000);
    }

    return(
        <>
<Grid textAlign='center' style={{ height: '100vh' }} verticalAlign='middle'>
    <Grid.Column style={{ maxWidth: 450 }}>
      <Header as='h2' color='teal' textAlign='center'>
         Авторизация
      </Header>
      <Form size='large'>
        <Segment stacked>

          <Form.Input 
            onChange={e => setEmail(e.target.value)}
            value={email}
            fluid 
            icon='user' 
            iconPosition='left' 
            placeholder='Почта'
           />


          <Form.Input
            onChange={e => setPassword(e.target.value)}
            value={password}
            fluid
            icon='lock'
            iconPosition='left'
            placeholder='Пароль'
            type='password'
          />

          <Button color='teal' fluid size='large' onClick={() => {
            authResponse = store.login(email, password);
            authResponse.data != undefined 
            ? store.login(email, password)
            : setNotification()
        }}>
            Вход
          </Button>
        </Segment>
      </Form>
    </Grid.Column>
</Grid>
        <NotificationContainer/>
        </>
    );
}

export default observer(LoginForm);