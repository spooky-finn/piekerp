import TransferOrderConfirmDialog from '../TransferOrderConfirmDialog'
import OS from '../../../_core/OrderStatus';

const OrderActions = (props) => {
  const { order, transferOrderTo} = props

  if ( [OS.ordProduction].includes(order.OrderStatusID) ) return (
    <TransferOrderConfirmDialog transferOrderTo={transferOrderTo}/>  
  )

  return null
}
export default OrderActions