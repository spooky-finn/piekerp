// import { observer } from 'mobx-react-lite';
import { useContext } from 'react';
import { Context } from '../../index';

import { Pane } from 'evergreen-ui';
import './Sidebar.sass';

import * as Unicons from '@iconscout/react-unicons';


const Sidebar = () => {
    const {store} = useContext(Context);

    const Sidebar = () => (
        <Pane className='Sidebar'>
            <a href='/priority' data-for='global' data-tip="Очередность выполнения" className="action-icon"> <Unicons.UilSortAmountDown/></a>
            <a href='/recently' data-for='global' data-tip="Новые заказы" className="action-icon"> <Unicons.UilEnvelopeInfo/></a>
            <a href='/recently' data-for='global' data-tip="Рекламация" className="action-icon"> <Unicons.UilWrench/></a>
            
            <a href='/recently' data-for='global' data-tip="Аккаунт" className="action-icon"> <Unicons.UilUserCircle/></a>
            <a href='/' data-for='global' data-tip="Выйти" className="action-icon" onClick={() => store.logout()}><Unicons.UilSignInAlt/></a>
        </Pane>
    )

    return(
        <>
            {Sidebar()}
        </>
    );
}

export default Sidebar;