import { useMemo, useState } from 'react';

//apollo 
import { useQuery } from '@apollo/client'
import { GET_ARCHIVED_ORDERS } from './GET_ARCHIVED_ORDERS';

//ui
import { InputBase } from '@material-ui/core';
import sass from './archive.module.sass'
import mainsass from '../main.module.sass'
import { columnsList } from '../UniversalTable/columnList'
import Table from '../UniversalTable/TableMarkup'

const Archive = () => {
  const [search, setSearch] = useState('');
  const { loading, data = [], refetch } = useQuery(GET_ARCHIVED_ORDERS);

  const columns = useMemo(
    () => columnsList, []
  )

  const searchHandler = (e) => {
    setSearch(e.target.value)
  }

  return(
    <div>
      <InputBase
        className={sass.inputWrapper}
        autoFocus
        onChange={searchHandler}
        placeholder='Счет, город или компания'/>


      {search && data.erp_Orders &&  
        <div className={mainsass.tableWrapper}>
        <Table columns = {columns} data = {data.erp_Orders} className={sass.archiveTable}/>
        </div>
      }

    </div>
  )
}
export default Archive