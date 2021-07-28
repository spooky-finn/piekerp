import {UilPrint, UilPlus, UilBell} from '@iconscout/react-unicons';



const ActionsHeader = (props) => {

    return(
        <div className="action-block">
            <div data-for='global' data-tip="Распечатать" className="action-icon"><UilPrint/></div>
            <div data-for='global' data-tip="Добавить" className="action-icon"><UilPlus/></div>
            <div data-for='global' data-tip="Уведомления" className="action-icon"><UilBell/></div>
        </div>
    )
}

export default ActionsHeader