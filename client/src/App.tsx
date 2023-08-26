import { Box } from '@mui/material'
import { createTheme as createMuiTheme, ThemeProvider } from '@mui/material/styles'
import { observer } from 'mobx-react-lite'
import { ReactNotifications } from 'react-notifications-component'
import Sidebar from 'src/components/Sidebar'
import NetworkStatusMessage from './components/NetworkStatusMessage'
import { useLocalStorageState } from './hooks'
import { customizedTheme } from './material/customizedTheme'
import AppRouter from './routers/Router'
import { RootStoreProvider, useRootStore } from './store/storeProvider'
import { AppColorMode } from './types/global'
import { SystemPreferTheme } from './utils/systemPreferTheme'

function App() {
  const app = useRootStore().app
  const store = useRootStore()

  const [appTheme, setAppTheme] = useLocalStorageState({ name: 'theme', defaultValue: 'light' })

  app.setUItheme(appTheme, setAppTheme)

  const { mode } = SystemPreferTheme(appTheme, setAppTheme)
  const theme = createMuiTheme(customizedTheme(mode))

  app.setAppColorMode(mode as AppColorMode)

  return (
    <ThemeProvider theme={theme}>
      {/* <CssVarsPr> */}
      <RootStoreProvider>
        <div className="App">
          <NetworkStatusMessage />

          {/* <ReactTooltip className="reactTooltips" delayShow={300} /> */}
          <ReactNotifications />
          {store.authenticated && <Sidebar />}

          <Box
            sx={{
              height: '100vh'
            }}
          >
            <AppRouter />
          </Box>
        </div>
      </RootStoreProvider>
      {/* </CssVarsPr> */}
    </ThemeProvider>
  )
}

export default observer(App)
