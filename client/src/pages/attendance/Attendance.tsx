import { UilConstructor } from '@iconscout/react-unicons'
import { Typography } from '@mui/material'
import { useMemo, useState } from 'react'
import { Employee } from 'src/types/global'
import { useGetEmployeeListQuery } from 'src/types/graphql-shema'
import PaperTabel from '../../components/wrappers/PaperL1'
import ReportConfigurator from './ReportConfigurator'
import Table, { genColumns } from './Table'
import { prepareEmployeeData, queryVariables } from './utils'

type FullYear = number
type Month = number

export type State = {
  employess: Employee[]
  timeRetention: number | null
  selectedMonth: SelectedMonth
  showFullInfo: boolean
}

export type SelectedMonth = [Month, FullYear]

export default function Attendance() {
  const [state, setState] = useState<State>({
    employess: [],
    timeRetention: null,
    selectedMonth: [new Date().getMonth(), new Date().getFullYear()],
    showFullInfo: false
  })

  const { gte, lte } = queryVariables(state.selectedMonth)

  const { loading } = useGetEmployeeListQuery({
    variables: { gte, lte },
    fetchPolicy: 'no-cache',
    onCompleted(data) {
      setState({
        ...state,
        timeRetention: data.attendance_config[0].TimeDeduction,
        employess: data.attendance_users_aggregate.nodes.filter(user => user.intervals.length)
      })
    }
  })

  const columns = useMemo(
    function () {
      return genColumns(state)
    },
    [state]
  )
  const data = state.employess.map(each => prepareEmployeeData(each, state))

  return (
    <>
      <div className="pageLayout__header">
        <UilConstructor className="pageLayout__icon" />
        <div className="pageLayout__title"> Рабочее время </div>
      </div>

      <ReportConfigurator state={state} setState={setState} />

      <PaperTabel>
        {!loading ? (
          <Table columns={columns} data={data} />
        ) : (
          <Typography m="10px" variant="subtitle2">
            загрузка..
          </Typography>
        )}
      </PaperTabel>
    </>
  )
}
