import { useMemo, useContext } from 'react'
import { Context } from '../../index'

//apollo
import { useSubscription } from '@apollo/client'
import { GetOrdersSubscription } from '../../hasura-queries/getOrders'

import Table, { columnsList } from './tableLogic'

//components
import PreOrders from '../PreOrders'
import BaseHeader from '../BaseHeader'
import ActionsHeader from '../BaseHeader/ActionsHeader'


const PriorityLayout = (props) => {
    let preOrders = [];
    let orders = [];
    const { store } = useContext(Context);

    const { error, loading, data = [] } = useSubscription(GetOrdersSubscription);

    if (data.erp_Orders) {
        data.erp_Orders.sort((a, b) => b.ShippingDate < a.ShippingDate ? 1 : -1);

        //отбираем предзаказы
        data.erp_Orders.forEach((order) => {
            if (order.OrderStatus.ID == 3) preOrders.push(order)
            else if (order.OrderStatus.ID == 1) orders.push(order)
        });
    }
    
    const columns = useMemo(
        () => columnsList, []
    )

    return ( 
        <>
        {/* <ActionsHeader /> */}
        <div className="Container-1200">
            <BaseHeader pageParams = { store.getPageParams(window.location.pathname) }>
                <ActionsHeader/>
            </BaseHeader>
        
            <div className='PriorityLayout'>
                {data.erp_Orders && preOrders ? ( 
                <>
                    <PreOrders preOrders = { preOrders }/>
                    <Table columns = { columns } data = { orders }/>
                    </>
                ) : store.preloader
                } 
            </div>           
        </div>
        </>
    )
}
export default PriorityLayout;