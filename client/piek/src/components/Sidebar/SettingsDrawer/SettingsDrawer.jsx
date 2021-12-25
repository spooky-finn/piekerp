import { useState } from 'react';
import { useContext } from 'react';
import { Context } from '../../../index';
import { useHistory } from 'react-router-dom';

import Box from '@mui/material/Box';
import Drawer from '@mui/material/Drawer';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import { styled } from '@mui/material/styles';
import Button from '@mui/material/Button';

import { UilSun, UilMoon, UilDesktop, UilSetting } from '@iconscout/react-unicons'

import {
  ToggleButton,
  ToggleButtonGroup,
} from '@mui/material/';

import sass from './index.module.sass'
import { SystemPreferTheme } from '../../_core/SystemPreferTheme';


const StyledToggleButtonGroup = styled(ToggleButtonGroup)(({ theme }) => ({
  '& .MuiToggleButtonGroup-grouped': {
    border: 'var(--border)',
    padding: 8,
    textTransform: 'none',
    '&:not(:first-of-type)': {

    },
    '&:first-of-type': {
      borderTopLeftRadius: 'var(--br)',
      borderBottomLeftRadius: 'var(--br)',
    },
    '&:last-of-type': {
      borderTopRightRadius: 'var(--br)',
      borderBottomRightRadius: 'var(--br)',
    },
  },
}));

function getCookie(name) {
  const value = `; ${document.cookie}`;
  const parts = value.split(`; ${name}=`);
  if (parts.length === 2) return parts.pop().split(';').shift();
}

export default function SettingsDrawer() {
  const {store} = useContext(Context);
  const [state, setState] = useState(false);
  const history = useHistory()
  const {changeTheme} = SystemPreferTheme(store.UItheme.state, store.UItheme.dispatch)

  async function logout(){
    await store.logout(); 
    history.push('/login')
  }

  const themeHandler = (e, newTheme) => {
    changeTheme(newTheme)
  };

  const toggleDrawer = (open) => (event) => {
    setState(open);
  };
  
  const list = (anchor) => (
    <Box
      sx={{ width: anchor === 'top' || anchor === 'bottom' ? 'auto' : 400 }}
      role="presentation"
      onKeyDown={toggleDrawer(false)}
    >

      <List>
        <ListItem className={sass.user}>
        <div>Добро пожаловать, {store.user.FirstName} {store.user.LastName}!</div>
        </ListItem>

        <ListItem >
          <StyledToggleButtonGroup
            className={sass.themeToggleButtons}
            color="primary"
            value={getCookie('theme')}
            exclusive
            fullWidth
            onChange={themeHandler}
            >
            <ToggleButton value="light"> <UilSun/> Light</ToggleButton>
            <ToggleButton value="system"> <UilDesktop/>System</ToggleButton>
            <ToggleButton value="dark"> <UilMoon/> Dark</ToggleButton>
          </StyledToggleButtonGroup>
        </ListItem>

      </List>
      
      <div className={sass.logoutButton}>
        <Button variant="outlined" onClick={logout}>Выйти</Button>
      </div>
    </Box>
  );

  return (
    <>
          <div onClick={toggleDrawer(true)}>
            <UilSetting/>
          </div>
          <Drawer
            open={state}
            onClose={toggleDrawer(false)}
            PaperProps = {{
              sx: {
                backgroundColor: 'var(--L0-glass)',
                backdropFilter: 'var(--blurFilter)'
              }
            }}
          >
            {list('left')}
          </Drawer>
    </>
  );
}