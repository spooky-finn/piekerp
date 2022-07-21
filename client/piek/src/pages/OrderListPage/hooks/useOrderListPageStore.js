import create from 'zustand'
import OS from '../../../lib/constants/OrderStatus';

const useOrderListPageStore = create((set) => ({
    managerId: 0,
    orderStatusId: OS.ordArchived,
    searchTerm: '',
    homePageTab: 1,

    setManagerID: (v) => set({ managerId: v }),
    setOrderStatusId: (v) => set({ orderStatusId: v }),
    setSearchTerm: (v) => set({ searchTerm: v }),
    setHomePageTab: (v) => set({ homePageTab: v })

    // resetAll: () => set(state, )
}))

export default useOrderListPageStore;