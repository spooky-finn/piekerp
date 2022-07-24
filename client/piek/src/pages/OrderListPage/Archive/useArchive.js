import { useQuery } from '@apollo/client'
import useApplyFilters from '../hooks/useApplyFilters'
import { GET_ARCHIVED_SEARCH_ORDERS } from './query'
import useOrderListPageStore from '../hooks/useOrderListPageStore';


export default function useArchive() {
    const store = useOrderListPageStore();

    const keyword = () => {
        if (!store.searchTerm)
            return null
        else if (store.searchTerm === '/all')
            return '%%'
        else
            return '%' + store.searchTerm + '%'
    }

    const { data } = useQuery(GET_ARCHIVED_SEARCH_ORDERS, {
        variables: {
            keyword: keyword(),
            OrderStatus: store.orderStatusId
        }
    })

    const orders = useApplyFilters({
        orders: data?.erp_Orders, options: {
            managerId: store.managerId,
        }
    })

    return {
        data: orders
    }
}