export function daysInMonth (selectedMonth) {
    // количество дней в текущем месяце
      const [month, year] = selectedMonth
      return new Date(year, month+1, 0).getDate();
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

export function search_alg(user, keyword){
  if (user.lastname.toLowerCase().startsWith(keyword.toLowerCase())) return true
  else if (user.firstname.toLowerCase().startsWith(keyword.toLowerCase())) return true
  else return false
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