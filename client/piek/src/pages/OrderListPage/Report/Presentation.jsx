/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { useMemo } from 'react';
import TableName from '../../../components/TableName';
import { columnsList } from '../UniversalTable/columnList'
import Table from "../UniversalTable/TableMarkup";
import PaperL1 from '../../../components/wrappers/PaperL1';

import RuMonths from '../../../lib/constants/RuMonths'
import { formatDate, getPreviousMonth } from '../../../utils/date_helper';

export default function Presentation({
    data: {
        loading,
        ordersCurrentMonth,
        ordersAccountingMonth,
    }
}) {

    const columns = useMemo(
        () => {
            const a = [...columnsList]
            a[3] = {
                Header: 'Факт отгрузка',
                accessor: order => formatDate(order.ActualShippingDate)
            }
            return a
        }, []
    )

    if (loading) return null;

    return (
        <PaperL1>
            <TableName name='Отгрузка в этом месеце' />
            {Array.isArray(ordersCurrentMonth) && <Table columns={columns} data={ordersCurrentMonth} showUnpaid />}

            <div css={css`
                margin-top: 30px;
            `}>
                <TableName name={`Отгрузка за ${RuMonths[getPreviousMonth()]}`} />
                {Array.isArray(ordersAccountingMonth) && <Table columns={columns} data={ordersAccountingMonth} showUnpaid />}
            </div>
        </PaperL1>
    )
}