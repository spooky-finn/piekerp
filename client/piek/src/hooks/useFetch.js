import { useState } from "react";
import { useEffect } from "react";
import $api from "../http";

export default function useFetch(url){
    // TODO ADD TOKEN VERIFICATION
    const [data, setData] = useState()
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null)


    useEffect(() => {
        $api.get(process.env.REACT_APP_API_URL + url).then(res => {

            setLoading(false);
            setData(res.data) ;
        })
        .catch(error => {
            console.error(error);
            setError(error)
        })
    }, [])
    
    return {data, loading, error }
}