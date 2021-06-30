// import { observer } from 'mobx-react-lite';
import React, { useState, useContext } from 'react';

import { Context } from '../../index';

import { Pane } from 'evergreen-ui';
import './Sidebar.sass';
import '../../theme.css';

import * as Unicons from '@iconscout/react-unicons';

const Sidebar = () => {
    const {store} = useContext(Context);

    return(
        <>
        <Pane className='Sidebar'>
            <div className="action-icon"> <Unicons.UilSortAmountDown/></div>
            <div className="action-icon"> <Unicons.UilEnvelopeInfo/></div>
            <div className="action-icon"> <Unicons.UilWrench/></div>

            
            <div className="action-icon"> <Unicons.UilUserCircle/></div>
            <div className="action-icon" onClick={() => store.logout()}><Unicons.UilSignInAlt/></div>
        </Pane>
        </>
    );
}

export default Sidebar;