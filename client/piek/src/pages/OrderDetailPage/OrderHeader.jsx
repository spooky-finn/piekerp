import { useState, useRef } from "react";

import { Typography, Box } from '@mui/material'

import OS from "../../lib/constants/OrderStatus";

import sass from './sass/order.module.sass'
import OrderActions from "./OrderActions/Actions/";

function orderStatus(order) {
  // add a note to the title if this is a pre-order
  if (order.OrderStatusID === OS.ordRegistration) return ' Предзаказ';
  if (order.OrderStatusID === OS.ordArchived) return ' В архиве';
  if ([OS.reclInbox, OS.reclDecision, OS.reclProduction, OS.reclArchived].includes(order.OrderStatusID)) return ' Рекламация';
}

function orderStatusHighlighting(order) {
  // Выделение заказов требующих внимания имеют приоритет
  if (order.NeedAttention?.split(',')[0] === 'true') return sass.needAttention
  else if (order.AwaitingDispatch) return sass.awaitingDispatch
  else return ''
}


const OrderHeader = (props) => {
  const { data: order, editState, setEditState, setOIDialog, refetch } = props;


  return (
    <div className={`page-header ${orderStatusHighlighting(order)}`}>
      <Typography sx={{ fontWeight: 600, fontSize: '1rem' }}>
        {order.Entity} __ {order.City}

        {orderStatus(order) ? <span className="preorderTitle">{orderStatus(order)}</span> : null}
      </Typography>

      <Box className={`${sass.orderActionsRow} noprint`}>
        <OrderActions
          order={order}
          editState={editState}
          setEditState={setEditState}
          setOIDialog={setOIDialog}
        />
      </Box>
    </div>


  )
}

export default OrderHeader;