import Presentation from './Presentation';
import useRecently from './useRecently';

const Recently = ({ state, dispatch, data: parentData }) => {
    const { data } = useRecently(parentData)

    return (
        <Presentation data={data} />
    )
}
export default Recently