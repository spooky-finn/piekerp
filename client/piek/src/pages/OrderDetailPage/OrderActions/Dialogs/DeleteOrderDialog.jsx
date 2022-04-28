import ConfirmDialog from "../../../../components/muiCustom/mui/ConfirmDialog"

export default function DeleteOrderDialog ({ handler, ...rest }){
    const title = 'Удалить заказ?'
    const body = "Удаление заказа / рекламации необратимо."

    return <ConfirmDialog {...rest} isDangerous title={title} body={body} onCloseComplete={handler} confirmLabel="Удалить"/>
}
