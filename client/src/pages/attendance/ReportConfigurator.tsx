/* eslint-disable @typescript-eslint/no-array-constructor */
/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import Button from '@mui/material/Button'
import { ReactNode } from 'react'
import CheckBox from 'src/components/muiCustom/mui/CheckBox'
import { useUpdateTimeDeductionMutation } from 'src/types/graphql-shema'
import { monthAdd } from 'src/utils/date_helper'
import { State } from './Attendance'

const months = ['янв', 'фев', 'мар', 'апр', 'май', 'июн', 'июл', 'авг', 'сен', 'окт', 'ноя', 'дек']

interface IReportConfiguratorProps {
  state: State
  setState: React.Dispatch<React.SetStateAction<State>>
}

export default function ReportConfigurator({ state, setState }: IReportConfiguratorProps) {
  const [updateTimeDeductionMutation] = useUpdateTimeDeductionMutation()

  const date = new Date()

  const handleMonthClick = (date: Date) => {
    setState({
      ...state,
      employess: [],
      selectedMonth: [date.getMonth(), date.getFullYear()]
    })
  }

  async function handleOnRetentionSave() {
    updateTimeDeductionMutation({ variables: { ID: 1, TimeDeduction: state.timeRetention } })
  }

  function handleShowFullInfo() {
    setState({
      ...state,
      showFullInfo: !state.showFullInfo
    })
  }

  const handleTimeRetentionInput: React.ChangeEventHandler<HTMLInputElement> = e => {
    setState({
      ...state,
      timeRetention: parseInt(e.target.value)
    })
  }

  const styles = css`
    background: var(--L1);
    // border: var(--border);
    margin: 0 20px;
    padding: 0.2rem;

    display: flex;
    align-items: center;
    font-size: 14px;

    .chooseMonth {
      padding: 5px;
      display: flex;
      height: fit-content;
      border-bottom: 2px solid transparent;
      div {
        padding: 5px;
        border-radius: 5px;
        color: var(--lowContrast);
        width: fit-content;
      }

      .active {
        color: var(--textInvert);
        background: var(--lowContrast);
      }
    }
    .arguments {
      display: flex;
      font-size: 0.9em;
      flex-grow: 2;

      .wrap {
        border-left: var(--border);
        padding: 15px 1rem;
        input {
          margin: 0 7px;
          background: inherit;
          border: none;
          font-weight: 600;
          color: var(--accent);
          width: 25px;
          outline: none !important;
        }
      }
    }
  `

  return (
    <div css={styles}>
      <div className="chooseMonth">
        {Array.from({ length: 9 }, (v: unknown, k: number) => k).map<ReactNode>(i => {
          const suitable = monthAdd(date, -i)
          return (
            <div
              key={i}
              onClick={() => handleMonthClick(suitable)}
              className={suitable.getMonth() === state.selectedMonth[0] ? 'active' : ''}
            >
              {[months[suitable.getMonth()]]}
            </div>
          )
        })}
      </div>

      <div className="arguments">
        <div className="wrap">
          <span>обед, мин</span>
          <input
            type="number"
            value={state.timeRetention ?? ''}
            onChange={handleTimeRetentionInput}
          />
        </div>

        <Button onClick={handleOnRetentionSave} variant="outlined" size="small">
          Сохранить
        </Button>
      </div>

      <CheckBox
        title="Показывать время прихода и ухода"
        value={state.showFullInfo}
        onClick={handleShowFullInfo}
      />
    </div>
  )
}
