import { useEffect, useState } from "react"
import { useMediaQuery } from "react-responsive"

const DARK_CLASS = "dark";

function getCookie(name) {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) return parts.pop().split(';').shift();
}

export const SystemPreferTheme = () => {
    const systemPrefersDark = useMediaQuery({ query: "(prefers-color-scheme: dark)"}, undefined);
    const [theme, setTheme] = useState(() => getCookie('theme'));

    function changeTheme(newTheme){
        var expires = new Date()
        expires.setFullYear(expires.getFullYear()+1)
        document.cookie = `theme=${newTheme}; expires=${expires}; path=/`
        setTheme(newTheme)
    }

    useEffect(() => {
      if (theme === 'dark') document.documentElement.classList.add(DARK_CLASS)
      else if (theme === 'light') document.documentElement.classList.remove(DARK_CLASS)

      else if (theme === 'system'){
        if (systemPrefersDark) document.documentElement.classList.add(DARK_CLASS)
        else document.documentElement.classList.remove(DARK_CLASS)
      }
    }, [theme, systemPrefersDark]);

    return [theme, changeTheme]
};