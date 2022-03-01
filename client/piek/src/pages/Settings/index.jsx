import { useContext } from 'react';
import { Context } from '../../';
import { useHistory } from 'react-router-dom';

import { SystemPreferTheme } from "../../utils/SystemPreferTheme"

import { Typography } from "@mui/material"
import { Box } from '@mui/system';
import Button from '@mui/material/Button';

import sass from './styles.module.sass'

const Settings = (props) => {
    const {store} = useContext(Context);
    const {changeTheme} = SystemPreferTheme(store.UItheme.state, store.UItheme.dispatch)
    const history = useHistory()

    async function logout(){
        await store.logout(); 
        history.push('/login')
    }

    const themeVariants = [{
        title: 'Светлая',
        value: 'light'
    },
    {
        title: "Как на утройстве",
        value: 'system'
    },
    {
        title: 'Темная', 
        value: 'dark'
    }]

    const GridCard = (props) => (
        <Box {...props} className={sass.gridCard}>
            <Typography variant='h6'>{props.title}</Typography>
            {props.children}
        </Box>
    )

    return (
        <div className={sass.grid}>
        <GridCard title='Аккаунт'>
            <div> {store.user.FirstName} {store.user.LastName}</div>
            <div> Уровень доступа: {store.user.AccessLevelID}</div>
            <div> Email: {store.user.Email}</div>
            <Button variant='text' onClick={logout}>Выйти</Button>
        </GridCard>

        <GridCard title="Предпочтитаемая тема">
            <div className={sass.selectThemeWrapper}>
            {themeVariants.map(each => <Button variant='text' onClick={ () => changeTheme(each.value) }> {each.title} </Button>)}
            </div>
        </GridCard>

        <GridCard title="Источники данных">
            <div>"gql_endpoint:" {process.env.REACT_APP_HASURA_ENDPOINT}</div>
        </GridCard>

    </div>)
}

export default Settings