/* eslint-disable react-hooks/exhaustive-deps */
import {
  Box,
  Button,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  TextField
} from '@mui/material'
import { useEffect, useState } from 'react'
import { useOrderDetailStore } from 'src/hooks/useOrderDetailStore'
import { TOrderItem } from 'src/types/global'
import { useInsertOrderItemMutation, useUpdateOrderItemByPkMutation } from 'src/types/graphql-shema'

export interface IDialogEditOrderItemProps {
  refetch: () => void
}

export default function DialogAddEditOrderItem({ refetch }: IDialogEditOrderItemProps) {
  const {
    orderId,
    addOrderItemDialog: isOpen,
    setAddOrderItemDialog,
    editedOrderItem
  } = useOrderDetailStore()

  const defaultState: Partial<TOrderItem> = {}

  const [state, setState] = useState<Partial<TOrderItem>>(editedOrderItem || defaultState)

  useEffect(() => {
    setState(editedOrderItem || defaultState)
  }, [editedOrderItem])

  const [updateMutation] = useUpdateOrderItemByPkMutation()
  const [insertMutation] = useInsertOrderItemMutation()

  const handleClose = () => setAddOrderItemDialog(false)

  const handleUpdate = (): void => {
    handleClose()
    if (!state.Quantity || !state.Name || !state.OrderItemID) return

    updateMutation({
      variables: {
        id: state.OrderItemID,
        Name: state.Name,
        Quantity: state.Quantity,
        FullName: state.FullName ?? ''
      },
      onCompleted() {
        setState(defaultState)
        refetch()
      }
    })
  }

  const handlerInsert = (): void => {
    handleClose()
    if (!orderId) throw Error('orderId is null')
    if (!state.Quantity || !state.Name) throw Error()

    insertMutation({
      variables: {
        orderID: orderId,
        name: state.Name,
        quantity: state.Quantity,
        fullName: state.FullName ?? ''
      },
      onCompleted() {
        setState(defaultState)
        refetch()
      }
    })
  }

  const handleInputChange: React.ChangeEventHandler<HTMLInputElement> = e => {
    setState({
      ...state,
      [e.target.name]: e.target.value
    })
  }

  const disableSaveButton = !Boolean(state.Name && state.Quantity)
  return (
    <div>
      <Dialog fullWidth={true} open={isOpen} onClose={handleClose}>
        <DialogTitle>{editedOrderItem ? 'Изменить' : 'Добавить'} позицию</DialogTitle>
        <DialogContent>
          <Box display="flex" flexDirection="column">
            <TextField
              label="Наименование"
              value={state.Name}
              variant="filled"
              sx={{ mb: '8px' }}
              name="Name"
              onChange={handleInputChange}
            />
            <TextField
              label="Полное наименование"
              multiline
              variant="filled"
              sx={{ mb: '8px' }}
              value={state.FullName}
              name="FullName"
              onChange={handleInputChange}
            />
            <TextField
              label="Кол-во"
              type="number"
              variant="filled"
              name="Quantity"
              sx={{ mb: '8px' }}
              value={state.Quantity}
              onChange={handleInputChange}
            />
          </Box>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleClose}>Отмена</Button>

          {!state.OrderItemID ? (
            <Button variant="contained" onClick={handlerInsert} disabled={disableSaveButton}>
              Добавить
            </Button>
          ) : (
            <Button variant="contained" onClick={handleUpdate} disabled={disableSaveButton}>
              Изменить
            </Button>
          )}
        </DialogActions>
      </Dialog>
    </div>
  )
}
