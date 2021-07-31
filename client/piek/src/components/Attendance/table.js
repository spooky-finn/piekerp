import { useTable } from 'react-table'
import { daysInMonth, getIntervalData } from './functions'

  
export function generateColumns(selectedMonth){
  let columnsList = [
      {
      Header: 'ФИО - должность',
      accessor: data =>
      <div>
        <span>{data.lastname} </span>
        <span>{data.firstname} </span>
      </div>
    }
  ]

  for (var day=1; day<= daysInMonth(selectedMonth); day++){
    
    columnsList.push({
      Header: day.toString(),
      Cell: row => {
        const day1 = row.column.Header

        const data = getIntervalData(day1, row.row.original.intervalsPools)
        return (
          <div className="">{data}</div>
        )
      }
    })
  }
  return columnsList
}


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
    <table id={id} className="attendance-table" {...getTableProps()}>
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


