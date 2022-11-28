import { ReactJSXElement } from '@emotion/react/types/jsx-namespace'
import { useContext, useEffect, useState } from 'react'
import { Navigate } from 'react-router-dom'

import { Context } from '../index'

type IRequireAuthProps = {
  children: ReactJSXElement
}

const RequireAuth = (props: IRequireAuthProps) => {
  const { store } = useContext(Context)
  const [isLoaded, setisLoaded] = useState(false)
  const [token, setToken] = useState(store.inMemoryToken)

  async function getToken() {
    store.checkAuth().then(res => {
      setToken(res)
      setisLoaded(true)
    })
  }

  useEffect(() => {
    if (token) setisLoaded(true)
    else getToken()
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  if (!isLoaded) return <>Authentication</>

  return token ? props.children : <Navigate to="/login" />
}

export default RequireAuth
