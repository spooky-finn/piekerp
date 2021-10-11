import {  useMemo } from 'react';

import Table from '../UniversalTable/TableMarkup'

import Search from '../Search'
import { filter } from '../Search/filter'

import { columnsList } from '../UniversalTable/columnList';
import { spread } from './spreadOrders';

import mainsass from '../main.module.sass'
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
            { spreadData[0].objs.length ? ( <>
            <div className={sass.heading}>Сегодня</div>
            <Table columns={columns} data={spreadData[0].objs} className={sass.recentlyTable} />
            </>): null}

            { spreadData[1].objs.length ? ( <>
            <div className={sass.heading}>Вчера</div>
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