
import { useContext, useMemo, useState } from 'react'
import { Context } from '../../index'

//apollo
import { useQuery } from '@apollo/client'
import { GET_USERS } from './queries/getUsers' 

import Table, { generateColumns } from './table'
import { getVarsForSubscription } from './functions'


import './index.sass'
import ReportConfigurator from './ReportConfigurator'
import BaseHeader from '../BaseHeader'
import { UilSearch } from '@iconscout/react-unicons'

let attendanceData = null;
// учет рабочего времени
const Attendance = props => {
    const date = new Date()

    const { store } = useContext(Context);

    const [selectedMonth, setSelectedMonth] = useState([date.getMonth()-1, date.getFullYear()])
    const [timeDeduction, setTimeDeduction] = useState(30)    
    const [search, setSearch] = useState('');
    

    const [filtredData, setFiltredData] = useState(null);

    const { gte, lte } = getVarsForSubscription(selectedMonth)

    const { loading } = useQuery(GET_USERS, { variables: { gte, lte }, onCompleted: (options) => {
        attendanceData = options.attendance_users_aggregate.nodes;
        setFiltredData(attendanceData)
    } });
    

    const onChangeSearch = (e) => {
        const keyword = e.target.value.trim();

            if (keyword !== '') {
              const results = attendanceData.filter((user) => {
                return user.lastname.toLowerCase().startsWith(keyword.toLowerCase());
                // Use the toLowerCase() method to make it case-insensitive
              });
              setFiltredData(results);
            } else {
                setFiltredData(attendanceData);
              // If the text field is empty, show all users
            }
    }
    const columns = useMemo(
        () => generateColumns(selectedMonth, timeDeduction), [selectedMonth, timeDeduction]
    )

    const table = () => {
        if (filtredData) return( <Table columns = {columns} 
                                    data = { filtredData } 
                                    className="attendance-table" /> )
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

        <div className="tableWrap">
            <div className="tableSearchInput">
                <UilSearch className="action-icon"/>
                <input type='text' placeholder="поиск (номер счета или организация)" onChange={ (e) => onChangeSearch(e) } autoFocus/>
            </div>
            {table()}
        </div>



            <span className="reportMeta">
                Отчет за {selectedMonth[0] + 1} месяц {selectedMonth[1]} года 
            </span>
            
        </>
    )
}

export default Attendance