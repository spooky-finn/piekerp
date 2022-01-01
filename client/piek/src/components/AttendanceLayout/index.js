import  { useMemo, useReducer } from 'react'

//apollo
import { useQuery } from '@apollo/client'
import { GET_USERS } from './queries/getUsers' 

import Table, { generateColumns } from './table'
import { getVarsForSubscription, search_alg } from './functions'

import './sass/index.sass'
import ReportConfigurator from './ReportConfigurator'
import { UilConstructor } from '@iconscout/react-unicons'
import sass from './sass/attendance.module.sass'
import TableSearch from '../_core/mui/TableSearch'
import { Typography } from '@mui/material'

import { monthAdd } from './functions'

// учет рабочего времени
const Attendance = props => {
    const date = new Date()

    function reducer(state, action) {
        switch (action.type) {

          case 'selectedMonth':
            return {...state, [action.type]: action.payload,};

          case 'timeDeduction':
            return {...state, [action.type]: action.payload };

          case 's_keyword': 
            return { ...state, [action.type]: action.payload};

          default:
            throw new Error();
        }
      }

    const defaultDate = monthAdd(date, -1);
    
    const [state, dispatch] = useReducer(reducer, {
        timeDeduction: 30,
        selectedMonth: [defaultDate.getMonth(), defaultDate.getFullYear()],
        s_keyword: ''
    });

    const { timeDeduction, selectedMonth } = state;

    const { gte, lte } = getVarsForSubscription(selectedMonth)

    const { loading, data } = useQuery(GET_USERS, { variables: { gte, lte }, fetchPolicy: 'no-cache' });
    
    const onChangeSearch = (e) => {
      dispatch({ type: 's_keyword', payload: e.target.value.trim() })
    }

    const columns = useMemo(
        () => {
          return generateColumns(selectedMonth, timeDeduction)
        },
      [selectedMonth, timeDeduction]
    )


    const searchResult = useMemo(
      () => {
        if (loading) return []

        const keyword = state.s_keyword
        const dt = data?.attendance_users_aggregate?.nodes

        if (keyword){
          const result = dt.filter((user) => search_alg(user, keyword))
          return result
        }
        else return dt
      },
    [state.s_keyword, loading]
   )

   
    return(
    <div>
            <div className="pageLayout__header">
                <UilConstructor className='pageLayout__icon'/>
                <div className='pageLayout__title'>
                    Рабочее время
                </div>                    
            </div> 

            <ReportConfigurator 
            state    = {state} 
            dispatch = {dispatch}
             />

        <div className={sass.tableWrapper}>
            <TableSearch onChange={onChangeSearch} disableAutoFocus/>            

            { !loading && data ? 
                <Table 
                columns   = {columns} 
                data      = {searchResult} 
                className = {sass.attendanceTable} /> 
            : <Typography m="10px" variant='subtitle2'>загрузка..</Typography> }

        </div>
    </div>
    )
}

export default Attendance