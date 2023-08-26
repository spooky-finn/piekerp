import { ApolloProvider } from '@apollo/client'
import { createRoot } from 'react-dom/client'
import { BrowserRouter } from 'react-router-dom'
import App from './App'

import './index.sass'
import './material/theme.css'
import { getRootStore } from './store/storeProvider'

const container = document.getElementById('app') || document.createElement('div')
const root = createRoot(container) // createRoot(container!) if you use TypeScript

root.render(
  <ApolloProvider client={getRootStore()?.apolloClient}>
    <BrowserRouter>
      <App />
    </BrowserRouter>
  </ApolloProvider>
)
