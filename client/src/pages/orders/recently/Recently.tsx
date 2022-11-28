import { useMemo } from 'react'
import OrdersNavigationBar from 'src/components/OrdersNavigationBar'

import TableName from 'src/components/TableName'
import PaperL1 from 'src/components/wrappers/PaperL1'
import { columnsList, Table } from '../table'

import moment from 'moment'
import { OrderStatus } from 'src/types/global'
import { useGetOrdersByStatusQuery } from 'src/types/graphql-shema'
import { formatOnlyDate } from 'src/utils/date'

export default function Recently() {
  const { data } = useGetOrdersByStatusQuery({
    variables: { orderStatus: OrderStatus.ordProduction },
    fetchPolicy: 'cache-and-network'
  })

  const ordersByToday =
    data?.erp_Orders.filter(
      each => formatOnlyDate(each.AcceptanceDate) === formatOnlyDate(moment().toISOString())
    ) || []

  const ordersByYesterday =
    data?.erp_Orders.filter(
      each =>
        formatOnlyDate(each.AcceptanceDate) ===
        formatOnlyDate(moment().subtract(1, 'day').toISOString())
    ) || []

  const columns = useMemo(() => columnsList, [])

  return (
    <>
      <OrdersNavigationBar />
      <PaperL1>
        <TableName name="Сегодня" />
        <Table columns={columns} data={ordersByToday} />

        <TableName name="Вчера" />
        <Table columns={columns} data={ordersByYesterday} />
      </PaperL1>
    </>
  )
}
