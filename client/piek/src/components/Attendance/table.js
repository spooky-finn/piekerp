import { useTable } from 'react-table'
import { daysInMonth } from './functions'

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
        const intervals = row.row.original.intervalsPools
        intervals.forEach( interval => {
          hours += interval.interval 
        });

        //вычетаем время на обед
        hours -= timeDeduction/60 * intervals.length

        return <div>{hours.toFixed(0)}</div>
      }
    }
  ]

  for (var day=1; day<= daysInMonth(selectedMonth); day++){
    columnsList.push({
      Header: day.toString(),
      Cell: row => {
        const day1 = row.column.Header

        const [entrance, exit, interval, status] = getIntervalData(day1, row.row.original.intervalsPools, timeDeduction)
        return (
          <div className={"status-"+ status}> 
            <div className="eventTime">{ entrance }</div> 
            <div className="eventTime">{ exit }</div>
            <div className="interval">{ interval }</div>
          
          </div>
        )
      }
    })
  }
  return columnsList
}



function getIntervalData(day, intervals, timeDeduction){

    // конвертация float в часы и минуты
    function convertInterval(number, timeDeduction){
        //вычетаем время на обед
        number -= timeDeduction/60

        var hour = Math.floor(number);
        var decpart = number - hour;
        var min = 1 / 60;

        // Round to nearest minute
        decpart = min * Math.round(decpart / min);
        var minute = Math.floor(decpart * 60) + '';

        // Add padding if need
        if (minute.length < 2) {
            minute = '0' + minute; 
        }

        return hour + ':' + minute;
    }

    function getMinutes(t){
        const minutes = t.getMinutes()
        return (minutes < 10) ? `0${minutes}` : minutes
    }

    const e = intervals.find(el =>  new Date(el.entrance).getDate() == day)

    if (e) {
        const _entr = new Date(e.entrance)
        const _exit = new Date(e.exit)

        const entrance = _entr.getHours()+':'+ getMinutes(_entr)
        const exit = _exit.getHours()+':'+ getMinutes(_exit)
        const interval = convertInterval(e.interval, timeDeduction)

        return [entrance, exit, interval, e.status]
    }   else return [null, null, null, null]
}

export default function Table({columns, data, id, heading, className}){
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
    <table id={id} className={className} {...getTableProps()}>
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


