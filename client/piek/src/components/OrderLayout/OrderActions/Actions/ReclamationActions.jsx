import {
  MenuItem,
  ListItemIcon,
  ListItemText
} from '@mui/material/';

import { 
  UilTrashAlt, 
} from '@iconscout/react-unicons'

import TransferOrderConfirmDialog from '../Dialogs/TransferOrderConfirmDialog';
import OS from '../../../_core/OrderStatus';

const ReclamationActions = (props) => {
  const { order, transferOrderToArchive, mutationDeleteOrderHandler } = props
  const ifInbox = () => {
    if (order.OrderStatusID === OS.reclInbox) return true
  }

  // const ifDecision = () => {
  //   if (order.OrderStatusID === OS.reclDecision) return true
  // }

  const ifInproduction = () => {
    if (order.OrderStatusID === OS.reclProduction) return true
  }

 return (<>
  {ifInproduction() && 
        <TransferOrderConfirmDialog transferOrderTo={() => transferOrderToArchive(13)}/>  
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