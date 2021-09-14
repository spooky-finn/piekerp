
function monthAdd(date, month) {
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

const ReportConfigurator = ({ state, dispatch }) => {
    const date = new Date()
    const months = ["янв", "фев", "мар", "апр", "май", "июн", "июл", "авг", "сен", "окт", "ноя", "дек"];

    const selectedMonthHandler = (e) => {
        const d = new Date(e.target.attributes.date.value)
        dispatch({type: 'selectedMonth', payload: [d.getMonth(), d.getFullYear()] })
    }

    const timeDeductionHandler = (e) => {
        dispatch({
            type: 'timeDeduction',
            payload: parseInt(e.target.value.trim())
        })
    }

    const chooseMonth = () => {
        const m = []
        
        for (var i=0; i< 6; i++) {
            const suitable = monthAdd(date, -i)
            m.push(
                <div onClick={selectedMonthHandler} 
                    className={suitable.getMonth() == state.selectedMonth[0] ? 'active' : ''}
                    date={suitable}> {months[suitable.getMonth()]} </div>
                )
        } 
        return <div className="chooseMonth">{m}</div>
    }

    return (
        <div className="reportConfigurator">
        {chooseMonth()}
        
        <div className="arguments">
            <div className="wrap">
                <span>обед</span>
                <input type='text' defaultValue={state.timeDeduction} onChange={timeDeductionHandler}/>
                <span>мин</span>
            </div>
            
            {/* <div className="wrap">
                <span>норма</span>
                <input type='text' defaultValue={state.timeDeduction}/>
                <span>ч</span>
            </div> */}
        </div>
    </div>
    )
}

export default ReportConfigurator