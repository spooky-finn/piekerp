
import { useRef } from "react";
import { monthAdd } from "./time_ helpers";
import { useMutation } from "@apollo/client"
import { UPDATE_TIME_DEDUCTION } from "./queries/updateTimeDeduction"
import { notif } from '../../utils/notification'
import Button from '@mui/material/Button'

const months = ["янв", "фев", "мар", "апр", "май", "июн", "июл", "авг", "сен", "окт", "ноя", "дек"];

const ReportConfigurator = ({ state, dispatch }) => {
    const [ updateTimeDeductionMutation ] = useMutation(UPDATE_TIME_DEDUCTION);
    const timedeductionRef = useRef();

    const date = new Date()
  
    const reportMonthHandler = (e) => {
        const d = new Date(e.target.attributes.date.value)
        dispatch({type: 'intervals', payload: [] })
        dispatch({type: 'selectedMonth', payload: [d.getMonth(), d.getFullYear()] })
    }

    async function timeDeductionHandler(){
        const variables = {
            ID: 1,
            TimeDeduction:  parseInt(timedeductionRef.current.value)
        }
        const responce = await updateTimeDeductionMutation({ variables: variables });
        if (responce.data.update_attendance_config_by_pk){
            notif('info', 'Значение обновлено')
            dispatch({ type: 'timeDeduction', payload: timedeductionRef.current.value})
        }
    }

    const chooseMonth = () => {
        const m = []
        var i = 0;
        while ( i < 9){
            const suitable = monthAdd(date, -i)
            m.push(<div key={suitable} onClick={reportMonthHandler} 
                        className={suitable.getMonth() === state.selectedMonth[0] ? 'active' : ''}
                        date={suitable}>
                    {months[suitable.getMonth()]} 
                    </div>
                )
            i++;
        }
        return <div className="chooseMonth">{m}</div>
    }
    
    return (
    <div className="reportConfigurator">
        {chooseMonth()}
        
        <div className="arguments">
            <div className="wrap">
                <span>обед, мин</span>
                 <input type='number' defaultValue={state.timeDeduction} ref={timedeductionRef} />
            </div>

            <Button onClick={timeDeductionHandler} variant='outlined'>Сохранить</Button>
            
        </div>
    </div>
    )
}

export default ReportConfigurator