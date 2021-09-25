import { useEffect, useState } from "react"
import { useMediaQuery } from "react-responsive"
import { UilMoon, UilSun} from '@iconscout/react-unicons';

  const DARK_CLASS = "dark";

export const DarkToggle = (props) => {

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
        if (isDark) document.documentElement.classList.add(DARK_CLASS)
        else document.documentElement.classList.remove(DARK_CLASS)
        
    }, [isDark]);


    if (props.display === 'none') return null
    return (<>

        <div  className="DarkToggle " onClick={() => setIsDark(!isDark)} >{isDark? < UilSun/> : <UilMoon/>}</div>
        
        </>);
};
