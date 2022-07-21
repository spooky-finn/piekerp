import orderKeywordComparator from "../../../utils/orderKeywordComparator";

export default function useApplyFilters({ orders, options: {
    managerId,
    searchKeyword,
    orderStatusId,
} }) {

    const handlers = {
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
            const isSuit = orderKeywordComparator(searchKeyword, order.InvoiceNumber, order.Entity)
            return isSuit
        }
    }

    const handleOrders = (orderList) => {
        return orderList?.filter(order => Object.values(handlers).every(handle => handle(order)));

    };


    return handleOrders(orders)
}