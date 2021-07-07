import { useState } from 'react';
import {useSubscription} from '@apollo/client';
import { GetOrdersSubscription } from '../../hasura-queries/getOrders';
import { Pane, Heading, SearchInput, minorScale, Spinner } from 'evergreen-ui';
import * as Unicons from '@iconscout/react-unicons';
import moment from 'moment';
import './index.sass'

const RecentlyLayout = (props) => {

    const [index, setIndex] = useState(1);
    var counter = 0
    const {error, loading, data = []} = useSubscription(GetOrdersSubscription);

    if (!data.erp_Orders){
        return <Pane display="flex" alignItems="center" justifyContent="center" height='75vh'><Spinner /></Pane>
    }
    if (data.erp_Orders){  
        data.erp_Orders.sort((a, b) => b.ShippingDate < a.ShippingDate ? 1: -1);    
    }

    const groupOrders = (data) => {
            let days = [{
                'name': 'Сегодня',
                'date': moment().subtract(0, "day").format("YYYY-MM-DD"),
                'objs': []}, 
                { 'name': 'Вчера',
                'date': moment().subtract(1, "day").format("YYYY-MM-DD"),
                'objs': []}, 
                { 'name': '',
                'objs': [] },
                ]
                
            if (data.erp_Orders){
                
                for (const order of data.erp_Orders){
                    let isAdded = false;

                    days.forEach( (day) => {
                        if (order.ShippingDate === day.date){
                            day.objs.push(order);
                            isAdded = true;
                        } else if(day.name === '' && !isAdded) day.objs.push(order)
                    })}
            }
            
        return days;
    }


    const setPaidPercent = (total, paid) => {
        if (!total || !paid){
            return ' '    
        }
        return ' - ' + ((paid/total) * 100).toFixed(0) + '%'
    }


    const renderTable = (nameOfGroup) => {
        for (let day of groupOrders(data)){
            if (day['name'] === nameOfGroup){
                
                return (
                    <>
                    { day.objs== '' ? (null) : 
                        <>
                        <Heading className='group-heading'>{day['name']}</Heading>
                        <table className="priority-table">
                            <tbody>

                            { day.objs.map( (el) => {
                                    counter++;
                                        return (
                                            <tr key={counter}>
                                                <td>{counter}</td>

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
                                                <td>{el.ShippingDate}</td>

                                                
                                            </tr>
                                            )
                                        })
                                }

                            </tbody>
                        </table> 
                        </>
                    }
                    </>
                )
            } 
        }
    }


    return(
        <>
        {renderTable('Сегодня')}
        {renderTable('Вчера')}
        {renderTable('')}

        {props.children}
        </>
    );
}


export default RecentlyLayout