import { get } from "mobx";

export function monthAdd(date, month) {
  // функция используется для корректного вычитания месяцев в chooseMonth
  var temp = date;
  temp = new Date(date.getFullYear(), date.getMonth(), 1);
  temp.setMonth(temp.getMonth() + (month + 1));
  temp.setDate(temp.getDate() - 1); 

  if (date.getDate() < temp.getDate()) { 
      temp.setDate(date.getDate()); 
  }
  return temp;    
}

export function daysInMonth (selectedMonth) {
    // количество дней в текущем месяце
      const [month, year] = selectedMonth
      return new Date(year, month+1, 0).getDate();
}

export function getIntervalData(day, intervals){

    
    const data = intervals.map(event => {

      const entrance = new Date(event.entrance)
      const exit = new Date(event.exit)

      if (entrance.getDate() == day ) return (
      <>
        <div>{entrance.getHours()+':'+entrance.getMinutes()}</div> 
        <div>{exit.getHours()+':'+exit.getMinutes()}</div>
        <div className="interval">{convertInterval(event.interval)}</div>
      </>
      )
  
    })
    return data
}
  
function convertInterval(number){
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

export function getVarsForSubscription(selectedMonth){
  const [month, year] = selectedMonth
  // +1 because in js mounths start since 0, whereas hasura timestamp starts 1
  var a = (parseInt(month)+1).toString()

  // this expression add zero to mothh if minth.length < 2 ( 5 > 05 )
  const m = a.replace(/(^|\D)(\d)(?!\d)/g, '$10$2')

  const gte = year+ "-"+ m +"-01T00:00:00";
  const lte = year+ "-"+ m +"-" +daysInMonth(selectedMonth)+ "T23:59:59";
  return {gte, lte}
}