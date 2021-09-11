export const initialState = (selectedTab, cachedOrders, cachedPreOrders) => ({
    orders: cachedOrders || [],
    preOrders: cachedPreOrders || [],
    selectedTab : selectedTab,

    searchKeyword: '',
    managerFilter: 0,
})

export function reducer(state, action) {
    switch (action.type) {
        case 'orders':
        case 'preOrders': 
        case 'selectedTab': 
        case 'searchKeyword': 
        case 'managerFilter': 
            return {...state, [action.type]: action.payload };

        case 'resetFilters': 
            return {...state, searchKeyword: '', managerFilter: 0}
    }
}