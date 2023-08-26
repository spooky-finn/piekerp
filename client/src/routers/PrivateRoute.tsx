import { ReactJSXElement } from '@emotion/react/types/jsx-namespace'
import { Box } from '@mui/material'
import { observer } from 'mobx-react-lite'
import { Navigate } from 'react-router-dom'
import { useRootStore } from 'src/store/storeProvider'

type IRequireAuthProps = {
  children: ReactJSXElement
}

const RequireAuth = (props: IRequireAuthProps) => {
  const store = useRootStore()

  switch (store.app.authStatus) {
    case 'ok':
      if (store.initialized) {
        return props.children
      }
      return null
    case 'pending':
      return (
        <Box
          display="flex"
          justifyContent="center"
          height="100vh"
          width="100vw"
          alignItems="center"
        >
          Starting the app
        </Box>
      )
    default:
      return <Navigate to="/login" />
  }
}

export default observer(RequireAuth)
