import useApplyFilters from '../hooks/useApplyFilters'
import useOrderListPageStore from '../hooks/useOrderListPageStore'
import Presentation from './Presentation'
import SelectorContainer from './SelectorContainer'


const Production = ({ data }) => {
    const store = useOrderListPageStore()

    const orders = useApplyFilters({
        orders: data?.ordersProduction, options: {
            managerId: store.managerId,
            searchKeyword: store.searchTerm
        }
    })

    return (
        <>
            <SelectorContainer data={data} />
            <Presentation data={orders} />
        </>
    )
}
export default Production