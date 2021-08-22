import moment from 'moment' 
import setPaidPercent from '../PriorityLayout/tableLogic'


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
                if (order.CreatingDate.split('T')[0] === day.date){
                    day.objs.push(order);
                    isAdded = true;
                } else if(day.name === '' && !isAdded) day.objs.push(order)
            })}
    }
    
    return days;
};
