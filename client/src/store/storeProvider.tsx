import { createContext, useContext } from 'react'
import RootStore from './rootStore'

// create a rootStore provider useing react context and hook to access store inside components
const store = typeof window !== 'undefined' ? new RootStore() : ({} as RootStore)

const RootStoreContext = createContext(store)

export const RootStoreProvider = ({ children }: { children: React.ReactNode }) => (
  <RootStoreContext.Provider value={store}>{children}</RootStoreContext.Provider>
)

export const useRootStore = () => useContext(RootStoreContext)

export const getRootStore = () => store
