import {
  ListItemIcon,
  ListItemText,
  MenuItem,
} from '@mui/material/';
import { 
  UilTrashAlt, 
  UilFileCheck,
 } from '@iconscout/react-unicons'

import OS from '../../../_core/OrderStatus';


const PreOrderActions = (props) => {
  const { order, transferOrderToPriority, mutationDeleteOrderHandler} = props

  if ( [OS.ordRegistration].includes(order.OrderStatusID)) return (
    <div>
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
        <ListItemText onClick={mutationDeleteOrderHandler}>Удалить предазказ</ListItemText>
      </MenuItem>
    </div>
  )
  return null
}
export default PreOrderActions