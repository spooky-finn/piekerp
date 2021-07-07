import {useSubscription} from '@apollo/client';
import { GetOrdersSubscription } from '../../hasura-queries/getOrders';
import {Pane, Spinner, Heading, SearchInput, minorScale } from 'evergreen-ui';
import * as Unicons from '@iconscout/react-unicons';
import './PriorityLayout.sass';
import moment from 'moment';


const PriorityLayout = (props) => {
   
    const {error, loading, data = []} = useSubscription(GetOrdersSubscription);

    if (!data.erp_Orders){
        return <Pane display="flex" alignItems="center" justifyContent="center" height='75vh'><Spinner /></Pane>
    }

    if (data.erp_Orders){  
        data.erp_Orders.sort((a, b) => b.ShippingDate < a.ShippingDate ? 1: -1);
    }

    const setPaidPercent = (total, paid) => {
        if (!total || !paid){
            return ' '    
        }
        return ' - ' + ((paid/total) * 100).toFixed(0) + '%'
    }


  
    return(
            <> 
             
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