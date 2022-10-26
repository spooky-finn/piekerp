import Typography from '@mui/material/Typography'
import moment from 'moment'
import { useMemo } from 'react'
import ManagerFilter from 'src/components/ManagerFilter'
import OrdersNavigationBar from 'src/components/OrdersNavigationBar'
import OrderTypeFilter from 'src/components/OrderTypeFilter'
import SearchInputWithFilters from 'src/components/SearchInputWithFilters'
import TableName from 'src/components/TableName'
import PaperL1 from 'src/components/wrappers/PaperL1'
import useApplyFilters from 'src/hooks/useApplyFilters'
import useOrderListPageStore from 'src/hooks/useOrderListPageStore'
import { useGetOrdersArchivedBySearchKeywordQuery } from 'src/types/graphql-shema'
import { columnsList, Table } from '../table'

export default function Archive() {
  const columns = useMemo(() => {
    const a = [...columnsList]
    a[3] = {
      Header: 'Факт отгрузка',
      accessor: order => (
        <> {order.ActualShippingDate && moment(order.ActualShippingDate).format('DD.MM.YY')}</>
      )
    }
    return a
  }, [])

  const store = useOrderListPageStore()

  const keyword = () => {
    if (!store.searchTerm) return ''
    if (store.searchTerm === '/all') return '%%'
    else return '%' + store.searchTerm + '%'
  }

  const { data } = useGetOrdersArchivedBySearchKeywordQuery({
    variables: {
      keyword: keyword(),
      OrderStatus: store.orderStatusId
      // ManagerID: 0
    }
  })

  const orders = useApplyFilters({
    orders: data?.erp_Orders || [],
    options: {
      managerId: store.managerId,
      orderStatusId: store.orderStatusId
    }
  })

  return (
    <>
      <OrdersNavigationBar />
      <SearchInputWithFilters value={store.searchTerm} onChange={store.searchInputHandler}>
        <ManagerFilter value={store.managerId} onChange={store.managerFilterHandler} />
        <OrderTypeFilter value={store.orderStatusId} onChange={store.orderTypeFilterHandler} />
      </SearchInputWithFilters>

      <PaperL1>
        <TableName name="Результат поиска по архиву" />
        {orders && <Table columns={columns} data={orders} showUnpaid />}
        {!orders.length && <Typography m={2}>(ノ#-_-)ノ ничего не найдено</Typography>}
      </PaperL1>
    </>
  )
}
