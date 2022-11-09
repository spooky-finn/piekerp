import { database } from '../lib/graphql-client'

class OrderStatRepository {
  async getUnpaidOrders(): Promise<number[]> {
    const unpaidOrdersIDs = (await database.AllOrdersPaymentsDataQuery()).erp_Orders
      .filter(e => e.PaidAmount / e.TotalAmount < 0.999)
      .map(e => e.OrderID)

    return unpaidOrdersIDs
  }
}

export default new OrderStatRepository()
