import { useTable } from 'react-table'
import mainsass from '../main.module.sass'
import { Link } from 'react-router-dom'

function statusHighlighting(order, showUnpaid){
  if (showUnpaid && order.unpaid) return mainsass.unpaidOrder

  // Выделение заказов требующих внимания имеют приоритет
  if (order.NeedAttention?.split(',')[0] === 'true') return mainsass.needAttention
  else if (order.AwaitingDispatch) return mainsass.awaitingDispatch
  else return ''
}
export default function Table({columns, data, className, showUnpaid }){
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

    if (data.length === 0) return null;
   return (
     <>
    <div className={`${mainsass.tableMain} ${className} ${mainsass.table}`} {...getTableProps()}>
      <div className={mainsass.thead}>
        {headerGroups.map((headerGroup, i) => (
          <div className={mainsass.tr} key={i} {...headerGroup.getHeaderGroupProps()}>
            {headerGroup.headers.map((column, i) => (
              <div  className={mainsass.th} {...column.getHeaderProps()}>{column.render('Header')}</div>
            ))}
          </div>
        ))}
      </div>
      <div {...getTableBodyProps()} className={mainsass.tbody}>
        {rows.map((row, i) => {
          prepareRow(row)

          const { OrderID } = row.original
          return (
              <Link to={`/orders/${OrderID}`} className={`${statusHighlighting(row.original, showUnpaid)} ${mainsass.tableRow}`} {...row.getRowProps()}>
              {row.cells.map((cell, i) => {
                return <div  className={mainsass.td} {...cell.getCellProps()}>{cell.render('Cell')}</div>
              })}
              </Link>
          )
        })}
      </div>
    </div>
    </>
  )
}