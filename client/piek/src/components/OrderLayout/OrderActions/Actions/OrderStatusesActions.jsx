import {
  ListItemIcon,
  ListItemText,
  MenuItem,
} from '@mui/material/';
import { 
  UilExclamationTriangle, 
  UilClock,
 } from '@iconscout/react-unicons'
import OS from '../../../_core/OrderStatus';

const OrderStatusesActions = (props) => {
  const { order, needAttentionHandler, awaitingDispatchHandler} = props

  const needAttention = ( order.NeedAttention?.split(',')[0] === 'true' )

  if ( [OS.ordProduction, OS.reclInbox, OS.reclDecision, OS.reclProduction].includes(order.OrderStatusID) ) return (
    <div>
      <MenuItem 
        className={ order.AwaitingDispatch? 'awaitingDispatch': ''}
        onClick={awaitingDispatchHandler}>
        <ListItemIcon>
          <UilClock/>
        </ListItemIcon>
        <ListItemText>Ожидает отгрузки</ListItemText>
      </MenuItem>
      <MenuItem 
        className={ needAttention ? 'needAttention': ''}
        onClick={needAttentionHandler}>
        <ListItemIcon>
          <UilExclamationTriangle/>
        </ListItemIcon>
        <ListItemText>Требует внимания</ListItemText>
      </MenuItem>
    </div>
  )
  return null
}
export default OrderStatusesActions