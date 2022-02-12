import {
  ListItemIcon,
  ListItemText,
  MenuItem,
} from '@mui/material/';
import { 
  UilTrashAlt, 
  UilFileCheck,
 } from '@iconscout/react-unicons'

import OS from '../../../../utils/OrderStatus';


const PreOrderActions = (props) => {
  const { order, transferOrderToPriority, mutationDeleteOrderHandler} = props

  if ( [OS.ordRegistration].includes(order.OrderStatusID)) return (
    <div>
        <MenuItem onClick={transferOrderToPriority}>
        <ListItemIcon>
          <UilFileCheck/> 
        </ListItemIcon>
        <ListItemText >
            В очередность
        </ListItemText>
      </MenuItem>
      <MenuItem sx={{ color: 'var(--danger)', 'svg': {
        color: 'var(--danger)'
        }}}
        onClick={mutationDeleteOrderHandler}
        >
        <ListItemIcon>
          <UilTrashAlt/>
        </ListItemIcon>
        <ListItemText>Удалить предазказ</ListItemText>
      </MenuItem>
    </div>
  )
  return null
}
export default PreOrderActions