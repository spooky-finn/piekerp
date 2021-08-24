
import { useTable } from 'react-table'
import { Link } from 'react-router-dom'
import  moment  from 'moment';


export const setPaidPercent = (total, paid) => {
    if (!total || !paid){
        return ' '    
    }
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
        if (data.OrderItems.length == 0) return <Link to={`/order/${data.OrderID}`}><div>пустота...</div></Link>

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
      accessor: data => 
      '№ ' + data.InvoiceNumber + setPaidPercent(data.TotalAmount, data.PaidAmount),
    },
    {
      Header: 'Компания',
      accessor: 'Entity',
    },
    {
      Header: 'Гор.',
      accessor: 'City',
    },
    // {
    //   Header: 'Перв. платеж',
    //   accessor: 'ShippingDate',
    // },
  ]

export default function Table({columns, data, id, heading}){
    const {
        getTableProps,
        getTableBodyProps,
        headerGroups,
        rows,
        prepareRow,
      } = useTable({
        columns,
        data,
      })


    if (data.length == 0) return null;

   return (
     <>
    <table id={id} className="priorityTable" {...getTableProps()}>
      <thead>
        {headerGroups.map((headerGroup, i) => (
          <tr key={i} {...headerGroup.getHeaderGroupProps()}>
            {headerGroup.headers.map((column, i) => (
              <th {...column.getHeaderProps()}>{column.render('Header')}</th>
            ))}
          </tr>
        ))}
      </thead>
      <tbody {...getTableBodyProps()}>
        {rows.map((row, i) => {
          prepareRow(row)
          return (
               <tr {...row.getRowProps()}>
              {row.cells.map((cell, i) => {
                return <td {...cell.getCellProps()}>{cell.render('Cell')}</td>
              })}
              </tr>
          )
        })}
      </tbody>
    </table>
    </>
  )
}


