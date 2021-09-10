import { useContext } from 'react';
import { Context } from './index';

// import ReactTooltip from 'react-tooltip';
import {observer} from 'mobx-react-lite';

import BaseLayout from './components/BaseLayout';
import Sidebar from './components/Sidebar/Sidebar';
import { DarkToggle } from './components/Sidebar/DarkToggle';

import { createTheme, ThemeProvider } from '@material-ui/core/styles';

import { blue } from '@material-ui/core/colors/';

const darkTheme = createTheme({
  palette: {
    type: "dark",
    primary: blue,
  }  
});

const theme = darkTheme
darkTheme.overrides = {
  MuiInputLabel: {
    root: {
      color: 'var(--text2)',
      fontSize: '.8rem',
    },
  },
  MuiInputBase: {
    root: {
      borderBottom: 'none',
      '&::before': {
        borderColor: 'var(--borderLight) !important',
      }
    },
  },
  MuiAutocomplete: {
    paper: {
      background: 'var(--section) !important',
      border: '1px solid var(--borderLight)',
    },
    listbox: {
      color: theme.palette.text.secondary,
      fontSize: '.9rem',
    },
  },
}


function App() {  
  const { store } = useContext(Context);
  return (
    <ThemeProvider theme={darkTheme}>
      <div className="App">
        
        {store.isAuth
        ? <Sidebar/>
        : null}

          <DarkToggle display='none'/>
          <BaseLayout/>
        
      </div>
    </ThemeProvider>

  );
}

export default observer(App);
