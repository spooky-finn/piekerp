import {  useMemo } from 'react';
import Table from '../UniversalTable/TableMarkup'
import { filter } from '../Search/filter'

import { columnsList } from '../UniversalTable/columnList';
import { spread } from './spreadOrders';

import { Typography } from '@mui/material'
import sass from './recently.module.sass'

const Recently = ({ state, dispatch }) => {

    const sortedData = state.orders.sort(function(a,b){
        return new Date(b.AcceptanceDate) - new Date(a.AcceptanceDate);
      });

    const spreadData = spread(sortedData);

    const columns = useMemo(() => columnsList, [] )

    const filtredData = filter(spreadData[2].objs, state.searchKeyword)

    return(
        <div>
            <Typography color='textSecondary' variant="subtitle1" m='10px 0'>
                Сегодня
            </Typography>
            { spreadData[0].objs.length ? ( <>
           
            <Table columns={columns} data={spreadData[0].objs} className={sass.recentlyTable} />
            </>): null}


            <Typography color='textSecondary' variant="subtitle1" m='10px 0'>
                Вчера
            </Typography>
            { spreadData[1].objs.length ? ( <>
          
            <Table columns={columns} data={spreadData[1].objs} className={sass.recentlyTable} />
            </>): null}

            {/* <div className={sass.heading}>Остальные</div>
            <div className={mainsass.tableWrapper}>
                <Search state={state} dispatch={dispatch} incomingOrders={sortedData} />
                { <Table columns = { columns } data = { filtredData } />}
            </div> */}

        </div>
    )
}
export default Recently