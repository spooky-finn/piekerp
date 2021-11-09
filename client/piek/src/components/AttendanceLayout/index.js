import  { useMemo, useEffect, useReducer } from 'react'

//apollo
import { useQuery } from '@apollo/client'
import { GET_USERS } from './queries/getUsers' 

import Table, { generateColumns } from './table'
import { getVarsForSubscription } from './functions'

import './index.sass'
import ReportConfigurator from './ReportConfigurator'
import { UilConstructor } from '@iconscout/react-unicons'
import sass from './attendance.module.sass'
import TableSearch from '../_core/mui/TableSearch'

var attendanceData = null;
// учет рабочего времени
const Attendance = props => {
    const date = new Date()
    function reducer(state, action) {
        switch (action.type) {

          case 'selectedMonth':
            return {...state, [action.type]: action.payload,};

          case 'timeDeduction':
            return {...state, [action.type]: action.payload };

          case 'filtredData':
            return { ...state, [action.type]: action.payload};

          default:
            throw new Error();
        }
      }

    const [state, dispatch] = useReducer(reducer, {
        timeDeduction: 30,
        selectedMonth: [date.getMonth()-1, date.getFullYear()],
    });
    const { timeDeduction, selectedMonth, filtredData } = state;


    const { gte, lte } = getVarsForSubscription(selectedMonth)
    const { loading } = useQuery(GET_USERS, { variables: { gte, lte }, onCompleted: (options) => {
        attendanceData = options.attendance_users_aggregate.nodes;
        dispatch({ type: 'filtredData', payload: attendanceData})
    } });
    
    useEffect(() => {
        return () => {
            attendanceData = null
        };
    }, []);

    function filteringAlg(user, keyword){
        if (user.lastname.toLowerCase().startsWith(keyword.toLowerCase())) return true
        else if (user.firstname.toLowerCase().startsWith(keyword.toLowerCase())) return true
        else return false
    }

    const onChangeSearch = (e) => {
        const keyword = e.target.value.trim();

            if (keyword !== '') {
              const result = attendanceData.filter((user) => filteringAlg(user, keyword))
              dispatch({ type: 'filtredData', payload: result })
            } else dispatch({ type: 'filtredData', payload: attendanceData})
    }

    const columns = useMemo(
        () => generateColumns(selectedMonth, timeDeduction), [selectedMonth, timeDeduction]
    )

    return(
    <div>
            <div className="pageLayout__header">
                <UilConstructor className='pageLayout__icon'/>
                <div className='pageLayout__title'>Рабочее время</div>                    
            </div> 
            <ReportConfigurator state={state} dispatch={dispatch} />

        <div className={sass.tableWrapper}>
            <TableSearch onChange={ (e) => onChangeSearch(e) } disableAutoFocus/>            
            {filtredData && columns && <Table columns = {columns} data = {filtredData} className={sass.attendanceTable} /> }

             {/* условное обозначение */}
             <div className={`${sass.tableFooter} legend`}>
                <div className="status-101">Прерванный рабочий день</div>
                <div className="status-102">Не отмечен конец смены</div>
                <span className="reportMeta">
                    Отчет за {selectedMonth[0] + 1} месяц {selectedMonth[1]} года 
                </span>

            </div>

        </div>
    </div>
    )
}

export default Attendance