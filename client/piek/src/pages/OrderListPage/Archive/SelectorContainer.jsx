import ManagerFilter from '../../../components/ManagerFilter';
import OrderTypeFilter from '../../../components/OrderTypeFilter';
import useOrderListPageStore from '../hooks/useOrderListPageStore';
import SearchInputWithFilters from '../../../components/SearchInputWithFilters';

export default function SelectorContainer({ data }) {

    const store = useOrderListPageStore();

    function orderTypeFilterHandler(e) {
        store.setOrderStatusId(e.target.value)
    }

    function managerFilterHandler(e) {
        store.setManagerID(e.target.value)
    }

    function searchInputHandler(e) {
        store.setSearchTerm(e.target.value.trim())
    }

    return (
        <SearchInputWithFilters value={store.searchTerm} onChange={searchInputHandler} >

            <ManagerFilter value={store.managerId} onChange={managerFilterHandler} managers={data.managers} />
            <OrderTypeFilter value={store.orderStatusId} onChange={orderTypeFilterHandler} />

        </SearchInputWithFilters>
    )
}