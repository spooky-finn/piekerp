import { useState } from 'react'
import sass from './shipment.module.sass'
import { CornerDialog, Button, Checkbox } from 'evergreen-ui'
import { useMutation } from "@apollo/client"
import { useHistory } from "react-router-dom";

import { 
  UPDATE_AWAITING_DISPATCH,
  UPDATE_ORDER_STATUS } from '../queries/MutationOrderInfo'

const Shipment = (props) => {
  const { data, orderID } = props
  const [isShown, setIsShown] = useState(false)
  const history = useHistory();
  const [mutateAwaitingDispatch] = useMutation(UPDATE_AWAITING_DISPATCH);
  const [mutateOrderStatus] = useMutation(UPDATE_ORDER_STATUS);

  

  function awaitingDispatchHandler(){
    mutateAwaitingDispatch({
      variables: {orderID, awaitingDispatch: !data.AwaitingDispatch },
      optimisticResponse: {
          erp_Orders: {
            __typename: 'erp_Orders',
            OrderID: orderID,
            AwaitingDispatch: !data.AwaitingDispatch
          }
        }
    })
  }
  async function TransferOrder(){
    mutateOrderStatus({ variables: { OrderID: orderID }}).then(
      (res) =>{
        if (res.data.update_erp_Orders_by_pk.OrderStatusID === 3){
          history.push("/")
        }
      }
    )
  }

  if (data.OrderStatusID !== 2) return null
  return (
    <div>
        <CornerDialog
          title="Перенести в архив?"
          isShown={isShown}
          confirmLabel='Перенести'
          onConfirm={TransferOrder}
          cancelLabel='Не нужно'
          onCloseComplete={() => setIsShown(false)}
        >
          Заказ удалится из очередности, но его в любое время можно будет найти в архиве по номеру счета, юрлицу, маркировке привода.
        </CornerDialog>
        <Checkbox className={sass.checkbox} label="Ожидает отгрузки" onChange={awaitingDispatchHandler} checked={data.AwaitingDispatch}/>
        <Button onClick={() => setIsShown(true)} className={sass.btn} appearance="primary">Отгружен</Button>
    </div>
  )
}
export default Shipment