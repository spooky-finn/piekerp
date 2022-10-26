import Typography from '@mui/material/Typography'
import { useMemo } from 'react'
import ManagerFilter from 'src/components/ManagerFilter'
import OrdersNavigationBar from 'src/components/OrdersNavigationBar'
import SearchInputWithFilters from 'src/components/SearchInputWithFilters'
import PaperL1 from 'src/components/wrappers/PaperL1'
import useApplyFilters from 'src/hooks/useApplyFilters'
import useOrderListPageStore from 'src/hooks/useOrderListPageStore'
import { useGetOrdersByStatusQuery } from 'src/types/graphql-shema'
import { columnsList, Table } from '../table'

export default function Production() {
  const store = useOrderListPageStore()

  const { data } = useGetOrdersByStatusQuery({
    variables: {
      orderStatus: 2
    },
    fetchPolicy: 'cache-and-network',
    pollInterval: 50000
  })

  const columns = useMemo(() => columnsList, [])

  const orders = useApplyFilters({
    orders: data?.erp_Orders || [],
    options: {
      managerId: store.managerId,
      searchKeyword: store.searchTerm
    }
  })

  return (
    <>
      <OrdersNavigationBar />

      <SearchInputWithFilters value={store.searchTerm} onChange={store.searchInputHandler}>
        <ManagerFilter value={store.managerId} onChange={store.managerFilterHandler} />
      </SearchInputWithFilters>

      {orders && (
        <PaperL1>
          <Table columns={columns} data={orders} />
          {!orders.length && <Typography m={2}>(ノ#-_-)ノ ничего не найдено</Typography>}
        </PaperL1>
      )}
    </>
  )
}
