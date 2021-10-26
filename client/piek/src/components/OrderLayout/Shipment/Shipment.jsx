import { useState } from 'react'
import sass from './shipment.module.sass'
import { useMutation } from "@apollo/client"
import { useHistory } from "react-router-dom";

import { 
  UPDATE_AWAITING_DISPATCH,
  UPDATE_ORDER_STATUS } from '../queries/MutationOrderInfo'
import { DELETE_ORDER } from '../queries/MutationDeleteOrder';

import ConfirmDialog from './ConfirmDialog'
import { Button, Checkbox, FormControlLabel } from '@mui/material';

const Shipment = (props) => {
  const { data, orderID } = props
  const history = useHistory();
  const [mutateAwaitingDispatch] = useMutation(UPDATE_AWAITING_DISPATCH);
  const [mutateOrderStatus] = useMutation(UPDATE_ORDER_STATUS);
  const [deleteOrder] = useMutation(DELETE_ORDER);

  function deleteOrderHandler(){
    deleteOrder({ variables: {
      OrderID: orderID
    }}).then( res => {
      if (res.data.delete_erp_Orders_by_pk.OrderID){
        history.push("/")
      }
    })
  }
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
    mutateOrderStatus({ variables: { 
      OrderID: orderID,
      ActualShippingDate: new Date()
     }}).then(
      (res) =>{
        if (res.data.update_erp_Orders_by_pk.OrderStatusID === 3){
          history.push("/")
        }
      }
    )
  }

  if (data.OrderStatusID === 3) return null
  if (data.OrderStatusID === 1) return (
    <div>
        <Button onClick={deleteOrderHandler} color='secondary'>
          Удалить предзаказ
        </Button>
    </div>
  )
  return (
    <div>
        {/* <Checkbox className={sass.checkbox} marginTop={0} label="Ожидает отгрузки" onChange={awaitingDispatchHandler} checked={data.AwaitingDispatch}/> */}

        <FormControlLabel 
        sx={{
          margin: 0,
          padding: '0 0 10px',
        }}
        className={sass.checkbox}
        control={<Checkbox 
        onChange={awaitingDispatchHandler}
        checked={data.AwaitingDispatch}
        />} label="Ожидает отгрузки" />

        <ConfirmDialog onConfirmF={TransferOrder}/>
    </div>
  )
}
export default Shipment