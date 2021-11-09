import { useMemo, useReducer } from 'react';

//apollo 
import { useQuery } from '@apollo/client'
import { GET_ARCHIVED_SEARCH_ORDERS } from './queries/getArchivedSearchOrders'

//ui
import sass from './archive.module.sass'
import { columnsList } from '../UniversalTable/columnList'
import Table from './TableMarkup'
import { Typography, InputBase } from '@mui/material/';

import PreviewTable from './PreviewTable';

import InputLabel from '@mui/material/InputLabel';
import MenuItem from '@mui/material/MenuItem';
import FormControl from '@mui/material/FormControl';
import Select from '@mui/material/Select';

import OS from '../../_core/OrderStatus'
import moment from 'moment'

import TableSearch from '../../_core/mui/TableSearch'

function reducer(state, action) {
  switch (action.type) {
      case 'reqOrderStatus': 
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
    reqOrderStatus: OS.ordArchived,
    unpaidIDs: [],
    searchKeyword: '',
  });

  const handleChange = (event) => {
    dispatch({ type: 'reqOrderStatus', payload: event.target.value })
  };

  const { data = [] } = useQuery(GET_ARCHIVED_SEARCH_ORDERS, { variables: {
    keyword: '%' + state.searchKeyword + '%',
    OrderStatus: state.reqOrderStatus
  }})

  var columns = useMemo(
    () => [...columnsList], []
  )
  
  columns[3] = {
    Header: 'Факт отгрузка',
    accessor: order => 
    <> { order.ActualShippingDate && moment(order.ActualShippingDate).format('DD.MM.YY') }
    </>
  }

  const searchHandler = (e) => {
    setTimeout(() => {
      dispatch({ type: 'searchKeyword', payload: e.target.value})
    }, 400)
  }

  return(
    <>
      <TableSearch
      placeholder='Cчет, юрлицо'
      onChange={searchHandler}
      />

      <FormControl className={sass.filterFormControl}>
        <InputLabel variant="filter">Выбрать только </InputLabel>
        <Select
          labelId="demo-simple-select-label"
          id="demo-simple-select"
          value={state.reqOrderStatus}
          label="Age"
          className={sass.filterInputBase}
          onChange={handleChange}
        >
          <MenuItem value={OS.ordArchived}>Заказы</MenuItem>
          <MenuItem value={OS.reclArchived}>Рекламации</MenuItem>
        </Select>
      </FormControl>

      {!state.searchKeyword && < PreviewTable 
          state    = {state} 
          dispatch = {dispatch} 
          columns  = {columns} 
          /> }

      {state.searchKeyword &&  data.erp_Orders && <>
          <Typography color='textSecondary' variant="subtitle1" m='10px 1rem'>
            Результат поиска по архиву
          </Typography>
          <Table columns = {columns} data = {data.erp_Orders} className={sass.archiveTable}/>
      </>}

    </>
  )
}
export default Archive;