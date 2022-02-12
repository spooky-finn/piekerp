import { daysInMonth, getTimedelta, convertInterval } from "./time_ helpers";
import moment from "moment";
import sass from './sass/attendance.module.sass'


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

export function calc_hours_for_mounth(row, {timeDeduction, selectedMonth}){
  var total_t = 0;
  var with_human_mistakes = 0
  for (var day=1; day<= daysInMonth(selectedMonth); day++){

    const findedIntervalsForCurrentDay = row.row.original.intervals.filter(each =>  new Date(each.ent).getDate() == day)

    // Для каждого интревала в текщем дне
    for (const property in findedIntervalsForCurrentDay){
      const each = findedIntervalsForCurrentDay[property];
      const dur = parseFloat(getTimedelta(each.ent, each.ext));
      if (!dur) continue;
      total_t += dur;

    }

    // вычетаем время на обед
    if (findedIntervalsForCurrentDay.length > 0){
      total_t -= timeDeduction * 60

      // with_human_mistakes += total_t  
      if (findedIntervalsForCurrentDay[0]?.ext == null){
        with_human_mistakes += 4*3600
      }
    };
  }

  total_t = total_t / 60 / 60;
  with_human_mistakes = total_t + (with_human_mistakes / 60 /60)
 
  if (!total_t) return '';

  const human_mistakes = () => {
    if (with_human_mistakes !== total_t) return <div className={sass.intervalred}>{with_human_mistakes.toFixed(0)}</div>
  }

  return <div>{total_t.toFixed(0)} {human_mistakes()}</div>
}

export function fill_columns(row, {timeDeduction}){
  const columnDay = row.column.Header
  const data = row.row.original.intervals.filter(el =>  new Date(el.ent).getDate() == columnDay)
  if (data.length === 0) return <div></div>;

  var ent = moment(data[0].ent, "YYYY-MM-DDTHH:mm").format("HH:mm");
  var ext = moment(data[0].ext, "YYYY-MM-DDTHH:mm").format("HH:mm");
  var total_duration = getTimedelta(data[0].ent, data[0].ext);
  // console.log(data[0].ext);

  if (ext === "Invalid date") ext = ''
  // If we have several intervals on one day
  if (data.length >= 2){
    var i = 1
    data.forEach(each => {
      if ( data[data.length-i].ext ) 
        ext = moment(data[data.length-i].ext, "YYYY-MM-DDTHH:mm").format("HH:mm");
      else i++;
    })
    data.forEach(each => total_duration += getTimedelta(each.ent, each.ext) )
  }

  return (
    <div className={sass.intervalgrid}> 
      <div>{ ent }</div> 
      <div>{ ext }</div>
      {
        ext ?  <div className={sass.interval}>{ convertInterval((total_duration/3600) - (timeDeduction / 60) ) }</div>
            :  <div className={`${sass.interval} ${sass.intervalred}`}>4:00</div>
      }
      {/* <div className={sass.countIntervals}>{ data.length }</div> */}
    </div>
  ) 
}