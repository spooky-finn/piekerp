import { useMutation } from '@apollo/client';
import { INSERT_ORDER } from './MutationInsertOrder'

import {UilPrint, UilPlus, UilBell, UilEditAlt} from '@iconscout/react-unicons';
import { UserIcon } from 'evergreen-ui';



const ActionsHeader = (props) => {
    const [ createNewOrder] = useMutation(INSERT_ORDER, {variables: {
        'managerID':     props.userID,
        'orderStatusID': 3,
        'isReclamation':  false,
    }})

    const createOrderHandler = () => {
        createNewOrder().then( (res) => {
            props.history.push(`/orders/${res.data.insert_erp_Orders.returning[0].OrderID}?edit=true`)
        })
    }

    const editOrderHandler = () => {
        props.setEditState(!props.editState)
    }

    const editOrderBtn = () => {
        if (props.accessLevel == 2){
            const editIconClass = () => props.editState ? 'action-icon active': 'action-icon'
            return <div data-for='global' data-tip="Добавить" className={editIconClass()} onClick={editOrderHandler}><UilEditAlt/></div>
        }
    }

    const addOrder = () => {
        if (props.createOrder){
            return <div data-for='global' data-tip="Добавить" onClick={createOrderHandler} className="action-icon"><UilPlus/></div>
        }
    }
    return(
        <div className="action-block">
            {/* <div data-for='global' data-tip="Распечатать" className="action-icon"><UilPrint/></div> */}
            {addOrder()}
            {editOrderBtn()}
            {/* <div data-for='global' data-tip="Уведомления" className="action-icon"><UilBell/></div> */}
        </div>
    )
}

export default ActionsHeader