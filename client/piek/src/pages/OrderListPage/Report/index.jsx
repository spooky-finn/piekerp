import SelectorContainer from './SelectorContainer';
import Presentation from './Presentation';
import useReport from './useReport';

const Report = ({ data: parentData }) => {
    const { data } = useReport()

    return (
        <>
            <SelectorContainer data={parentData} />
            <Presentation data={data} />
        </>
    )
}
export default Report