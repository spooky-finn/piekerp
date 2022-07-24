import { useMemo } from 'react';
import PaperL1 from '../../../components/wrappers/PaperL1';
import { columnsList } from '../UniversalTable/columnList'
import Table from "../UniversalTable/TableMarkup";

export default function Presentation({ data }) {

    const columns = useMemo(
        () => columnsList, []
    )

    return (
        <PaperL1>
            {Array.isArray(data) && <Table columns={columns} data={data} />}
        </PaperL1>
    )
}