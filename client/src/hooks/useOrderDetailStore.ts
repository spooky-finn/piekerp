import { TOrderItem } from 'src/types/global'
import create from 'zustand'

interface IOrderDetailState {
  editMode: boolean
  addOrderItemDialog: boolean

  editedOrderItem: TOrderItem | null
  orderId: number | null
  initialize(orderId: number, editMode: boolean): void
  setAddOrderItemDialog(value: boolean): void
  setEditMode(mode: boolean): void
  setEditedOrderItem(value: TOrderItem | null): void
}

export const useOrderDetailStore = create<IOrderDetailState>(set => ({
  // initial state
  orderId: null,
  editMode: false,
  addOrderItemDialog: false,
  editedOrderItem: null,
  // methods for manipulating state
  initialize(orderId: number, editMode: boolean) {
    set(() => ({
      orderId,
      editMode,
      addOrderItemDialog: false
    }))
  },
  setEditedOrderItem(value: TOrderItem | null) {
    set(() => ({
      editedOrderItem: value,
      addOrderItemDialog: true
    }))
  },
  setAddOrderItemDialog(value) {
    set(() => ({
      addOrderItemDialog: value
    }))
  },
  setEditMode(mode: boolean) {
    set(state => ({
      editMode: mode
    }))
  }
}))
