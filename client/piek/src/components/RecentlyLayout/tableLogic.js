import moment from 'moment' 
import { useTable } from 'react-table'
import { useMemo } from 'react'


export const groupOrders = (orders) => {
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
        
    if (orders){
        
        for (const order of orders){
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