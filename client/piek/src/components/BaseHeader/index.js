import { Heading, SearchInput, minorScale } from 'evergreen-ui';


const BaseHeader = (props) => {

    return(
           <div className="base-container page-header">
                    <span>{props.pageParams.icon}</span>
                    <Heading>{props.pageParams.title}</Heading>
                    <div className="search-box"><SearchInput height={minorScale(10)}  onChange={(e) => props.search(e)} className="search-input" /></div>
                    
                    {props.children}
            </div>
    )
}

export default BaseHeader