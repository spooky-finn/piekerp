import { useHistory } from "react-router-dom";

import {
  Popper,
  ClickAwayListener,
  MenuList,
  Paper
} from '@mui/material/';


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
    mutationNeedAttention({
      variables: {OrderID, NeedAttention: !order.NeedAttention },
      optimisticResponse: {
          erp_Orders: {
            __typename: 'erp_Orders',
            OrderID: order.OrderID,
            NeedAttention: !order.NeedAttention
          }
        }
    })
  }
  // При статусе "ожидает отгрузки" происходит выделение зеленым цветом в очередности, что означает, что заказ уже собран,
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
    mutationMoveOrderToPriority({ variables: { 
      OrderID,
      AcceptanceDate: new Date(),
     }}).then(
      (res) =>{
        if (res.data.update_erp_Orders_by_pk.OrderID){
          refetch()
        }
      }
    )
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
    <Popper
    open={OAMenu} 
    anchorEl={OAMenuRef.current}
    >

    <Paper 
      sx={{ 
      boxShadow: '0 10px 50px 0 var(--bs)',
      background: 'var(--LI)',
       width: 200,
       maxWidth: '100%',
       borderRadius: 'var(--br)' }}> 
      <ClickAwayListener onClickAway={handleClose}>
      <MenuList>

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
        order                  = {order}
        transferOrderToArchive = {transferOrderToArchive}
        />
        <ReclamationActions
        order = {order }
        transferOrderToArchive ={transferOrderToArchive}
        mutationDeleteOrderHandler ={mutationDeleteOrderHandler}
        />
      </MenuList>
      </ClickAwayListener>
    </Paper>
  </Popper>

  
  )
}
export default OrderActionsMenu;