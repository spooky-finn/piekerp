import { useMemo } from 'react'

// ui 
import mainsass from '../main.module.sass'

import Search from '../Search'
import { filter } from '../Search/filter'

import { columnsList } from '../UniversalTable/columnList'
import Table from '../UniversalTable/TableMarkup'


const Priority = ({ users, state, dispatch }) => {
    const columns = useMemo(
        () => columnsList, []
    )
    
    const sortedData = state.orders .sort(function(a,b){
        return new Date(a.ShippingDate) - new Date(b.ShippingDate);
    })

    const filtredData = filter(sortedData, state.searchKeyword, state.managerFilter)

    return(
        <div className={mainsass.tableWrapper}>
            {users && <Search state={state} dispatch={dispatch} users={users.filter(e => [1,2].includes(e?.AccessLevelID))}/>}
            {filtredData && <Table columns = {columns} data = {filtredData} />}
        </div>
    )
}
export default Priority