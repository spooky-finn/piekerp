import { useTable } from 'react-table'
import mainsass from '../main.module.sass'

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

    if (data.length === 0) return '-> ничего не найдено';
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
          const unpaidOrder = row.original.unpaid
          return (
               <tr className={unpaidOrder ? mainsass.unpaidOrder : ''} {...row.getRowProps()}>
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