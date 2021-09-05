import {  useMemo, useContext } from 'react';
import { Context } from '../..';
import {useSubscription} from '@apollo/client';
import PreOrders from '../OrderListLayout/PreOrders'
import { GetOrdersSubscription } from '../OrderListLayout/queries/getOrders';
import BaseHeader from '../BaseHeader';
import ActionsHeader from '../BaseHeader/ActionsHeader';
import './index.sass'

import Table, {columnsList} from '../OrderListLayout/Priority/columnList';
import  {groupOrders} from './tableLogic'

// поменять сортировку на день первой оплаты

const RecentlyLayout = ({data}) => {
    let preOrders = []; 
    let orders = [];
    const {store} = useContext(Context);
    var groupedData = null;

        if (data.erp_Orders){  
            data.erp_Orders.sort((a, b) => b.ShippingDate < a.ShippingDate ? 1: -1);  

            //отбираем предзаказы
            data.erp_Orders.forEach((order)=> {

                if (order.OrderStatus.ID == 3) {
                    preOrders.push(order);

                }else if (order.OrderStatus.ID == 1) {
                    orders.push(order);
                }
            });

            groupedData = groupOrders(orders);
        }
        
    const columns = useMemo(
        () => columnsList,
        []
      )
    

    const group = (data, heading) => {
        if (data.length == 0) return null;

        return (
            <>
            <div className='group-heading'>{heading}</div>
                <div className="tableWrap">
                <Table columns={columns} data={data} />
                </div>
            </>
        )
    }
    
    return(
         <>
            {groupedData
            ? (
                <>
                
                {group(groupedData[0].objs, 'Сегодня')}
                {group(groupedData[1].objs, 'Вчера')}
                {group(groupedData[2].objs, 'Остальные')}


{/* 
                <div className='group-heading'>сегодня</div>
                 <div className="tableWrap">
                    <Table columns={columns} data={groupedData[0].objs} thead={false} />
                 </div>

                 <div className='group-heading' >вчера</div>
                 <div className="tableWrap">
                    <Table columns={columns} data={groupedData[1].objs} thead="false"/>
                 </div>

                 <div className="tableWrap">
                    <Table columns={columnsList} data={groupedData[2].objs} />

                 </div> */}

                </> 
            ) : store.preloader }

        </>
    );
}


export default RecentlyLayout