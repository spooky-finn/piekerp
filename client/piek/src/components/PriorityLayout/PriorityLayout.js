
// import { observer } from 'mobx-react-lite';
import React, { useState, useContext } from 'react';
import { Context } from '../../index';

import { Pane, Heading, SearchInput, minorScale } from 'evergreen-ui';
import './PriorityLayout.sass';

import * as Unicons from '@iconscout/react-unicons';

const PriorityLayout = (props) => {
    const {store} = useContext(Context);

    return(
        <>
        <Pane className="container">


            <div className="page-header">
                <span > <Unicons.UilSortAmountDown/> </span>
                <Heading > Очередность выполнения</Heading>

                <div className="search-box"><SearchInput height={minorScale(10)} className="search-input" placeholder="  (＃￣0￣) а если найду?" /></div>
            </div>

            <div className="action-block">
                    <div data-for='global' data-tip="Распечатать" className="action-icon"><Unicons.UilPrint/></div>
                    <div data-for='global' data-tip="Добавить" className="action-icon"><Unicons.UilPlus/></div>
                    <div data-for='global' data-tip="Уведомления" className="action-icon"><Unicons.UilBell/></div>
            </div>
           
            <h1>{store.isAuth ? `Пользователь авторизован ${store.user.Email}` : 'Авторизуйтесь'}</h1>


            <div>
                <p>Вопрос токенов</p>
            </div>

        </Pane>
        

        {props.children}
        </>
    )
}

export default PriorityLayout;