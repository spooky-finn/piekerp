import { useTable } from 'react-table'
import {Heading} from 'evergreen-ui';
import { Link } from 'react-router-dom'


export const setPaidPercent = (total, paid) => {
    if (!total || !paid){
        return ' '    
    }
    return ' - ' + ((paid/total) * 100).toFixed(0) + '%'
}

export const getShippingDate = (SD) => {
  return SD.split("-")[2] + '.' + SD.split("-")[1] + '.' + SD.split("-")[0].slice(2)
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
      accessor: data =>
      <Link to={`/order/${data.OrderID}`}>
          {data.OrderItems.map(item => (
            <div key={item.OrderItemID} >
              <span>{item.Name}</span>
            </div>
          ))}
        </Link>
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
      accessor: 'ShippingDate',
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

    <Heading className='group-heading'>{heading}</Heading>
    <table id={id} className="priority-table" {...getTableProps()}>
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


