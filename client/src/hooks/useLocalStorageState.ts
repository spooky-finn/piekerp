import * as React from 'react'
export interface IuseLocalStorageStateProps {
  name: string
  defaultValue: any
}

export function useLocalStorageState({
  name,
  defaultValue
}: IuseLocalStorageStateProps): [any, (newState: any) => void] {
  const initialValue = localStorage.getItem(name) || defaultValue

  const [state, setState] = React.useState(initialValue)

  return [
    state,
    (newState: any) => {
      localStorage.setItem(name, newState.toString())
      setState(newState)
    }
  ]
}
