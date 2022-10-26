import moment from 'moment'
import 'moment/locale/ru'
moment.locale('ru')

type FormatTime = {
  (seconds: number): string | null
  (date: string | moment.Moment): string | null
}

export const getPreviousMonth = () => moment().subtract(1, 'months').month()

export const formatOnlyDate = (date: string) => {
  if (!date) return null
  return moment(date).format('DD.MM.YY')
}

/**
 * @returns  Numerical date with hours and minutes, e.g 8:31
 */
export const formatDateWithTime = (date: string) => {
  if (!date) return null
  moment.locale('ru')
  return moment(date).format('DD.MM.YY H:mm')
}

/**
 *  also converts seconds.
 * @returns hours and minutes, e.g 8:31
 */
export const formatTime: FormatTime = (payload: string | moment.Moment | number) => {
  if (!payload) return null

  if (typeof payload === 'number') {
    return moment.utc(payload * 1000).format('H:mm')
  }

  return moment(payload).format('H:mm')
}

export class NullTimeError extends Error {}

export function monthAdd(date: Date, month: number) {
  // функция используется для корректного вычитания месяцев в chooseMonth
  var temp = date
  temp = new Date(date.getFullYear(), date.getMonth(), 1)
  temp.setMonth(temp.getMonth() + (month + 1))
  temp.setDate(temp.getDate() - 1)

  if (date.getDate() < temp.getDate()) {
    temp.setDate(date.getDate())
  }
  return temp
}

export function timedeltaInSeconds(
  time1: string | null | undefined,
  time2: string | null | undefined
) {
  if (!time1 || !time2) {
    return new NullTimeError()
  }

  const mtime1 = moment(time1, 'YYYY-MM-DDTHH:mm')
  const mtime2 = moment(time2, 'YYYY-MM-DDTHH:mm')
  var duration = moment.duration(mtime1.diff(mtime2))
  return Math.abs(duration.asSeconds())
}

export function sec2hours(seconds: number) {
  return (seconds / 3600).toFixed(0)
}
