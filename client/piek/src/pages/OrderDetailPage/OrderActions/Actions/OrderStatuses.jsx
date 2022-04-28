import OS from '../../../../utils/OrderStatus'
import { useMutation } from "@apollo/client"
import { 
    UPDATE_AWAITING_DISPATCH,
    UPDATE_NEED_ATTENTION,
  } from '../../queries/MutationOrderInfo'

import {  UilExclamationTriangle,  UilClockThree } from '@iconscout/react-unicons'


const OrderStatus = (props) => {
    const { order, renderAlg} = props
    
    const [mutationAwaitingDispatch] = useMutation(UPDATE_AWAITING_DISPATCH);
    const [mutationNeedAttention] = useMutation(UPDATE_NEED_ATTENTION);

    // При статусе "требует внимания" происходит выделение заказа красным цветом в очередности. 
    // В левом меню в информации о заказе фиксируется  дата включения этого статуса.  
    // Желательно чтобы возможность снятия была только у определенных аккаунтов .  
    // Это необходимо когда при открытии заказа выясняется дефицит комплектующих или по заказу требуются срочные уточнения от заказчика какие-нибудь.
    function needAttentionHandler(){
        const curDate = new Date().toISOString()
        var payload = [];
        if (!order.NeedAttention) payload = ['true', curDate, 'null']
        else {
        const nd = order.NeedAttention.split(',')
        if (nd[0] === 'true') payload = ['false', nd[1], curDate]
        if (nd[0] === 'false') payload = ['true', curDate, 'null']
        }
        
        mutationNeedAttention({
        variables: {
            OrderID: order.OrderID, 
            NeedAttention: payload.join(',')
        },
        // optimisticResponse: {
        //     erp_Orders: {
        //         __typename: 'erp_Orders',
        //         OrderID: order.OrderID,
        //         NeedAttention: payload.join(',')
        //     }
        //     }
        })
    }
    // При статусе "ожидает отгрузки" происходит
    //  выделение зеленым цветом в очередности, что означает, что заказ уже собран,
    // и не отгружается по бумажным причинам
    function awaitingDispatchHandler(){
        mutationAwaitingDispatch({
        variables: {OrderID: order.OrderID, AwaitingDispatch: !order.AwaitingDispatch },
        optimisticResponse: {
            erp_Orders: {

                __typename: 'erp_Orders',
                // OrderID: order.OrderID,
                ...order,
                AwaitingDispatch: !order.AwaitingDispatch
            }
            }
        })
    }

    const needAttention = ( order.NeedAttention?.split(',')[0] === 'true' )
    
    const statusButtons = [
        {
            tip: 'Требует внимания',
            handler: needAttentionHandler,
            icon: UilExclamationTriangle,
            className: needAttention ? 'iconBtnPressed' : '',
            requirement: ![OS.ordArchived, OS.reclArchived].includes(order.OrderStatusID) 
        },
        {
            tip: 'Готов к отгрузке',
            handler: awaitingDispatchHandler,
            icon: UilClockThree,
            className: order.AwaitingDispatch ? 'iconBtnPressed' : '',
            requirement: [OS.ordProduction, OS.reclProduction].includes(order.OrderStatusID) 
        }
    ]

    return renderAlg(statusButtons)
}

export default OrderStatus