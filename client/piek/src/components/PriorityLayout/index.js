import {useSubscription} from '@apollo/client';
import { GetOrdersSubscription } from '../../hasura-queries/getOrders';
import { Heading, SearchInput, minorScale } from 'evergreen-ui';
import * as Unicons from '@iconscout/react-unicons';
import './PriorityLayout.sass';
import Sidebar from '../Sidebar/Sidebar';

const PriorityLayout = (props) => {
    const pageName = 'Очередность выполнения';
    const pageIcon = <Unicons.UilSortAmountDown/>;
    const {error, loading, data = []} = useSubscription(GetOrdersSubscription);

    if (data.erp_Orders){  
        data.erp_Orders.sort((a, b) => b.ShippingDate < a.ShippingDate ? 1: -1)
    }
 
    const setPaidPercent = (total, paid) => {
        if (!total || !paid){
            return ' '    
        }
        return ' - ' + ((paid/total) * 100).toFixed(0) + '%'
    }

    return(
            <> 
              <Sidebar/>

            <div className="page-header">
                    <span>{pageIcon}</span>
                    <Heading >{pageName}</Heading>
                    <div className="search-box"><SearchInput height={minorScale(10)} className="search-input" placeholder="  (＃￣0￣) а если найду?" /></div>
                </div>

            
            <div className="action-block">
                    <div data-for='global' data-tip="Распечатать" className="action-icon"><Unicons.UilPrint/></div>
                    <div data-for='global' data-tip="Добавить" className="action-icon"><Unicons.UilPlus/></div>
                    <div data-for='global' data-tip="Уведомления" className="action-icon"><Unicons.UilBell/></div>
            </div>
        


            <table className="priority-table">
                <thead>
                   <tr>
                        <th></th>
                        <th></th>
                        <th>Кол-во</th>
                        <th>Отгрузка</th>
                        <th>Счет-оплата</th>
                        <th>Компания</th>
                        <th>Гор.</th>
                        <th>Пер. платеж</th>
                   </tr>
                </thead>

                <tbody>
            {data.erp_Orders!==undefined
            ? data.erp_Orders.map((el, index) =>
              <tr key={index}>
                  <td>{index+1}</td>

                  <td>{el.OrderItems.map((item) => 
                      <div key={item.OrderItemID}>{item.Name}</div>
                  )}</td>
                  <td>{el.OrderItems.map((item) => 
                      <div key={item.OrderItemID} >{item.Quantity}</div>
                  )}</td>
                  <td>{el.ShippingDate.split("-")[2] }.{el.ShippingDate.split("-")[1]}.{el.ShippingDate.split("-")[0].slice(2)}</td>
                  <td> №   {el.InvoiceNumber}{setPaidPercent(el.TotalAmount, el.PaidAmount)}</td>
                  <td>{el.Entity}</td>
                  <td>{el.City}</td>
                  <td>...</td>
              </tr>)
            : null
            
            }
                </tbody>
            </table>        

        {props.children}
        </>
    )
}
export default PriorityLayout;