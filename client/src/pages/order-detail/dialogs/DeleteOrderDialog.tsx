import { ReactNode } from 'react'
import ConfirmDialog from '../../../components/ConfirmDialog'

interface IDeleteOrderDialogProps {
  handler: () => void
  children: ReactNode
}

export default function DeleteOrderDialog({ handler, children }: IDeleteOrderDialogProps) {
  const title = 'Удалить заказ?'
  const body = 'Удаление заказа / рекламации необратимо.'

  return (
    <ConfirmDialog
      isDangerous
      title={title}
      body={body}
      confirmButtonHandler={handler}
      confirmButtonLabel="Удалить"
    >
      {children}
    </ConfirmDialog>
  )
}
