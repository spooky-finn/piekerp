import { Link } from 'react-router-dom'
import  moment  from 'moment';
import sass from '../main.module.sass'

const setPaidPercent = (total, paid) => {
    if (!total || !paid) return ' - 0%'
    return ' - ' + ((paid/total) * 100).toFixed(0) + '%'
}

export const columnsList = [
    {
      Header: '',
      id: 'index',
      accessor: (_row, counter) => counter +1
    },
    {
      Header: 'Наим.',
      id: "orderItems",
      accessor: data => {
        if (data.OrderItems.length === 0) return <Link to={`/orders/${data.OrderID}`}><div>Нет содержимого</div></Link>

        else return (<>
        {data.OrderItems.map(item => (
          <div key={item.OrderItemID} >
            <span>{item.Name}</span>
          </div>
        ))}
        </>)
      }
      
    },
    {
      Header: 'Кол-во',
      accessor: data =>
      data.OrderItems.map(item => (
      <div key={item.OrderItemID} >
        <div>{item.Quantity}</div>
      </div>
      ))
    },
    {
      Header: 'Отгрузка',
      accessor: (order) => 
      <> { order.ShippingDate && moment(order.ShippingDate).format('DD.MM.YY') } </>
    },
    {
      Header: 'Компания / город',
      accessor: data => 
      <div className={sass.customerTableInfo}>
        <div>{data.Entity}</div>
        <div>{data.City}</div>
      </div>
    },
    {
      Header: 'Счет- оплата',
      accessor: data => data.InvoiceNumber + setPaidPercent(data.TotalAmount, data.PaidAmount),
    },
    {
      Header: 'Мдж.',
      accessor: data => <> {data.User?.FirstName[0] || ''} </>
    },
  ]


