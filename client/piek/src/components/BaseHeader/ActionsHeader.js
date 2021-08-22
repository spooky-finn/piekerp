import {UilPrint, UilPlus, UilBell, UilEditAlt} from '@iconscout/react-unicons';



const ActionsHeader = (props) => {
    const handleClick = () => {
        props.setEditState(!props.editState)
    }

    const editOrderBtn = () => {
        if (props.accessLevel == 2){
            const editIconClass = () => props.editState ? 'action-icon active': 'action-icon'
            return <div data-for='global' data-tip="Добавить" className={editIconClass()} onClick={handleClick}><UilEditAlt/></div>
        }
    }

    const addOrder = () => {
        if (props.createOrder){
            return <div data-for='global' data-tip="Добавить" className="action-icon"><UilPlus/></div>
        }
    }
    return(
        <div className="action-block">
            <div data-for='global' data-tip="Распечатать" className="action-icon"><UilPrint/></div>
            {addOrder()}
            {editOrderBtn()}
            {/* <div data-for='global' data-tip="Уведомления" className="action-icon"><UilBell/></div> */}
        </div>
    )
}

export default ActionsHeader