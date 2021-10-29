import { useHistory } from "react-router-dom";

import {
  Popper,
  ClickAwayListener,
  ListItemIcon,
  ListItemText,
  MenuItem,
  MenuList,
  Paper,
  Divider
} from '@mui/material/';
import { 
  UilTrashAlt, 
  UilArchive, 
  UilClock,
  UilFileCheck,
  UilExclamationTriangle } from '@iconscout/react-unicons'

//apollo
import { useMutation } from "@apollo/client"
import { 
  UPDATE_AWAITING_DISPATCH,
  UPDATE_NEED_ATTENTION,
  MOVE_ORDER_TO_ARCHIVE,
  MOVE_ORDER_TO_PRIORITY
} from '../queries/MutationOrderInfo'
import { DELETE_ORDER } from '../queries/MutationDeleteOrder';

import DeleteOrderConfirmDialog from './DeleteOrderConfirmDialog'

const OrderActionsMenu = props => {
  const OrderID = props.order.OrderID 
  const { OAMenu, setOAMenu, OAMenuRef, order, refetch} = props

  const [mutateAwaitingDispatch] = useMutation(UPDATE_AWAITING_DISPATCH);
  const [mutateNeedAttention] = useMutation(UPDATE_NEED_ATTENTION);
  const [mutateMoveOrderToArchive] = useMutation(MOVE_ORDER_TO_ARCHIVE);
  const [mutateMoveOrderToPriority] = useMutation(MOVE_ORDER_TO_PRIORITY);
  const [deleteOrder] = useMutation(DELETE_ORDER);

  const history = useHistory();

  // При статусе "требует внимания" происходит выделение заказа красным цветом в очередности. 
  // В левом меню в информации о заказе фиксируется  дата включения этого статуса.  
  // Желательно чтобы возможность снятия была только у определенных аккаунтов .  
  // Это необходимо когда при открытии заказа выясняется дефицит комплектующих или по заказу требуются срочные уточнения от заказчика какие-нибудь.
  function needAttentionHandler(){
    mutateNeedAttention({
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
    mutateAwaitingDispatch({
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
  async function transferOrderToArchive(){
    mutateMoveOrderToArchive({ variables: { 
      OrderID,
      ActualShippingDate: new Date()
     }}).then(
      (res) =>{
        if (res.data.update_erp_Orders_by_pk.OrderStatusID === 3){
          history.push("/")
        }
      }
    )
  }

  // Перекидывает предзаказ в очередность 
  async function transferOrderToPriority(){
    mutateMoveOrderToPriority({ variables: { 
      OrderID,
      AcceptanceDate: new Date()
     }}).then(
      (res) =>{
        console.log(res)
        if (res.data.update_erp_Orders_by_pk.OrderStatusID === 2){
          refetch()
        }
      }
    )
  }
  
  // для удаления предзаказа
  function deleteOrderHandler(){
    deleteOrder({ variables: {
      OrderID
    }}).then( res => {
      if (res.data.delete_erp_Orders_by_pk.OrderID){
        history.push("/")
      }
    })
  }

  const handleClose = (event) => {
    setOAMenu(false);
  };

  function isPreOrder(){if (order.OrderStatusID === 1) return true; else return false}

  return (
    <Popper
    open={OAMenu} 
    anchorEl={OAMenuRef.current}
    >

    <Paper 
      sx={{ 
      boxShadow: '0 0 1px 0',
       width: 200,
       maxWidth: '100%',
       borderRadius: 'var(--br)' }}> 
      <ClickAwayListener onClickAway={handleClose}>
      <MenuList>

        {!isPreOrder() && (<div>
        <MenuItem 
          className={ order.AwaitingDispatch? 'awaitingDispatch': ''}
          onClick={awaitingDispatchHandler}>
          <ListItemIcon>
            <UilClock/>
          </ListItemIcon>
          <ListItemText>Ожидает отгрузки</ListItemText>
        </MenuItem>
        <MenuItem 
        className={ order.NeedAttention? 'needAttention': ''}
        onClick={needAttentionHandler}>
          <ListItemIcon>
            <UilExclamationTriangle/>
          </ListItemIcon>
          <ListItemText>Требует внимания</ListItemText>
        </MenuItem>
        <Divider/>
        <MenuItem>
          <ListItemIcon>
            <UilArchive/>
          </ListItemIcon>
          <ListItemText>
            <DeleteOrderConfirmDialog onConfirmF={transferOrderToArchive}/>  
          </ListItemText>
        </MenuItem>
        </div>)}


        { isPreOrder() && (<div>
         <MenuItem>
         <ListItemIcon>
          <UilFileCheck/> 
         </ListItemIcon>
         <ListItemText onClick={transferOrderToPriority}>
            В очередность
         </ListItemText>
       </MenuItem>

        <MenuItem sx={{ color: 'var(--danger)', 'svg': {
          color: 'var(--danger)'
        }}}>
          <ListItemIcon>
            <UilTrashAlt/>
          </ListItemIcon>
          <ListItemText onClick={deleteOrderHandler}>Удалить предазказ</ListItemText>
        </MenuItem>
        </div>)}
        
      </MenuList>
      </ClickAwayListener>
    </Paper>
  </Popper>

  
  )
}
export default OrderActionsMenu;