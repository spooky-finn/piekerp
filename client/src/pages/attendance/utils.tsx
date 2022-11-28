/* eslint-disable no-loop-func */
import moment from 'moment'
import { Employee, PreparedEmployeeDto } from 'src/types/global'
import { formatTime } from 'src/utils/date'
import { SelectedMonth, State } from './Attendance'
import { NullTimeError, timedeltaInSeconds } from 'src/utils/date'

const BROKEN_INTERVAL_TIME = 4 * 3600

type TPreparedInterval = PreparedEmployeeDto['intervals'][number]

export class ArrayFromDaysInMonth extends Array {
  static create(selectedMonth: SelectedMonth) {
    const [month, year] = selectedMonth
    const days_number = new Date(year, month + 1, 0).getDate()
    return Array.from({ length: days_number }, (v: unknown, k: number) => k + 1)
  }

  static createOfType<T>(selectedMonth: SelectedMonth, fillWith: T) {
    const [month, year] = selectedMonth
    const days_number = new Date(year, month + 1, 0).getDate()
    return Array.from<T>({ length: days_number }).fill(fillWith)
  }
}

export function queryVariables(selectedMonth: SelectedMonth) {
  const [month, year] = selectedMonth
  // +1 because in js mounths start since 0, whereas hasura timestamp starts 1
  var a = (month + 1).toString()
  // this expression add zero to mothh if minth.length < 2 ( 5 > 05 )
  const m = a.replace(/(^|\D)(\d)(?!\d)/g, '$10$2')
  // moment({ year: })
  const gte = year + '-' + m + '-01T00:00:00'
  const lte = year + '-' + m + '-' + moment({ year, month }).daysInMonth() + 'T23:59:59'
  return { gte, lte }
}

export function prepareEmployeeData(employee: Employee, state: State): PreparedEmployeeDto {
  const { firstname, lastname, id, card } = employee

  const timeDeduction_s = (state.timeRetention ?? 0) * 60

  const intervals = ArrayFromDaysInMonth.createOfType<PreparedEmployeeDto['intervals'][number]>(
    state.selectedMonth,
    {}
  ).map<TPreparedInterval>((_, index) => {
    const day = index + 1
    // интервалы сотрудника в течении дня
    const usrIntervals = employee.intervals.filter(each => new Date(each.ent).getDate() === day)

    if (!usrIntervals.length) return {}

    let joined = joinAffilatedIntervals(usrIntervals)
    const isIntervalBroken = joined.ext ? false : true

    if (isIntervalBroken) {
      joined.dur = BROKEN_INTERVAL_TIME
    }

    return {
      ent: formatTime(joined.ent),
      ext: formatTime(joined.ext),
      dur: joined.dur,
      durWithRetention_sec: joined.dur - timeDeduction_s,
      durWithRetention_human: formatTime(joined.dur - timeDeduction_s),
      resolved: isIntervalBroken
    }
  })

  const { monthlyWithRetention, monthlyWithRetentionResolved } = intervals.reduce<{
    monthlyWithRetention: number
    monthlyWithRetentionResolved: number
  }>(
    (acc, cur) => {
      const dur = cur.durWithRetention_sec
      if (!dur) return acc

      return cur.resolved
        ? {
            ...acc,
            monthlyWithRetentionResolved: acc.monthlyWithRetentionResolved + dur
          }
        : {
            monthlyWithRetentionResolved: acc.monthlyWithRetentionResolved + dur,
            monthlyWithRetention: acc.monthlyWithRetention + dur
          }
    },
    { monthlyWithRetention: 0, monthlyWithRetentionResolved: 0 }
  )

  return {
    id,
    card: card ?? '',
    firstname: firstname ?? '',
    lastname: lastname ?? '',
    intervals: intervals as any,
    monthlyWithRetention,
    monthlyWithRetentionResolved
  }
}

export function joinAffilatedIntervals<
  O extends Array<{
    ent?: string | null
    ext?: string | null
  }>
>(user_intervals: O) {
  const initial_value: O[number] & { dur: number } = {
    dur: 0,
    ext: null,
    ent: 'qwe'
  }

  return (
    user_intervals
      .slice()
      // разворачиваем массив поскольку нужно найти последнюю отметку выхода и зафиксировать ее
      .reverse()
      .reduce<typeof initial_value>((acc, cur) => {
        const durationOrError = timedeltaInSeconds(cur.ent, cur.ext)
        const duration_s = !(durationOrError instanceof NullTimeError) ? durationOrError : 0

        return cur.ext && !acc.ext
          ? // Берет посделний интервал у которого есть время выхода
            {
              ent: cur.ent,
              ext: cur.ext,
              dur: duration_s
            }
          : {
              ...acc,
              ent: cur.ent,
              dur: acc.dur + duration_s
            }
      }, initial_value)
  )
}
