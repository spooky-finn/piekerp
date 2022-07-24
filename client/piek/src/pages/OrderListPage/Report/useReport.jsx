import { useQuery } from "@apollo/client"
import { GET_ORDERS_BY_INTERVAL } from "./query"
import moment from "moment";
import useApplyFilters from "../hooks/useApplyFilters";
import useOrderListPageStore from "../hooks/useOrderListPageStore";

export default function useReport() {
    const store = useOrderListPageStore();

    const startOfMonth = moment().startOf('month').format('YYYY-MM-DD HH:mm');
    const endOfMonth = moment().endOf('month').format('YYYY-MM-DD HH:mm');

    const prevStartOfMonth = moment().subtract(1, 'months').startOf('month').format('YYYY-MM-DD HH:mm');
    const prevEndOfMonth = moment().subtract(1, 'months').endOf('month').format('YYYY-MM-DD HH:mm');

    const { data: ordersCurrentMounth } = useQuery(GET_ORDERS_BY_INTERVAL, {
        variables: {
            _gte: startOfMonth,
            _lte: endOfMonth,
        }
    })

    const { data: ordersAccountingMonth } = useQuery(GET_ORDERS_BY_INTERVAL, {
        variables: {
            _gte: prevStartOfMonth,
            _lte: prevEndOfMonth,
        }
    })


    const ordersCurrentMonthFiltered = useApplyFilters({
        orders: ordersCurrentMounth?.erp_Orders, options: {
            managerId: store.managerId,
            searchKeyword: store.searchTerm
        }
    })

    const ordersAccountingMonthFiltered = useApplyFilters({
        orders: ordersAccountingMonth?.erp_Orders, options: {
            managerId: store.managerId,
            searchKeyword: store.searchTerm
        }
    })

    return {
        data: {
            loading: !Boolean(ordersAccountingMonthFiltered && ordersCurrentMonthFiltered),
            ordersCurrentMonth: ordersCurrentMonthFiltered,
            ordersAccountingMonth: ordersAccountingMonthFiltered
        }
    }
}