import { useTable } from 'react-table'
import { daysInMonth } from './time_ helpers'
import {fill_columns, calc_hours_for_mounth } from './functions'


export function generateColumns(selectedMonth, timeDeduction){
  const props = {
    selectedMonth,
    timeDeduction
  }

  let columnsList = [
      {
      Header: 'Сотрудник',
      accessor: data =>
      <div>
        <span>{data.lastname} </span>
        <span>{data.firstname} </span>
      </div>
    }, 
    {
      Header: 'Итого',
      Cell: row => calc_hours_for_mounth(row, props)
    }
  ]

  for (var day=1; day<= daysInMonth(selectedMonth); day++){
    columnsList.push({
      Header: day.toString(),
      Cell: row => fill_columns(row, props)
    })
  }
  return columnsList
}


export default function Table({columns, data, className}){
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


   return (
     <>
    <table className={className} {...getTableProps()}>
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


