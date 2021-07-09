import { useEffect, useState } from "react"
import { useMediaQuery } from "react-responsive"
import { UilMoon, UilSun} from '@iconscout/react-unicons';

  const DARK_CLASS = "dark";

    export const DarkToggle = () => {
      const systemPrefersDark = useMediaQuery(
        {
          query: "(prefers-color-scheme: dark)"
        },
        undefined,
        prefersDark => {
          setIsDark(prefersDark);
        }
      );

      const [isDark, setIsDark] = useState(systemPrefersDark);

     useEffect(() => {
       if (isDark) {
         document.documentElement.classList.add(DARK_CLASS)
       } else {
         document.documentElement.classList.remove(DARK_CLASS)
       }
     }, [isDark]);

      return (
          <>
        <div  className="DarkToggle " onClick={() => setIsDark(!isDark)} >{isDark? < UilSun/> : <UilMoon/>}</div>
        </>

      );
    };
