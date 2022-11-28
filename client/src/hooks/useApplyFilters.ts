import { OrderStatus, TOrderColumnData } from 'src/types/global'
import keywordComparator from '../utils/comparators'

interface UseApplyFiltersProps {
  orders: TOrderColumnData[]
  options: Options
}

type Options = {
  managerId?: any
  searchKeyword?: any
  orderStatusId?: OrderStatus
}

type FilterHandler = {
  [key: string]: (order: TOrderColumnData) => boolean
}

export function useApplyFilters({ orders, options }: UseApplyFiltersProps) {
  const { managerId, searchKeyword, orderStatusId } = options

  const handlers: FilterHandler = {
    byStatus: order => {
      if (!orderStatusId) return true

      const isSuit = order.OrderStatusID === orderStatusId
      return isSuit
    },
    byManager: order => {
      if (!managerId) return true

      const isSuit = order.ManagerID === managerId
      return isSuit
    },
    bySearch: order => {
      if (!searchKeyword) return true

      const isSuit = keywordComparator(
        searchKeyword,
        order.InvoiceNumber?.toString() ?? '',
        order.Entity ?? ''
      )
      return isSuit
    }
  }

  const handleOrders = (orders: TOrderColumnData[]) => {
    return orders?.filter(order => Object.values(handlers).every(handle => handle(order)))
  }

  return handleOrders(orders)
}
