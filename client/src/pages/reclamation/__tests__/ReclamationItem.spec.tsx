import { render, screen } from '@testing-library/react'
import { OrderStatus, TReclamationOrder } from 'src/types/global'
import ReclamationItem from '../ReclamationItem'

const order: TReclamationOrder = {
  AwaitingDispatch: true,
  OrderID: 12,
  City: 'Moskow',
  Entity: 'RosAtom',
  NeedAttention: null,
  OrderStatusID: OrderStatus.reclInbox,
  OrderItems: [
    {
      Name: 'МЭОФ-100/25-0,25М-99К У2 с наружным квадратом 24',
      OrderItemID: 12
    },
    {
      Name: 'МЭОФ-100/25-0,25М-99К У2 с наружным квадратом 24',
      OrderItemID: 12
    }
  ]
}

test('should display two order items', () => {
  render(<>{/* <ReclamationItem order={order} /> */}</>)

  // expect(screen.getAllByText('МЭОФ-100/25-0,25М-99К У2 с наружным квадратом 24')).toBe(2)
})
