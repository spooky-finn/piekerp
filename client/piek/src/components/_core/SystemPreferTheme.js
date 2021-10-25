import { useEffect } from "react"
import { useMediaQuery } from "react-responsive"

const DARK_CLASS = "dark";

export function getCookie(name) {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) return parts.pop().split(';').shift();
}

export const SystemPreferTheme = (appTheme, setAppTheme) => {
    // theme can will be dark, light or system (used for corrent displaying selected theme in preferences)
    // mode can be only dark or light (used for material ui pallete)
    const systemPrefersDark = useMediaQuery({ query: "(prefers-color-scheme: dark)"}, undefined);
    var mode = appTheme

    function changeTheme(newTheme){
        var expires = new Date()
        expires.setFullYear(expires.getFullYear()+1)
        document.cookie = `theme=${newTheme}; expires=${expires}; path=/`
        setAppTheme(newTheme)
    }

    useEffect(() => {
      if (appTheme === 'dark') document.documentElement.classList.add(DARK_CLASS)
      else if (appTheme === 'light') document.documentElement.classList.remove(DARK_CLASS)

      else if (appTheme === 'system'){
        if (systemPrefersDark) document.documentElement.classList.add(DARK_CLASS)
        else document.documentElement.classList.remove(DARK_CLASS)
      };
    }, [appTheme, systemPrefersDark]);

    if (appTheme === 'system'){
      if (systemPrefersDark) mode = 'dark'
      else mode = 'light'
    }
    return {appTheme, mode, changeTheme}
};
