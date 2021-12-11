import {
  MenuItem,
  ListItemIcon,
  ListItemText
} from '@mui/material/';

import { 
  UilTrashAlt, 
  UilArchive 
} from '@iconscout/react-unicons'

import TransferOrderConfirmDialog from '../TransferOrderConfirmDialog';
import OS from '../../../_core/OrderStatus';

const ReclamationActions = (props) => {
  const { order, transferOrderToArchive, mutationDeleteOrderHandler } = props
  const ifInbox = () => {
    if (order.OrderStatusID === OS.reclInbox) return true
  }

  const ifDecision = () => {
    if (order.OrderStatusID === OS.reclDecision) return true
  }

  const ifInproduction = () => {
    if (order.OrderStatusID === OS.reclProduction) return true
  }

 return (<>
  {ifInproduction() && 
    <MenuItem onConfirmF={() => transferOrderToArchive(13) }>
      <ListItemIcon>
        <UilArchive/>
      </ListItemIcon>
      <ListItemText>
        <TransferOrderConfirmDialog />  
      </ListItemText>
    </MenuItem>
  }
  {ifInbox() && 
      <MenuItem sx={{ color: 'var(--danger)', 'svg': {
        color: 'var(--danger)'
      }}}
      onClick={mutationDeleteOrderHandler}
      >
      <ListItemIcon>
        <UilTrashAlt/>
      </ListItemIcon>
      <ListItemText >Удалить</ListItemText>
      </MenuItem>
    }

 </>)
}
export default ReclamationActions