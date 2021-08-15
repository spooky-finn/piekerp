import { useContext, useMemo, useState, useRef, useEffect } from 'react'
import { Context } from '../../index'
import { useQuery } from '@apollo/client'

import { GET_USERS } from '../../hasura-queries/attendance/getUsers' 

import Table, { generateColumns } from './table'
import { getVarsForSubscription } from './functions'

import './index.sass'
import ReportConfigurator from './ReportConfigurator'
import BaseHeader from '../BaseHeader'

// учет рабочего времени
const Attendance = props => {
    const date = new Date()

    const { store } = useContext(Context);

    const [selectedMonth, setSelectedMonth] = useState([date.getMonth()-1, date.getFullYear()])
    const [timeDeduction, setTimeDeduction] = useState(30)    
    const [search, setSearch] = useState('');

    const { gte, lte } = getVarsForSubscription(selectedMonth)
    const {loading, error, data = [] } = useQuery(GET_USERS, { variables: { gte, lte, search: '%'+search+'%' } });
    
    const onChangeSearch = (e) => {
        const req = e.target.value.replace(/\s/g, '')
        setSearch(req)
    }

   
    return(
        <>
            <BaseHeader pageParams = { store.getPageParams(window.location.pathname) } search={onChangeSearch} /> 
            <ReportConfigurator 
                setSelectedMonth={setSelectedMonth}
                selectedMonth={selectedMonth}
                timeDeduction={timeDeduction}
                setTimeDeduction={setTimeDeduction} />

            {/* условное обозначение */}
            <div className="legend">
                <div className="status-101">Прерванный рабочий день</div>
                <div className="status-102">Не отмечен конец смены</div>
            </div>

            {!loading &&(
                <>
                    <Table columns = { generateColumns(selectedMonth, timeDeduction) } data = { data.attendance_users_aggregate.nodes } className="attendance-table"/> 

                </>)}
           
            <span className="reportMeta">
                Отчет за {selectedMonth[0] + 1} месяц {selectedMonth[1]} года 
            </span>
            
        </>
    )
}

export default Attendance