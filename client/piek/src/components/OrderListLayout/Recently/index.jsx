import {  useMemo } from 'react';
import Table from '../UniversalTable/TableMarkup'
import { filter } from '../Search/filter'

import { columnsList } from '../UniversalTable/columnList';
import { spread } from './spreadOrders';

import { Typography } from '@mui/material'
import sass from './recently.module.sass'

const style_heading = {
    display: 'flex',
    flexDirection: 'row',
    padding: '0 10px'
}

const style_secondaty_heading = {
    color: 'var(--lowContrast)',
    fontSize: '.8rem',
    padding: '0 8px',
    textTransform: 'none'
}

const Recently = ({ state }) => {

    const sortedData = state.orders.sort(function(a,b){
        return new Date(b.AcceptanceDate) - new Date(a.AcceptanceDate);
      });

    const spreadData = spread(sortedData);

    const columns = useMemo(() => columnsList, [] )

   

    function ifNothing(data){
        if (data.length === 0) return <Typography style={style_secondaty_heading}>(Ничего не было добавлено)</Typography>
    } 

    return(
        <div>
            <Typography style={style_heading} color='textSecondary' variant="subtitle1" m='10px 0'>
                Сегодня {ifNothing(spreadData[0].objs)} 
            </Typography>

            { spreadData[0].objs.length ? ( <>
            <Table columns={columns} data={spreadData[0].objs} className={sass.recentlyTable} />
            </>): null}


            <Typography  style={style_heading} color='textSecondary' variant="subtitle1" m='10px 0'>
                Вчера {ifNothing(spreadData[1].objs)} 
            </Typography>

            { spreadData[1].objs.length ? ( <>
            <Table columns={columns} data={spreadData[1].objs} className={sass.recentlyTable} />
            </>): null}
        </div>
    )
}
export default Recently