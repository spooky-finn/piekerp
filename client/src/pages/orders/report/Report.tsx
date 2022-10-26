/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { useMemo } from 'react'
import ManagerFilter from 'src/components/ManagerFilter'
import OrdersNavigationBar from 'src/components/OrdersNavigationBar'
import SearchInputWithFilters from 'src/components/SearchInputWithFilters'
import TableName from 'src/components/TableName'
import PaperL1 from 'src/components/wrappers/PaperL1'
import { useOrderListPageStore } from 'src/hooks'
import { RuMonths } from 'src/lib/constants'
import { formatOnlyDate, getPreviousMonth } from 'src/utils/Date'
import { columnsList, Table } from '../table'
import useReport from './useReport'

export default function Report() {
  const { data } = useReport()
  const store = useOrderListPageStore()

  const columns = useMemo(() => {
    const a = [...columnsList]
    a[3] = {
      Header: 'Факт отгрузка',
      accessor: order => formatOnlyDate(order.ActualShippingDate)
    }
    return a
  }, [])

  if (data.loading) return null

  return (
    <>
      <OrdersNavigationBar />

      <SearchInputWithFilters value={store.searchTerm} onChange={store.searchInputHandler}>
        <ManagerFilter value={store.managerId} onChange={store.managerFilterHandler} />
      </SearchInputWithFilters>

      <PaperL1>
        <TableName name="Отгрузка в этом месяце" />
        {Array.isArray(data.ordersCurrentMonth) && (
          <Table columns={columns} data={data.ordersCurrentMonth} showUnpaid />
        )}

        <div
          css={css`
            margin-top: 30px;
          `}
        >
          <TableName name={`Отгрузка за ${RuMonths[getPreviousMonth()]}`} />
          {Array.isArray(data.ordersAccountingMonth) && (
            <Table columns={columns} data={data.ordersAccountingMonth} showUnpaid />
          )}
        </div>
      </PaperL1>
    </>
  )
}
