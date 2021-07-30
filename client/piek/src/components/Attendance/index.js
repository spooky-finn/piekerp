import { useContext, useMemo, useEffect } from 'react'
import { Context } from '../../index'
import { useQuery } from '@apollo/client'

import { GET_USERS } from '../../hasura-queries/attendance/getUsers' 
import BaseHeader from '../BaseHeader'
import Table, { columnsList, months } from './table'

// учет рабочего времени
const Attendance = props => {
    const { store } = useContext(Context);
    const {loading, error, data = [] } = useQuery(GET_USERS);

    console.log(data.attendance_users, "DATAAA")
   

    // useEffect((columnsList) => {
    //     const columns = months(columnsList)
    // }, []);


    const columns = useMemo(
        () => months(columnsList), [months]
    )

    return(
        <>
        {!data.attendance_users ? null : (
            <>
            <BaseHeader pageParams = { store.getPageParams(window.location.pathname) }/> 
            <Table columns = { columns } data = { data.attendance_users }/>
    
            <div>привет </div>
            </>
        )
        }
        </>
    )
}

export default Attendance