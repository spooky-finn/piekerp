
import Presentation from './Presentation';
import SelectorContainer from './SelectorContainer';
import useArchive from './useArchive';


const Archive = ({ data }) => {
    const { data: orders } = useArchive();

    return (
        <>
            <SelectorContainer data={data} />
            <Presentation data={orders} />
        </>
    )
}
export default Archive;