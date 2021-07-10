import { Heading, SearchInput, minorScale } from 'evergreen-ui';
import {UilPrint, UilPlus, UilBell} from '@iconscout/react-unicons';


const BaseHeader = (props) => {

    return(
        <>
           <div className="base-container page-header">
                    <span>{props.pageParams.icon}</span>
                    <Heading>{props.pageParams.title}</Heading>
                    <div className="search-box"><SearchInput height={minorScale(10)} className="search-input" /></div>
            </div>

            
            <div className="action-block">
                    <div data-for='global' data-tip="Распечатать" className="action-icon"><UilPrint/></div>
                    <div data-for='global' data-tip="Добавить" className="action-icon"><UilPlus/></div>
                    <div data-for='global' data-tip="Уведомления" className="action-icon"><UilBell/></div>
            </div>
            </>
    )
}

export default BaseHeader