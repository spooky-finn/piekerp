import { createTheme as createMuiTheme, ThemeProvider } from '@mui/material/styles'
import { observer } from 'mobx-react-lite'
import { useContext } from 'react'
import { ReactNotifications } from 'react-notifications-component'
import ReactTooltip from 'react-tooltip'
import Sidebar from 'src/components/Sidebar'
import NetworkStatusMessage from './components/NetworkStatusMessage'
import { useLocalStorageState } from './hooks'
import { Context } from './index'
import { customizedTheme } from './material/customizedTheme'
import AppRouter from './routers/Router'
import { SystemPreferTheme } from './utils/systemPreferTheme'

function App() {
  const { store } = useContext(Context)

  const [appTheme, setAppTheme] = useLocalStorageState({ name: 'theme', defaultValue: 'light' })

  store.setUItheme(appTheme, setAppTheme)

  const { mode } = SystemPreferTheme(appTheme, setAppTheme)
  const theme = createMuiTheme(customizedTheme(mode))

  return (
    <ThemeProvider theme={theme}>
      <div className="App">
        <NetworkStatusMessage />

        <ReactTooltip className="reactTooltips" delayShow={300} />
        <ReactNotifications />
        {store.inMemoryToken && <Sidebar />}

        <div className="base-container">
          <AppRouter />
        </div>
      </div>
    </ThemeProvider>
  )
}

export default observer(App)
