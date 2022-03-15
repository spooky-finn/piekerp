import  { useMemo, useReducer } from 'react'

import Table, { generateColumns } from './Table.jsx'
import './sass/reportConfigurator.sass'
import ReportConfigurator from './ReportConfigurator'
import { UilConstructor } from '@iconscout/react-unicons'
import sass from './sass/attendance.module.sass'
import { Typography } from '@mui/material'

import { monthAdd } from './time_ helpers'

import { reducer, getInitialState } from './reducer'
// учет рабочего времени

//apollo
import { GET_USERS } from './queries/getUsers';
import { useQuery } from '@apollo/client';
import { getVarsForSubscription } from './functions'


const Attendance = props => {
    const date = new Date()
    const defaultDate = monthAdd(date, -1);
    const [state, dispatch] = useReducer(reducer, getInitialState(defaultDate));
    
    function onCompleted(data){
        dispatch({ type:'timeDeduction', payload: data.attendance_config[0].TimeDeduction })
        const intervals = data.attendance_users_aggregate.nodes.filter( user => user.intervals.length);
        dispatch({ type: 'intervals', payload: intervals})
    }

    const { gte, lte } = getVarsForSubscription(state.selectedMonth)
    var { loading, data } = useQuery(GET_USERS, { variables: { gte, lte }, fetchPolicy: 'no-cache', onCompleted });

    const columns = useMemo( function(){
          return generateColumns(state.selectedMonth, state.timeDeduction)
        },
      [state.selectedMonth, state.timeDeduction]
    )

    const reportConfigurator = <ReportConfigurator data={data} state={state} dispatch={dispatch}/>
    const header = ( <div className="pageLayout__header">
                        <UilConstructor className='pageLayout__icon'/>
                        <div className='pageLayout__title'> Рабочее время </div>                    
                    </div> )
    return(<>
            {header}
            {reportConfigurator}

            { !loading && state.intervals.length ? 
                <Table 
                columns   = {columns} 
                data      = {state.intervals} 
                className = {sass.attendanceTable} /> 
            : <Typography m="10px" variant='subtitle2'>загрузка..</Typography> }

    </>)

}

export default Attendance