import { Link } from 'react-router-dom'
import  moment  from 'moment';
import sass from '../main.module.sass'

const setPaidPercent = (total, paid) => {
    if (!total || !paid) return ''
    return ' - ' + ((paid/total) * 100).toFixed(0) + '%'
}

export const columnsList = [
    {
      Header: '',
      id: 'index',
      accessor: (_row: any, counter) => counter +1
    },
    {
      Header: 'Наим.',
      id: "orderItems",
      accessor: data => {
        if (data.OrderItems.length == 0) return <Link to={`/orders/${data.OrderID}`}><div>пустота...</div></Link>

        else return (<Link to={`/orders/${data.OrderID}`}>
        {data.OrderItems.map(item => (
          <div key={item.OrderItemID} >
            <span>{item.Name}</span>
          </div>
        ))}
        </Link>)
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
      <> { moment(order.ShippingDate).format('DD.MM.YY') } </>
    },
    {
      Header: 'Счет- оплата',
      accessor: data => data.InvoiceNumber + setPaidPercent(data.TotalAmount, data.PaidAmount),
    },
    {
      Header: 'Компания',
      accessor: 'Entity',
    },
    {
      Header: 'Гор.',
      accessor: 'City',
    },
    {
      Header: 'Мдж.',
      accessor: data => <> {data.User?.FirstName[0] || ''} </>
    },
  ]


