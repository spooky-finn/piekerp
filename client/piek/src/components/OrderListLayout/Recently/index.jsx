import {  useMemo } from 'react';

import Table from '../UniversalTable/TableMarkup'

import Search from '../Search'
import { filter } from '../Search/filter'

import { columnsList } from '../UniversalTable/columnList';
import { spread } from './spreadOrders';

import mainsass from '../main.module.sass'
import sass from './recently.module.sass'

const Recently = ({ state, dispatch }) => {
    const data = state.orders
    data.sort((a, b) => b.ShippingDate > a.ShippingDate ? 1: -1);  

    const spreadData = spread(data);

    const columns = useMemo(
        () => columnsList,
        []
    )

    const filtredData = filter(spreadData[2].objs, state.searchKeyword)

    return(
        <div>
            <div className={sass.heading}>Сегодня</div>
            <Table columns={columns} data={spreadData[0].objs} className={sass.recentlyTable} />

            <div className={sass.heading}>Вчера</div>
            <Table columns={columns} data={spreadData[1].objs} className={sass.recentlyTable} />


            <div className={sass.heading}>Остальные</div>
            <div className={mainsass.tableWrapper}>
                <Search state={state} dispatch={dispatch} incomingOrders={data} />
                { <Table columns = { columns } data = { filtredData } />}
            </div>

        </div>
    )
}
export default Recently