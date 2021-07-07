import { useContext } from 'react';
import { Context } from '../..';

import { Heading, SearchInput, minorScale } from 'evergreen-ui';
import * as Unicons from '@iconscout/react-unicons';

const BaseHeader = () => {
    const {store} = useContext(Context);

    return(
        <>
           <div className="base-container page-header">
                    <span>{store.params.pageTitle.icon }</span>
                    <Heading>{store.params.pageTitle.title }</Heading>
                    <div className="search-box"><SearchInput height={minorScale(10)} className="search-input" placeholder="  (＃￣0￣) а если найду?" /></div>
                </div>

            
            <div className="action-block">
                    <div data-for='global' data-tip="Распечатать" className="action-icon"><Unicons.UilPrint/></div>
                    <div data-for='global' data-tip="Добавить" className="action-icon"><Unicons.UilPlus/></div>
                    <div data-for='global' data-tip="Уведомления" className="action-icon"><Unicons.UilBell/></div>
            </div>
            </>
    )
}

export default BaseHeader;