import { useMutation, useQuery, useSubscription } from "@apollo/client";
import { useState } from "react";
import { useHistory } from "react-router-dom";
import useAppContext from "../../hooks/useAppContext";
import { GetOrdersSubscription } from "./queries/getOrders";
import { INSERT_ORDER } from "./queries/MutationInsertOrder";

import OS from "../../lib/constants/OrderStatus";
import { GET_USERS } from "../../hasura-queries/getUsers";
import useFetch from '../../hooks/useFetch'

export default function useOrderListPage() {

    const { store } = useAppContext();
    const [data, setData] = useState({
        ordersProduction: store.cachedOrders.filter(each => each.OrderStatus.ID === OS.ordProduction),
        ordersRegistration: store.cachedOrders.filter(each => each.OrderStatus.ID === OS.ordRegistration),
    })
    const history = useHistory();

    const [insertOrderMutation] = useMutation(INSERT_ORDER, {
        variables: {
            'managerID': store.user.UserID,
            'orderStatusID': OS.ordRegistration,
        }
    })


    const { data: managers } = useQuery(GET_USERS)
    const { data: unpaidOrders } = useFetch('/orders/unpaid')

    const onSubscriptionData = (options) => {
        const orders = options.subscriptionData.data.erp_Orders
        store.cachedOrders = orders;
        setData(prevstate => ({
            ...prevstate,
            ordersProduction: orders.filter(each => each.OrderStatus.ID === OS.ordProduction),
            ordersRegistration: orders.filter(each => each.OrderStatus.ID === OS.ordRegistration),
        }))
    }

    function insertOrderHandler() {
        insertOrderMutation().then((res) => {
            // TODO: add check on error responce
            console.log(' // TODO: add check on error responce', res)
            history.push(`/orders/${res.data.insert_erp_Orders.returning[0].OrderID}?edit=true`)
        })
    }


    const { error } = useSubscription(GetOrdersSubscription, { onSubscriptionData });


    if (error) console.error(error)
    return {
        data: {
            ordersRegistration: data?.ordersRegistration,
            ordersProduction: data?.ordersProduction,

            ordersUnpaid: unpaidOrders?.erp_Orders,
            managers: managers?.erp_Users,
        },
        insertOrderHandler,
    }
}