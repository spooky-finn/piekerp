import { Heading, SearchInput, minorScale } from 'evergreen-ui';


const BaseHeader = (props) => {

    return(
           <div className="base-container page-header">
                    <span>{props.pageParams.icon}</span>
                    <Heading>{props.pageParams.title}</Heading>
                    <div className="search-box"><SearchInput height={minorScale(10)} className="search-input" /></div>
            </div>
    )
}

export default BaseHeader