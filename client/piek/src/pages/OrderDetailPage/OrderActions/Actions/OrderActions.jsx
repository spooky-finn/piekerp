import TransferOrderConfirmDialog from '../Dialogs/TransferOrderConfirmDialog'
import OS from '../../../../utils/OrderStatus';

const OrderActions = (props) => {
  const { order, transferOrderTo} = props

  if ( [OS.ordProduction].includes(order.OrderStatusID) ) return (
    <TransferOrderConfirmDialog transferOrderTo={() => transferOrderTo(3) }/>  
  )

  return null
}
export default OrderActions