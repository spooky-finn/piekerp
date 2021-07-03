import { PropertiesIcon } from "evergreen-ui"
import PriorityLayout from "../PriorityLayout/PriorityLayout"

const BaseLayout = (props) => {


    return(
        <>
        <PriorityLayout/>
        {props.children}
        </>
    )
}

export default BaseLayout