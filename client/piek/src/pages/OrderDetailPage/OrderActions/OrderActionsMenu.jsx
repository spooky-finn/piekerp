import { useHistory } from "react-router-dom";
import { notif } from "../../../utils/notification";

import {
  Menu
} from '@mui/material/';

import { store } from 'react-notifications-component';
import 'react-notifications-component/dist/theme.css'

//apollo
import { useMutation } from "@apollo/client"
import { 
  UPDATE_AWAITING_DISPATCH,
  UPDATE_NEED_ATTENTION,
  MOVE_ORDER_TO_ARCHIVE,
  MOVE_ORDER_TO_PRIORITY
} from '../queries/MutationOrderInfo'
import { DELETE_ORDER } from '../queries/MutationDeleteOrder';

import OrderActions from "./Actions/OrderActions";
import PreOrderActions from "./Actions/PreOrderActions";
import OrderStatusesActions from "./Actions/OrderStatusesActions";

import ReclamationActions from "./Actions/ReclamationActions";

const OrderActionsMenu = props => {
  const OrderID = props.order.OrderID 
  const { OAMenu, setOAMenu, OAMenuRef, order, refetch} = props

  const [mutationAwaitingDispatch] = useMutation(UPDATE_AWAITING_DISPATCH);
  const [mutationNeedAttention] = useMutation(UPDATE_NEED_ATTENTION);
  const [mutationMoveOrderToArchive] = useMutation(MOVE_ORDER_TO_ARCHIVE);
  const [mutationMoveOrderToPriority] = useMutation(MOVE_ORDER_TO_PRIORITY);
  const [mutationDeleteOrder] = useMutation(DELETE_ORDER);

  const history = useHistory();

  const baseurl = () => {
    if ( [1,2].includes(order.OrderStatusID) ) return '/'
    if ( [10,11,12].includes(order.OrderStatusID) ) return '/reclamation'
  }

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
        OrderID, 
        NeedAttention: payload.join(',')
      },
      optimisticResponse: {
          erp_Orders: {
            __typename: 'erp_Orders',
            OrderID: order.OrderID,
            NeedAttention: payload.join(',')
          }
        }
    })
  }
  // При статусе "ожидает отгрузки" происходит
  //  выделение зеленым цветом в очередности, что означает, что заказ уже собран,
  // и не отгружается по бумажным причинам
  function awaitingDispatchHandler(){
    mutationAwaitingDispatch({
      variables: {OrderID, AwaitingDispatch: !order.AwaitingDispatch },
      optimisticResponse: {
          erp_Orders: {
            __typename: 'erp_Orders',
            OrderID: order.OrderID,
            AwaitingDispatch: !order.AwaitingDispatch
          }
        }
    })
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
          history.push(baseurl())
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
      notif('success', 'Добавлен в очередность');
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

  const handleClose = (event) => {
    setOAMenu(false);
  };

  return (
    <Menu
    open={OAMenu} 
    onClose={handleClose}
    anchorEl={OAMenuRef.current}
    >

        <OrderStatusesActions
        order                   = {order}
        awaitingDispatchHandler = {awaitingDispatchHandler}
        needAttentionHandler    = {needAttentionHandler}
        />

        <PreOrderActions 
        order                      = {order}
        transferOrderToPriority    = {transferOrderToPriority}
        mutationDeleteOrderHandler = {mutationDeleteOrderHandler}
        />
        <OrderActions 
        order           = {order}
        transferOrderTo = {transferOrderToArchive}
        />
        <ReclamationActions
        order = {order}
        transferOrderToArchive ={transferOrderToArchive}
        mutationDeleteOrderHandler ={mutationDeleteOrderHandler}
        />
  </Menu>
  )
}
export default OrderActionsMenu;