import {  useMemo } from 'react';
import Table from '../UniversalTable/TableMarkup'

import { columnsList } from '../UniversalTable/columnList';
import { spread } from './spreadOrders';

import { Typography } from '@mui/material'

const styles = {
  heading :{
    display: 'flex',
    flexDirection: 'row',
    padding: '0 10px'
  },
  secondary: {
    color: 'var(--lowContrast)',
    fontSize: '.8rem',
    padding: '0 8px',
    textTransform: 'none'
  },
  table: {
    borderTop: '1px solid var(--border)'
  }
}

const Recently = ({ state }) => {

    const sortedData = state.orders.sort(function(a,b){
        return new Date(b.AcceptanceDate) - new Date(a.AcceptanceDate);
      });

    const spreadData = spread(sortedData);

    const columns = useMemo(() => columnsList, [] )

   

    function ifNothing(data){
        if (data.length === 0) return <Typography style={styles.secondary}>ничего не было добавлено</Typography>
    } 

    return(
        <>
            <Typography 
            style   = {styles.heading} 
            variant = "subtitle1" 
            m       = '10px 0'>
            Сегодня {ifNothing(spreadData[0].objs)} 
            </Typography>

            { spreadData[0].objs.length ? ( <>
              <Table 
              columns = {columns} 
              data    = {spreadData[0].objs} 
              style   = {styles.table} />
              </>): 
            null}


            <Typography  
            style={styles.heading} 
            variant="subtitle1" 
            m='10px 0'>
            Вчера {ifNothing(spreadData[1].objs)} 
            </Typography>

            { spreadData[1].objs.length ? ( <>
              <Table 
                columns = {columns} 
                data    = {spreadData[1].objs} 
                style   = {styles.table} />
            </>): null}
        </>
    )
}
export default Recently