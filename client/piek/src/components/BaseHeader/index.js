import { Heading } from 'evergreen-ui';


const BaseHeader = (props) => {

    return(
           <div className="base-container page-header">
                    <span>{props.pageParams.icon}</span>
                    <Heading>{props.pageParams.title}</Heading>                    
                    {props.children}
            </div>
    )
}

export default BaseHeader