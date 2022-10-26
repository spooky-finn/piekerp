import { useContext } from 'react'
import { Context } from '../index'

export function useAppContext() {
  return useContext(Context)
}
