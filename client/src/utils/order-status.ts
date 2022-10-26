import { OrderStatus, TOrder } from 'src/types/global'

export function orderStatus(order: TOrder) {
  // add a note to the title if this is a pre-order
  if (order.OrderStatusID === OrderStatus.ordRegistration) return ' Предзаказ'
  if (order.OrderStatusID === OrderStatus.ordArchived) return ' В архиве'
  if (
    [
      OrderStatus.reclInbox,
      OrderStatus.reclDecision,
      OrderStatus.reclProduction,
      OrderStatus.reclArchived
    ].includes(order.OrderStatusID)
  )
    return ' Рекламация'
}

export function orderStatusHighlighting(order: TOrder) {
  // Выделение заказов требующих внимания имеют приоритет
  if (order.NeedAttention?.split(',')[0] === 'true') return 'needAttention'
  else if (order.AwaitingDispatch) return 'awaitingDispatch'
  else return ''
}
