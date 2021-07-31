import { useContext, useMemo, useState } from 'react'
import { Context } from '../../index'
import { useSubscription } from '@apollo/client'

import { GET_USERS } from '../../hasura-queries/attendance/getUsers' 
import BaseHeader from '../BaseHeader'
import Table, { generateColumns } from './table'
import { getVarsForSubscription, monthAdd } from './functions'

import './index.sass'

// учет рабочего времени
const Attendance = props => {
    const date = new Date()

    const { store } = useContext(Context);
    const [selectedMonth, setSelectedMonth] = useState([date.getMonth()-1, date.getFullYear()])
    const [timeDeduction, setTimeDeduction] = useState(30)
    const [search, setSearch] = useState('');

    const months = ["янв", "фев", "мар", "апр", "май", "июн", "июл", "авг", "сен", "окт", "ноя", "дек"];

    
    const {gte, lte} = getVarsForSubscription(selectedMonth)

    const {loading, error, data = [] } = useSubscription(GET_USERS, { variables: { gte, lte, search: '%'+search+'%' } });


    const handleToggle = (e) => {
        const d = new Date(e.target.attributes.date.value)
        setSelectedMonth([d.getMonth(), d.getFullYear()])
    }

    const chooseMonth = () => {
        const m = []
        
        for (var i=0; i< 12; i++) {
            const suitable = monthAdd(date, -i)
            m.push(
                <div onClick={handleToggle} 
                    className={suitable.getMonth() == selectedMonth[0] ? 'active' : ''}
                    date={suitable}> {months[suitable.getMonth()]} </div>
                )
        } 
        return <div className="chooseMonth">{m}</div>
    }


    const columns = useMemo(
        () => generateColumns(selectedMonth), [handleToggle]
    )
    
    const onChangeSearch = (e) => {
        const req = e.target.value.replace(/\s/g, '')
        setSearch(req)
    }

   
    return(
        <>
            <BaseHeader pageParams = { store.getPageParams(window.location.pathname)} search={onChangeSearch} /> 

            <div className="reportConfigurator">
                {chooseMonth()}
                
                <div className="argument">
                    <span>обед</span>
                    <input type='text' defaultValue={timeDeduction} onChange={(e) => setTimeDeduction(e.target.value)}/>
                    <span>мин</span>
                    
                </div>
                <div className="argument">
                    <span>Норма часов</span>
                    <input type='text' defaultValue={timeDeduction}/>
                    <span>ч</span>
                </div>
            </div>

            { !loading && (
                <>
                    <p>Отчет за {selectedMonth[0] + 1} месяц {selectedMonth[1]} года </p>
                    <Table columns = { columns } data = { data.attendance_users_aggregate.nodes }/> 
                </>)}
           

        </>
    )
}

export default Attendance