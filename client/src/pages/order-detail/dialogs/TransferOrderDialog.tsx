import { ReactNode } from 'react'
import ConfirmDialog from '../../../components/ConfirmDialog'

interface ITransferOrderDialogProps {
  handler: () => void
  children: ReactNode
}
export default function TransferOrderDialog({ handler, children }: ITransferOrderDialogProps) {
  const title = 'Перенести в архив?'
  const body =
    'Заказ удалится из очередности, но его в любое время можно будет найти в архиве по номеру счета, юрлицу, маркировке привода.'

  return (
    <ConfirmDialog
      title={title}
      body={body}
      confirmButtonHandler={handler}
      confirmButtonLabel="Перенести"
    >
      {children}
    </ConfirmDialog>
  )
}
