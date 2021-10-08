import { useMemo, useReducer } from 'react';

//apollo 
import { useQuery } from '@apollo/client'
import { GET_ARCHIVED_SEARCH_ORDERS } from './queries/getArchivedSearchOrders'

//ui
import { InputBase } from '@material-ui/core';
import sass from './archive.module.sass'
import { columnsList } from '../UniversalTable/columnList'
import Table from './TableMarkup'

import PreviewTable from './PreviewTable';

function reducer(state, action) {
  switch (action.type) {
      case 'searchKeyword': 
      case 'unpaidIDs': 
          return {...state, [action.type]: action.payload };
      default: 
          return {...state}
  }
}

const Archive = () => {
  const [state, dispatch] = useReducer(reducer, {
    //заказы которые отгружено, но еще не оплачены
    unpaidIDs: [],
    searchKeyword: '',
  });

  const { data = [] } = useQuery(GET_ARCHIVED_SEARCH_ORDERS, { variables: {
    keyword: '%' + state.searchKeyword + '%'
  }})

  const columns = useMemo(
    () => columnsList, []
  )
  
  const searchHandler = (e) => {
    setTimeout(() => {
      dispatch({ type: 'searchKeyword', payload: e.target.value})
    }, 400)
  }

  return(
    <div>
      <InputBase
        className={sass.inputWrapper}
        autoFocus
        onChange={searchHandler}
        placeholder='номер счета или юрлицо'/>

      {!state.searchKeyword && <PreviewTable state={state} dispatch={dispatch} columns={columns} /> }

      {state.searchKeyword &&  data.erp_Orders && <>
          <p className={sass.previewHeading}>Результат поиска по архиву</p>
          <Table columns = {columns} data = {data.erp_Orders} className={sass.archiveTable}/>
      </>}

    </div>
  )
}
export default Archive;