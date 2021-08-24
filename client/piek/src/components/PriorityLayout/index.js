import { useMemo, useContext, useState } from 'react'
import { Context } from '../../index'
import { useHistory } from "react-router-dom";

//apollo
import { useSubscription } from '@apollo/client'
import { GetOrdersSubscription } from '../../hasura-queries/getOrders'

import Table, { columnsList } from './tableLogic'

//components
import PreOrders from '../PreOrders'
import BaseHeader from '../BaseHeader'
import ActionsHeader from '../BaseHeader/ActionsHeader'

//UI
import './index.sass'
import { UilSearch } from '@iconscout/react-unicons'

const PriorityLayout = () => {
    const [orders, setOrders] = useState([]);
    const [preOrders, setPreOrders] = useState([]);

    const [search, setSearch] = useState('');
    const { store } = useContext(Context);
    const history = useHistory();

    const onSubscriptionData = (options) => {
        setPreOrders([]); setOrders([]);
        const d = options.subscriptionData.data.erp_Orders

        d.sort((a, b) => b.ShippingDate < a.ShippingDate ? 1 : -1);
        
        d.forEach( (order) => {
            if (order.OrderStatus.ID == 3) setPreOrders(oldArray => [...oldArray, order])
            else if (order.OrderStatus.ID == 1) setOrders(oldArray => [...oldArray, order])
        })
    }

    const { loading, data = [] } = useSubscription(GetOrdersSubscription, { onSubscriptionData, variables: { search: '%'+search+'%' } });

    const columns = useMemo(
        () => columnsList, []
    )

    return ( 
        <div className="Container-1200">
            <BaseHeader pageParams = { store.getPageParams(window.location.pathname) }>
                <ActionsHeader createOrder={true} userID={store.user.UserID} history={history}/>
            </BaseHeader>
        
                    <PreOrders preOrders = { preOrders }/>

                    <div className="tableWrap">

                        <div className="tableSearchInput">
                            <UilSearch className="action-icon"/>
                            <input type='text' placeholder="поиск (номер счета или организация)" onChange={ (e) => setSearch(e.target.value.trim()) } autoFocus/>
                        </div>
                        <Table columns = { columns } data = { orders }/>
                    </div>
       
        </div>
    )
}
export default PriorityLayout;