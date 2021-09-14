import { useContext } from 'react';
import { Context } from './index';

// import ReactTooltip from 'react-tooltip';
import {observer} from 'mobx-react-lite';

import BaseLayout from './components/BaseLayout';
import Sidebar from './components/Sidebar/Sidebar';
import { DarkToggle } from './components/Sidebar/DarkToggle';

import { createTheme, ThemeProvider } from '@material-ui/core/styles';

const darkTheme = createTheme({
});

const theme = darkTheme
darkTheme.overrides = {
  MuiInputLabel: {
    root: {
      color: 'var(--lowContrast)',
      fontSize: '.8rem',
    },
  },
  MuiOutlinedInput: {
    notchedOutline: {
      borderColor: 'var(--border)',
    },
    focused:{
      borderColor: 'var(--border)'
    }
  },
  MuiInputBase: {
    root: {
      borderBottom: 'none',
      color: 'var(--highContrast)',
      '&::before': {
        borderColor: 'var(--border) !important',
      }
    },
  },
  MuiIconButton:{
    root: {
      color: 'var(--lowContrast)',
      opacity: .5
    }
  },
  MuiAutocomplete: {
    paper: {
      background: 'var(--L1) !important',
      border: '1px solid var(--border)',
    },
    listbox: {
      color: 'var(--highContrast)',
      fontSize: '.8rem',
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
