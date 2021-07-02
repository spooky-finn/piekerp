
// import { observer } from 'mobx-react-lite';
import React, { useState, useContext } from 'react';
import { Context } from '../../index';

import { Pane, Heading, SearchInput, minorScale } from 'evergreen-ui';
import './PriorityLayout.sass';

import * as Unicons from '@iconscout/react-unicons';

const PriorityLayout = (props) => {
    const {store} = useContext(Context);

    const data = [
        {
          "Entity": "БКЗ",
          "InvoiceNumber": 210,
          "OrderItems": [
            {
              "Quantity": 11,
              "OrderItemID": 1,
              "Name": "МЭОФ-400/63-0,25У-БКП380-ПСТ4 У2 F10 IP67",
              "OrderID": 1
            },
            {
              "Quantity": 7,
              "OrderItemID": 2,
              "Name": "МЭОФ-16/30-0,25М-98 У2 F05 кв.9П",
              "OrderID": 1
            }
          ],
          "City": "Чебоксары",
          "ShippingDate": "2021-06-30"
        },
        {
          "Entity": "Арматек",
          "InvoiceNumber": 220,
          "OrderItems": [
            {
              "Quantity": 3,
              "OrderItemID": 4,
              "Name": "АШК-3-380-БУШ-БСПО-СВ-ПВТ4 У1",
              "OrderID": 2
            }
          ],
          "City": "Москва",
          "ShippingDate": "2021-05-30",
        }
      ];


    const orders = data.map((el) =>
        <tr>
            <td>{el.OrderItems.map((item) => 
                <div>{item.Name}</div>
            )}</td>
            <td>{el.OrderItems.map((item) => 
                <div>{item.Quantity}</div>
            )}</td>
             <td>{el.ShippingDate}</td>
            <td>{el.City}</td>
            <td>{el.InvoiceNumber}</td>
            <td>{el.Entity}</td>
        </tr>
    );

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
           


            <table className="priority-table">
            {orders}
            </table>







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