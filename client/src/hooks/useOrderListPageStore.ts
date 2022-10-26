import { SelectChangeEvent } from '@mui/material/Select/SelectInput'
import { ChangeEvent } from 'react'
import { OrderStatus } from 'src/types/global'
import create from 'zustand'

interface IOrderListPageStore {
  managerId: number
  orderStatusId: OrderStatus
  searchTerm: string

  orderTypeFilterHandler(e: SelectChangeEvent<any>): void
  searchInputHandler(e: ChangeEvent<HTMLInputElement>): void
  managerFilterHandler(e: SelectChangeEvent<any>): void
}

const useOrderListPageStore = create<IOrderListPageStore>(set => ({
  managerId: 0,
  orderStatusId: OrderStatus.ordArchived,
  searchTerm: '',

  // setManagerID: v => set({ managerId: v }),
  // setOrderStatusId: v => set({ orderStatusId: v }),
  // setSearchTerm: v => set({ searchTerm: v }),
  // setHomePageTab: v => set({ homePageTab: v }),

  orderTypeFilterHandler(e) {
    set({ orderStatusId: e.target.value as unknown as OrderStatus })
  },

  managerFilterHandler(e) {
    set({ managerId: parseInt(e.target.value) })
  },

  searchInputHandler(e) {
    set({ searchTerm: e.target.value })
  }
}))

export default useOrderListPageStore
