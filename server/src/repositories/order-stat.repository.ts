import GraphQLClient from '../lib/graphql-client'
import { gql } from 'graphql-request'

const GET_ALL_ORDERS = gql`
  query {
    erp_Orders(where: { OrderStatusID: { _eq: 3 } }, order_by: { OrderID: desc }) {
      OrderID
      PaidAmount
      TotalAmount
    }
  }
`
const GET_UNPAID_ORDERS = gql`
  query MyQuery($unpaidIDs: [Int!], $OrderStatus: Int!) {
    erp_Orders(where: { OrderStatusID: { _eq: $OrderStatus }, OrderID: { _in: $unpaidIDs } }) {
      OrderID
      Entity
      InvoiceNumber
      City
      OrderStatusID
      ShippingDate
      PaidAmount
      TotalAmount
      AwaitingDispatch
      ActualShippingDate
      CreatingDate
      ManagerID
      OrderItems {
        Quantity
        OrderItemID
        Name
      }
      User {
        FirstName
      }
    }
  }
`

class HasuraOrderService extends GraphQLClient {
  async getUnpaidOrdersIDs() {
    const res = await this._send(GET_ALL_ORDERS)
    const unpaidOrders = res.data.erp_Orders
      .filter(e => e.PaidAmount / e.TotalAmount < 0.999)
      .map(e => e.OrderID)

    return unpaidOrders
  }

  async getUnpaidOrders() {
    const unpaidOrdersIDs = this.getUnpaidOrdersIDs()
    const variables = { unpaidIDs: unpaidOrdersIDs, OrderStatus: 3 }
    const res = await this._send(GET_UNPAID_ORDERS, variables)

    return res.data.erp_Orders
  }
}

export default new HasuraOrderService()
