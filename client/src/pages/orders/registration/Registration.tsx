import CreateRecordButton from 'src/components/CreateRecordButton'
import OrdersNavigationBar from 'src/components/OrdersNavigationBar'
import { useGetOrdersByStatusQuery, useInsertOrderMutation } from 'src/types/graphql-shema'
import { useMemo } from 'react'
import PaperL1 from 'src/components/wrappers/PaperL1'
import { columnsList, Table } from '../table'
import { useNavigate } from 'react-router-dom'
import ManagerFilter from 'src/components/ManagerFilter'
import SearchInputWithFilters from 'src/components/SearchInputWithFilters'
import { OrderStatus } from 'src/types/global'
import Typography from '@mui/material/Typography'
import { useApplyFilters, useOrderListPageStore } from 'src/hooks'

export default function Registration() {
  const store = useOrderListPageStore()
  const navigate = useNavigate()

  const [insertOrderMutation] = useInsertOrderMutation({
    variables: {
      orderStatusID: OrderStatus.ordRegistration
    }
  })

  function insertOrderHandler() {
    // throw Error('function unimplemented')
    insertOrderMutation().then(res => {
      // TODO: add check on error responce
      // console.log(' // TODO: add check on error responce', res)
      navigate(`/orders/${res.data?.insert_erp_Orders?.returning[0].OrderID}?edit=true`)
    })
  }

  const { data } = useGetOrdersByStatusQuery({
    variables: {
      orderStatus: 1
    },
    fetchPolicy: 'cache-and-network',
    pollInterval: 50000
  })

  const orders = useApplyFilters({
    orders: data?.erp_Orders || [],
    options: {
      managerId: store.managerId,
      searchKeyword: store.searchTerm
    }
  })

  const columns = useMemo(() => columnsList, [])

  return (
    <>
      <OrdersNavigationBar>
        <CreateRecordButton onClick={insertOrderHandler} />
      </OrdersNavigationBar>

      <SearchInputWithFilters value={store.searchTerm} onChange={store.searchInputHandler}>
        <ManagerFilter value={store.managerId} onChange={store.managerFilterHandler} />
      </SearchInputWithFilters>

      <PaperL1>
        {data?.erp_Orders && <Table columns={columns} data={orders} />}
        {!orders.length && <Typography m={2}>(ノ#-_-)ノ ничего не найдено</Typography>}
      </PaperL1>
    </>
  )
}
