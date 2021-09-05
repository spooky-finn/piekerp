import { useMemo } from 'react'

// ui 
import mainsass from '../main.module.sass'

import Search from '../Search'
import { filter } from '../Search/filter'

import { columnsList } from '../UniversalTable/columnList'
import Table from '../UniversalTable/TableMarkup'


const Priority = ({ data, users, incomingOrders, state, dispatch }) => {

    const searchHandler = (e) => {
        dispatch({ type: 'searchKeyword', payload: e.target.value.trim() }) 
    }
    const columns = useMemo(
        () => columnsList, []
    )
  
    const filtredData = filter(data, state.searchKeyword, state.managerFilter)

    return(
        <div className={mainsass.tableWrapper}>
            <Search state={state} dispatch={dispatch} users={users} incomingOrders={data} />
            {filtredData && <Table columns = {columns} data = {filtredData} />}
        </div>
    )
}
export default Priority