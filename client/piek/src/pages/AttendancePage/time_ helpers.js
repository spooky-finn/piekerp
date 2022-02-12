import moment from "moment";


// конвертация float в часы и минуты
export function convertInterval(t){
  var hour = Math.floor(t);
  var decpart = t - hour;
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

export function getTimedelta(time1, time2){
  if (!time1 || !time2) return '' 
  const mtime1 = moment(time1, 'YYYY-MM-DDTHH:mm')
  const mtime2 = moment(time2, 'YYYY-MM-DDTHH:mm')
  var duration = moment.duration(mtime1.diff(mtime2));
  return Math.abs(duration.asSeconds())
}

export function daysInMonth (selectedMonth) {
  // количество дней в текущем месяце
    const [month, year] = selectedMonth
    return new Date(year, month+1, 0).getDate();
}