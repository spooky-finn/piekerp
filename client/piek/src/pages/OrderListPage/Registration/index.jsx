import Presentation from './Presentation';
import SelectorContainer from './SelectorContainer';
import useApplyFilters from '../hooks/useApplyFilters';

import useOrderListPageStore from '../hooks/useOrderListPageStore';

const Registration = ({ data }) => {

    const store = useOrderListPageStore()

    const orders = useApplyFilters({
        orders: data?.ordersRegistration, options: {
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
export default Registration