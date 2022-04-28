import ConfirmDialog from "../../../../components/muiCustom/mui/ConfirmDialog"



//  return <ConfirmDialog {...rest} isDangerous title={title} body={body} onCloseComplete={handler} confirmLabel="Удалить"/>


export default function TransferOrderDialog({ handler, ...rest }) {
  const title = 'Перенести в архив?'
  const body = "Заказ удалится из очередности, но его в любое время можно будет найти в архиве по номеру счета, юрлицу, маркировке привода."

  return <ConfirmDialog {...rest} title={title} body={body} onCloseComplete={handler} confirmLabel="Перенести"/>
}