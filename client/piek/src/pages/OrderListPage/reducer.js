export const initialState = (store) => ({
    orders: store.cachedOrders || [],
    preOrders: store.cachedPreOrders || [],
    selectedTab : store.selectedTab,

    managerFilter: 0,

    search : {
        // search in adjacent groups as an additional information
        // поиск в смежных разделах для вывода, как справочной информации
        keyword: store.orderListLastSearckKeyword,
        brief: {
            orders : 0,
            preOrders: 0,
            reclamations: 0,
            archived: 0,
        }
    }
})

export function reducer(state, action) {
    switch (action.type) {
        case 'orders':
        case 'preOrders': 
        case 'selectedTab': 
        case 'searchKeyword': 
        case 'searchResult': 
        case 'managerFilter': 
            return {...state, [action.type]: action.payload };

        case 'resetFilters': 
            return {...state, managerFilter: 0, search: { ...state.search, keyword: '' }}


        case 'search.brief': 
            return {...state, search: {
                ...state.search,
                brief: action.payload
            }}
        case 'search.keyword':
            return {...state, search: {
                ...state.search,
                keyword: action.payload
            }  }


        default: 
            return {...state}
    }
}