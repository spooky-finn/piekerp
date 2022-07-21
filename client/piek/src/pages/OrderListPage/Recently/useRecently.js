import moment from 'moment'

export const spread = (orders) => {
    if (!orders) return []

    let days = [{
        'name': 'Сегодня',
        'date': moment().subtract(0, "day").format("YYYY-MM-DD"),
        'objs': []
    },
    {
        'name': 'Вчера',
        'date': moment().subtract(1, "day").format("YYYY-MM-DD"),
        'objs': []
    }
    ]

    for (const order of orders) {

        const dateCreation = order.AcceptanceDate?.split('T')[0]

        if (dateCreation === days[0].date) days[0].objs.push(order);
        else if (dateCreation === days[1].date) days[1].objs.push(order);
    }

    return days;
};



export default function useRecently(data) {

    const dividedOrders = spread(data.ordersProduction).sort(function (a, b) {
        return new Date(b.AcceptanceDate) - new Date(a.AcceptanceDate);
    });


    return { data: dividedOrders }
}