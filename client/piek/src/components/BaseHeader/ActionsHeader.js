import {UilPrint, UilPlus, UilBell, UilEditAlt} from '@iconscout/react-unicons';



const ActionsHeader = (props) => {
    const handleClick = () => {
        props.setEditState(!props.editState)
    }
    return(
        <div className="action-block">
            <div data-for='global' data-tip="Распечатать" className="action-icon"><UilPrint/></div>
            <div data-for='global' data-tip="Добавить" className="action-icon"><UilPlus/></div>
            {props.accessLevel == 2 ? <div data-for='global' data-tip="Добавить" className="action-icon" onClick={handleClick}><UilEditAlt/></div> : null}
            {/* <div data-for='global' data-tip="Уведомления" className="action-icon"><UilBell/></div> */}
        </div>
    )
}

export default ActionsHeader