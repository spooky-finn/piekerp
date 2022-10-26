import { useContext, useState, useMemo } from 'react';
import { Context } from './index';

import { observer } from 'mobx-react-lite';

import BaseLayout from './components/BaseLayout';
import Sidebar from './components/Sidebar/Sidebar';
import { ReactNotifications } from 'react-notifications-component'

import { getCookie, SystemPreferTheme } from './utils/SystemPreferTheme'
import { createTheme, ThemeProvider } from '@mui/material/styles';
import materialConfig from './material/materialConfig'
import ReactTooltip from 'react-tooltip';
import useNetworkStatus from './hooks/useNetworkStatus';
import getPalette from './material/getPalette';


function App() {
  const NetworkStatusNotificaion = useNetworkStatus();

  const { store } = useContext(Context);
  const [appTheme, setAppTheme] = useState(() => getCookie('theme'))
  store.setUItheme(appTheme, setAppTheme)
  const { mode } = SystemPreferTheme(appTheme, setAppTheme)
  var theme = createTheme(getPalette(mode));
  theme = createTheme(theme, materialConfig(theme));
  console.log(theme);
  return (
    <ThemeProvider theme={theme}>

      <div className="App">
        <NetworkStatusNotificaion />

        <ReactTooltip className='reactTooltips' delayShow={300} />
        <ReactNotifications />
        {store.inMemoryToken && <Sidebar />}
        <BaseLayout />
      </div>
    </ThemeProvider>
  );
}

export default observer(App);
