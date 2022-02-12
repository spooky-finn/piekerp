import { gql } from "graphql-tag"

export const GET_ALL_ORDERS_AMOUNT = gql`
query{
  erp_Orders(
    where: {OrderStatusID: {_eq: 3}},
    order_by: {OrderID: desc},
    limit: 1000,
    ){
		OrderID
    PaidAmount
    TotalAmount
  }
}
`
