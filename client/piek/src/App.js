import { useContext, useState, useMemo } from 'react';
import { Context } from './index';

// import ReactTooltip from 'react-tooltip';
import {observer} from 'mobx-react-lite';

import BaseLayout from './components/BaseLayout';
import Sidebar from './components/Sidebar/Sidebar';


import {getCookie, SystemPreferTheme} from './components/_core/SystemPreferTheme'
import { createTheme, ThemeProvider } from '@mui/material/styles';
import { muicomponents } from './materialStyles'

function App() {  
  const { store } = useContext(Context);
  const [appTheme, setAppTheme] = useState(() => getCookie('theme'))
  store.setUItheme(appTheme, setAppTheme)
  const {mode} = SystemPreferTheme(appTheme, setAppTheme)
  
  const getDesignTokens = (mode) => ({
    palette: {
      mode,
      ...(mode === 'light'
        ? {
            // palette values for light mode
            primary: {
              main: '#3763FE',
              light: '#E7E9FB',
            },
            secondary: {
              main: '#e5534b',
            }
          }
        : {
            // palette values for dark mode
            primary: {
              main: '#99affc',
              light: '#43435c',
            },
            secondary: {
              main: '#e5534b',
            },
           
          }),
    },
    typography: {
      fontFamily: `-apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',sans-serif`,
      subtitle1: {
        fontSize: '.7rem',
        textTransform: 'uppercase',
        fontWeight: 600,
        letterSpacing: '.5px'
        // color: 'var(--lowContrast)'
      }
    },
  });

  var theme = useMemo(() => createTheme(getDesignTokens(mode)), [mode]);
  theme = createTheme(theme, muicomponents(theme));


  return (
    <ThemeProvider theme={theme}>
      <div className="App">
        
        { store.inMemoryToken && <Sidebar/> }
          <BaseLayout/>
        
      </div>
    </ThemeProvider>

  );
}

export default observer(App);
