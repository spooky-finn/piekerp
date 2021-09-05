export const initialState = (selectedTab) => ({
    orders: [],
    preOrders: [],
    selectedTab : selectedTab,
    searchKeyword: '',
    managerFilter: 0,
    filtredOrders: [],
})

export function reducer(state, action) {
    switch (action.type) {
        case 'orders':
        case 'preOrders': 
        case 'selectedTab': 
        case 'searchKeyword': 
        case 'managerFilter': 
        case 'filtredOrders':
            return {...state, [action.type]: action.payload };

    }
}