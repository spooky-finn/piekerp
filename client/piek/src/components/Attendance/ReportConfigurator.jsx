
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

const ReportConfigurator = (props) => {

    const date = new Date()
    const months = ["янв", "фев", "мар", "апр", "май", "июн", "июл", "авг", "сен", "окт", "ноя", "дек"];


    console.log('рендер ребенка')

    const handleToggle = (e) => {
        const d = new Date(e.target.attributes.date.value)
        props.setSelectedMonth([d.getMonth(), d.getFullYear()])
    }

    const chooseMonth = () => {
        const m = []
        
        for (var i=0; i< 9; i++) {
            const suitable = monthAdd(date, -i)
            m.push(
                <div onClick={handleToggle} 
                    className={suitable.getMonth() == props.selectedMonth[0] ? 'active' : ''}
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
                <input type='text' defaultValue={props.timeDeduction} onMouseLeave={e => props.setTimeDeduction(e.target.value)}/>
                <span>мин</span>
            </div>
            
            <div className="wrap">
                <span>норма</span>
                <input type='text' defaultValue={props.timeDeduction}/>
                <span>ч</span>
            </div>
        </div>
    </div>
    )
}

export default ReportConfigurator