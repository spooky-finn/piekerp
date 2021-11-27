export function getIntervalData(day, intervals, timeDeduction){

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

  const e = intervals.find(el =>  new Date(el.ent).getDate() == day)

  if (e) {
      const _entr = new Date(e.ent)
      const _exit = new Date(e.ext) || null

      const entrance = _entr.getHours()+':'+ getMinutes(_entr)

      var exit ;
      var interval;

      if (e.ext) {
        exit = _exit.getHours()+':'+ getMinutes(_exit);
        interval = convertInterval(e.dur, timeDeduction)

      }


      return [entrance, exit, interval]
  }   else return [null, null, null]
}