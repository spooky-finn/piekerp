import { useMemo } from 'react'

// ui 
import mainsass from '../main.module.sass'

import Search from '../Search'
import { filter } from '../Search/filter'

import { columnsList } from '../UniversalTable/columnList'
import Table from '../UniversalTable/TableMarkup'


const Priority = ({ users, state, dispatch }) => {
    const data = state.orders 
    const columns = useMemo(
        () => columnsList, []
    )
  
    const filtredData = filter(data, state.searchKeyword, state.managerFilter)

    return(
        <div className={mainsass.tableWrapper}>
            <Search state={state} dispatch={dispatch} users={users}/>
            {filtredData && <Table columns = {columns} data = {filtredData} />}
        </div>
    )
}
export default Priority