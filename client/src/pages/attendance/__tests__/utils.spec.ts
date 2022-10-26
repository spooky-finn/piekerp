import moment from 'moment'
import { PreparedEmployeeDto } from 'src/types/global'
import { State } from '../Attendance'
import { ArrayFromDaysInMonth, joinAffilatedIntervals, prepareEmployeeData } from '../utils'

test('ArrayFromDaysInMonth', () => {
  const arr = ArrayFromDaysInMonth.create([3, 2022])
  expect(arr.length).toBe(30)
  expect(moment({ year: 2022, month: 3 }).daysInMonth()).toBe(30)
})

describe('joinAffilatedIntervals', () => {
  test('Single interval. Ideally case', () => {
    const data = joinAffilatedIntervals([
      {
        ent: '2022-04-14T16:00:00',
        ext: '2022-04-14T23:59:00'
      }
    ])

    expect(data).toMatchObject({
      ent: '2022-04-14T16:00:00',
      ext: '2022-04-14T23:59:00',
      dur: 28740
    })
  })

  test('Single interval. Failed case', () => {
    const data = joinAffilatedIntervals([
      {
        ent: '2022-04-14T16:00:00',
        ext: null
      }
    ])
    expect(data).toMatchObject({
      ent: '2022-04-14T16:00:00',
      ext: null,
      dur: 0
    })
  })

  test('should return two not affilated intervals', () => {
    const data = joinAffilatedIntervals([
      {
        ent: '2022-04-14T03:00:00',
        ext: '2022-04-14T08:00:00'
      },
      {
        ent: '2022-04-14T16:00:00',
        ext: '2022-04-14T23:59:00'
      }
    ])

    expect(data).toMatchObject({
      ent: '2022-04-14T03:00:00',
      ext: '2022-04-14T23:59:00',
      dur: 46740
    })
  })

  test('should correctly merging several intervals', () => {
    const data = joinAffilatedIntervals([
      {
        ent: '2022-04-14T08:00:00',
        ext: '2022-04-14T10:00:00'
      },
      {
        ent: '2022-04-14T11:00:00',
        ext: '2022-04-14T15:00:00'
      },
      {
        ent: '2022-04-14T16:10:00',
        ext: '2022-04-14T16:20:00'
      }
    ])

    expect(data).toMatchObject({
      ent: '2022-04-14T08:00:00',
      ext: '2022-04-14T16:20:00',
      dur: 22200
    })
  })

  test('should correctly merging intervals where one of them are corrupted', () => {
    const data = joinAffilatedIntervals([
      {
        ent: '2022-04-14T08:00:00',
        ext: '2022-04-14T10:00:00'
      },
      {
        card: '11003802',
        ent: '2022-04-14T11:00:00',
        ext: '2022-04-14T15:00:00'
      },
      {
        card: '11003802',
        ent: '2022-04-14T16:10:00',
        ext: null
      }
    ])
    expect(data).toMatchObject({
      ent: '2022-04-14T08:00:00',
      ext: '2022-04-14T15:00:00',
      dur: 21600
    })
  })
})

describe('prepareEmployeeData', () => {
  const state: State = {
    selectedMonth: [3, 2022],
    employess: [],
    timeRetention: 40,
    showFullInfo: false
  }

  it('Ideally case', () => {
    const empl = prepareEmployeeData(
      {
        id: 123,
        intervals: [
          {
            id: 123123,
            card: '123213',
            ent: '2022-04-14T10:00:00',
            ext: '2022-04-14T14:00:00'
          },
          {
            id: 123123,
            card: '123213',
            ent: '2022-04-14T16:00:00',
            ext: '2022-04-14T23:00:00'
          },
          {
            id: 123123,
            card: '123213',
            ent: '2022-04-15T16:00:00',
            ext: '2022-04-15T23:59:00'
          }
        ]
      },
      state
    )

    const expected = ArrayFromDaysInMonth.createOfType<PreparedEmployeeDto['intervals'][number]>(
      state.selectedMonth,
      {}
    )

    expected[13] = {
      ent: '10:00',
      ext: '23:00',
      dur: 39600,
      durWithRetention_sec: 37200,
      durWithRetention_human: '10:20'
    }

    expected[14] = {
      ent: '16:00',
      ext: '23:59',
      dur: 28740,
      durWithRetention_sec: 26340,
      durWithRetention_human: '7:19'
    }

    expect(empl.intervals).toMatchObject(expected)
  })

  it('Broken case. should correctly resolve duration', () => {
    const empl = prepareEmployeeData(
      {
        id: 123,
        firstname: 'fin',
        lastname: 'keln',
        card: '123',
        intervals: [
          {
            id: 123123,
            card: '123213',
            ent: '2022-04-15T08:00:00',
            ext: null
          },
          {
            id: 123123,
            card: '123213',
            ent: '2022-04-16T08:00:00',
            ext: '2022-04-16T15:00:00'
          }
        ]
      },
      state
    )

    const expected = ArrayFromDaysInMonth.createOfType<PreparedEmployeeDto['intervals'][number]>(
      state.selectedMonth,
      {}
    )

    expected[14] = {
      ent: '8:00',
      ext: null,
      dur: 4 * 3600,
      durWithRetention_sec: 4 * 3600 - state.timeRetention! * 60,
      durWithRetention_human: '3:20',
      resolved: true
    }

    expected[15] = {
      ent: '8:00',
      ext: '15:00',
      dur: 7 * 3600,
      durWithRetention_sec: 22800,
      durWithRetention_human: '6:20'
    }

    expect(empl).toMatchObject<PreparedEmployeeDto>({
      id: 123,
      firstname: 'fin',
      lastname: 'keln',
      card: '123',
      intervals: expected,
      monthlyWithRetention: 22800,
      monthlyWithRetentionResolved: 12000 + 22800
    })
  })
})
