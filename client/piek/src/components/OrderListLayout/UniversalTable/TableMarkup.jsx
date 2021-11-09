import { useTable } from 'react-table'
import mainsass from '../main.module.sass'

function statusHighlighting(order){
  // Выделение заказов требующих внимания имеют приоритет
  if (order.NeedAttention?.split(',')[0] === 'true') return mainsass.needAttention
  else if (order.AwaitingDispatch) return mainsass.awaitingDispatch
  else return ''
}
export default function Table({columns, data, className }){
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
    <table className={`${mainsass.tableMain} ${className}`} {...getTableProps()}>
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
               <tr className={statusHighlighting(row.original)} {...row.getRowProps()}>
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