import {
  ListItemIcon,
  ListItemText,
  MenuItem,
} from '@mui/material/';
import { 
  UilArchive,
 } from '@iconscout/react-unicons'

import DeleteOrderConfirmDialog from '../TransferOrderConfirmDialog'
import OS from '../../../_core/OrderStatus';

const OrderActions = (props) => {
  const { order, transferOrderToArchive} = props

  if ( [OS.ordProduction].includes(order.OrderStatusID) ) return (
    <MenuItem>
      <ListItemIcon>
        <UilArchive/>
      </ListItemIcon>
      <ListItemText>
        <DeleteOrderConfirmDialog onConfirmF={() => transferOrderToArchive(3)}/>  
      </ListItemText>
    </MenuItem>
  )

  return null
}
export default OrderActions