import { useMemo } from 'react';
import { columnsList } from '../UniversalTable/columnList'
import Table from "../UniversalTable/TableMarkup";
import TableName from '../../../components/TableName';
import PaperL1 from '../../../components/wrappers/PaperL1';

const styles = {
    secondary: {
        color: 'var(--lowContrast)',
        fontSize: '.8rem',
        padding: '0 8px',
        textTransform: 'none'
    },
    table: {
        borderTop: 'var(--border)'
    }
}

export default function Presentation({ data }) {

    const columns = useMemo(
        () => columnsList, []
    )

    return (
        <PaperL1>
            {
                data.map((each, index) => (
                    <div key={index}>
                        <TableName name={each.name} />

                        {Array.isArray(each.objs) ? (<>
                            <Table
                                columns={columns}
                                data={each.objs}
                                style={styles.table} />
                        </>) : null}

                    </div>
                ))
            }
        </PaperL1>

    )
}