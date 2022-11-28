import { useEffect } from 'react'
import { useMediaQuery } from 'react-responsive'
import { AppColorTheme } from 'src/types/global'

const DARK_CLASS = 'dark'

export const SystemPreferTheme = (
  appTheme: AppColorTheme,
  setAppTheme: (newState: any) => void
) => {
  // theme can will be dark, light or system (used for corrent displaying selected theme in preferences)
  // mode can be only dark or light (used for material ui pallete)
  const systemPrefersDark = useMediaQuery({ query: '(prefers-color-scheme: dark)' }, undefined)
  var mode = appTheme

  function changeTheme(newTheme: AppColorTheme) {
    localStorage.setItem('theme', newTheme)
    setAppTheme(newTheme)
  }

  useEffect(() => {
    if (appTheme === 'dark') document.documentElement.classList.add(DARK_CLASS)
    else if (appTheme === 'light') document.documentElement.classList.remove(DARK_CLASS)
    else if (appTheme === 'system') {
      if (systemPrefersDark) document.documentElement.classList.add(DARK_CLASS)
      else document.documentElement.classList.remove(DARK_CLASS)
    }
  }, [appTheme, systemPrefersDark])

  if (appTheme === 'system') {
    if (systemPrefersDark) mode = 'dark'
    else mode = 'light'
  }
  return { appTheme, mode, changeTheme }
}
