import {  useMemo, useContext } from 'react';
import { Context } from '../..';
import {useSubscription} from '@apollo/client';
import PreOrders from '../PreOrders'
import { GetOrdersSubscription } from '../../hasura-queries/getOrders';
import BaseHeader from '../BaseHeader';
import ActionsHeader from '../BaseHeader/ActionsHeader';
import './index.sass'

import Table, {columnsList} from '../PriorityLayout/tableLogic';
import  {groupOrders} from './tableLogic'

// поменять сортировку на день первой оплаты

const RecentlyLayout = (props) => {
    let preOrders = []; 
    let orders = [];
    const {store} = useContext(Context);
    var groupedData = null;

    const { data = {} } = useSubscription(GetOrdersSubscription);

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
    

    return(
         <>
        <ActionsHeader/>
        <div className="Container-1200">
            <BaseHeader pageParams={store.getPageParams(window.location.pathname)} />
            
            {groupedData
            ? (
                <>
                <PreOrders preOrders={preOrders}/>
                {console.log(groupedData)}
                <Table columns={columns} data={groupedData[0].objs} heading="Сегодня"/>
                <Table columns={columns} data={groupedData[1].objs} heading="Вчера"/>
                <Table columns={columnsList} data={groupedData[2].objs} />
                </> 
            ) : store.preloader }

        </div>
       
        {props.children}
        </>
    );
}


export default RecentlyLayout