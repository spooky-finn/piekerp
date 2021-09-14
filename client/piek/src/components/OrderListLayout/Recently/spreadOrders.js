import moment from 'moment' 

export const spread = (orders) => {
    let days = [{
        'name': 'Сегодня',
        'date': moment().subtract(0, "day").format("YYYY-MM-DD"),
        'objs': []
        }, 
        {
        'name': 'Вчера',
        'date': moment().subtract(1, "day").format("YYYY-MM-DD"),
        'objs': []
        }, 
        {
        'name': '',
        'objs': [] 
        },
        ]
        
    for(const order of orders){

        const dateCreation = order.AcceptanceDate?.split('T')[0]

        if (dateCreation == days[0].date) days[0].objs.push(order);
        else if (dateCreation == days[1].date) days[1].objs.push(order);
        else days[2].objs.push(order);    
    }

    return days;
};
