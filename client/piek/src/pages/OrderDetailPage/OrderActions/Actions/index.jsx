import { useContext } from 'react';
import { Context } from '../../../../index'
import { useHistory } from "react-router-dom";

//apollo
import { useMutation } from "@apollo/client"
import { 
  MOVE_ORDER_TO_ARCHIVE,
  MOVE_ORDER_TO_PRIORITY
} from '../../queries/MutationOrderInfo'
import { DELETE_ORDER } from '../../queries/MutationDeleteOrder';

import OS from '../../../../utils/OrderStatus';
import US from "../../../../utils/UserStatus";

import { Button, Box } from '@mui/material'
import { UilPlus, UilLock, UilUnlock, UilTruck, UilFileCheck, UilTrashAlt } from '@iconscout/react-unicons';
import sass from '../../sass/order.module.sass'
import { notif } from "../../../../utils/notification";


import TransferOrderDialog from '../Dialogs/TransferOrderDialog';
import DeleteOrderDialog from '../Dialogs/DeleteOrderDialog';

import OrderStatuses from "./OrderStatuses.jsx";


function renderAlg(arrayOfBtns){
    /*The buttons render algoritm recive an array which consists of buttons, like an object
    {
        tip: tooltip name,
        handler: mutation or some another function,
        icon: icon component,
        requirement: the condition under which will be render this button,
        className: specific class 
    },
    */

    // if (!arrayOfBtns.length) return null
    const renderResult = arrayOfBtns.map( each => {
        if (each.requirement || each.requirement === undefined){

            const btnComponent = <Button key={each.tip} 
                variant = "iconic" data-tip={each.tip} 
                onClick={each.handler} className={each.className}>
                    <each.icon/>
                </Button>

            if (each.dialog) return <each.dialog handler={each.dialogHandler} key={each.tip}> {btnComponent} </each.dialog>
            else return btnComponent
        }
    })
    
    // if (!renderResult.filter( each=> each)) return null
    if (!renderResult.filter( each=> each).length) return null
    // console.log(renderResult,renderResult.filter( each=> each));
    return <Box className={sass.groupOrderButtons}>{renderResult.filter( each=> each)}</Box>
}

const OrderActions = props => {
    const { order, editState, setEditState, setOIDialog } = props
    const OrderID = order.OrderID
    const { store } = useContext(Context);

    const isHaveFullRight = [ US.general, US.management, US.bookkeeping].includes(store.user.AccessLevelID)

    const [mutationMoveOrderToArchive] = useMutation(MOVE_ORDER_TO_ARCHIVE);
    const [mutationMoveOrderToPriority] = useMutation(MOVE_ORDER_TO_PRIORITY);
    const [mutationDeleteOrder] = useMutation(DELETE_ORDER);
  
    const history = useHistory();
  
    const baseurl = () => {
      if ( [1,2].includes(order.OrderStatusID) ) return '/'
      if ( [10,11,12].includes(order.OrderStatusID) ) return '/reclamation'
    }
  
    // Перекидывает заказ в архив (убирает из очередности)
    async function transferOrderToArchive(OrderStatusID){
      mutationMoveOrderToArchive({ variables: { 
        OrderID,
        ActualShippingDate: new Date(),
        OrderStatusID
       }}).then(
        (res) =>{
          if (res.data.update_erp_Orders_by_pk.OrderID){
            notif('success', 'Заказ перенесен в архив')
          }
        }
      )
    }
  
    // Перекидывает предзаказ в очередность 
    async function transferOrderToPriority(){
      const res = await mutationMoveOrderToPriority({ variables: { 
        OrderID,
        AcceptanceDate: new Date(),
       }})
       if (res.data.update_erp_Orders_by_pk.OrderID){
        notif('success', 'Заказ внесен в очередность выполнения');
      }
    }
    
    // для удаления заказа
    function mutationDeleteOrderHandler(){
      mutationDeleteOrder({ variables: {
        OrderID
      }}).then( res => {
        if (res.data.delete_erp_Orders_by_pk.OrderID){
          history.push(baseurl())
        }
      })
    }


    const buttons = [
        {
            tip: 'В очередность',
            handler: transferOrderToPriority,
            icon: UilFileCheck,
            requirement: isHaveFullRight && [OS.ordRegistration].includes(order.OrderStatusID),
        },
        {
            dialog: TransferOrderDialog,
            dialogHandler: () => transferOrderToArchive(3),
            tip: 'Закрыть заказ',
            icon: UilTruck,
            requirement: [ OS.ordProduction ].includes(order.OrderStatusID),
        },
        {
            dialog: TransferOrderDialog,
            dialogHandler: () => transferOrderToArchive(13),
            tip: 'Закрыть рекламацию',
            icon: UilTruck,
            requirement: [ OS.reclProduction].includes(order.OrderStatusID),
        },
        {
            dialog: DeleteOrderDialog,
            dialogHandler: mutationDeleteOrderHandler,
            tip: 'Удалить заказ',
            icon: UilTrashAlt,
            requirement: isHaveFullRight && [OS.ordRegistration, OS.ordProduction, OS.reclInbox, OS.reclDecision, OS.reclInbox].includes(order.OrderStatusID),
        },
        {
            tip: 'Добавить позицию',
            handler: () => setOIDialog(true),
            icon: UilPlus,
            requirement: isHaveFullRight && ![OS.ordArchived, OS.reclArchived].includes(order.OrderStatusID),
        },
        {
            tip: 'Поменять что-то',
            handler: () => setEditState(!editState),
            icon: editState ? UilUnlock : UilLock,
            requirement: isHaveFullRight,
        }
    ]

    return <>
            <OrderStatuses order={order} renderAlg={renderAlg}/>
            
            {renderAlg(buttons)}
    </>
}

export default OrderActions