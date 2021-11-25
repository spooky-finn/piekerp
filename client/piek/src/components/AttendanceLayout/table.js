import { useTable } from 'react-table'
import { daysInMonth } from './functions'
import sass from './sass/attendance.module.sass'
import { getIntervalData } from './getIntervalData'

export function generateColumns(selectedMonth, timeDeduction){
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
      Cell: row => {
        var hours = 0;
        const duration = row.row.original.intervals
        duration.forEach( interval => {
          hours += interval.dur 
        });

        //вычетаем время на обед
        hours -= timeDeduction/60 * duration.length

        return <div>{hours.toFixed(0)}</div>
      }
    }
  ]

  for (var day=1; day<= daysInMonth(selectedMonth); day++){
    columnsList.push({
      Header: day.toString(),
      Cell: row => {
        const day1 = row.column.Header

        const [ent, ext, dur] = getIntervalData(day1, row.row.original.intervals, timeDeduction)
        
        return (
          <div className={sass.intervalgrid}> 
            <div>{ ent }</div> 
            <div>{ ext }</div>
            <div className={sass.interval}>{ dur }</div>
          
          </div>
        )
      }
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


