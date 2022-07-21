import { useMemo } from 'react';
import { columnsList } from '../UniversalTable/columnList'
import Table from "../UniversalTable/TableMarkup";
import moment from 'moment'
import PaperL1 from '../../../components/wrappers/PaperL1';
import TableName from '../../../components/TableName';


export default function Presentation({ data }) {

    const columns = useMemo(
        () => {
            const a = [...columnsList]
            a[3] = {
                Header: 'Факт отгрузка',
                accessor: order =>
                    <> {order.ActualShippingDate && moment(order.ActualShippingDate).format('DD.MM.YY')}
                    </>
            }
            return a
        }, []
    )

    return (
        <>
            <PaperL1>
                <TableName name='Результат поиска по архиву' />
                {Array.isArray(data) && <Table columns={columns} data={data} showUnpaid />}
                {/* <Typography color='textPrimary' m={2} variant="subtitle2">(ノ#-_-)ノ ничего не найдено</Typography> */}
            </PaperL1>
        </>
    )
}