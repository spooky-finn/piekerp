import { useTable } from 'react-table'
import {Heading} from 'evergreen-ui';


// количество дней в текущем месяце
function daysInMonth (month, year) {
  var dt = new Date();
  var month = dt.getMonth() +1;
  var year = dt.getFullYear();
  return daysInMonth = new Date(year, month, 0).getDate();
}

export let columnsList = [
    {
      Header: 'ФИО - должность',
      accessor: data =>
      <div>
         <span>{data.firstname} </span>
         <span>{data.lastname}</span>
         <div>{data.card}</div>
      </div>
     
    }
  ]

// function getEntrance(day, intervals){
//   const entrance = intervals.find(event => event?.entrance.split('-')[2].split('T')[0] == day)
//   // console.log(entrance?.entrance, 'ee')
//   return entrance?.entrance.split('T')[1]
// }

function getEntrance(day, intervals){

  const entrance = intervals.map(event => {

    const date = new Date(event.entrance)
    if (date.getDate() == day ) return date.getDate()

  })
  // const entrance = intervals.find(event => event?.entrance.split('-')[2].split('T')[0] == day)
  console.log(entrance, 'ee')
  return entrance
}

export function months(columnsList){
  const days = daysInMonth()

  for (var day=1; day<=days; day++){
    
    columnsList.push({
      Header: day.toString(),
      Cell: row => {
        console.log(row)
        const day = row.column.Header
        return (
          <div>{getEntrance(day, row.row.original.intervalsPools)}</div>
        )
      }
    })
  }
  console.log(columnsList)
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


