import { columnsList } from '../UniversalTable/columnList'
import Table from "../UniversalTable/TableMarkup";

import Search from '../Search';
import { filter } from '../Search/filter'

//apollo
import { MUTATE_ORDER_STATUS } from "./MutationOrderStatus";
import { useMutation } from '@apollo/client';

//UI
import { UilPlus} from '@iconscout/react-unicons';
import sass from './preorders.module.sass'
import mainsass from '../main.module.sass'

const PreOrders = ({ state, dispatch }) => {
    const data = state.preOrders
    const [mutationOrderStatus] = useMutation(MUTATE_ORDER_STATUS);

    const onClickTransfer = (order) => {
        data.splice(data.indexOf(order), 1)
        dispatch({ type: 'preOrders', payload: data })

        mutationOrderStatus({ variables: { 
            OrderID: order.OrderID, 
            AcceptanceDate: new Date().toLocaleString("en-US", {timeZone: "Europe/Moscow"}) } 
        })
    }

    var newColumnList = [...columnsList];
    const filtredData = filter(data, state.searchKeyword)
    
    newColumnList.push({
        Header: ' ',
        accessor: data => 
        <div onClick={() => onClickTransfer(data)} className="square-button"><UilPlus/></div>
        ,
      })
   
    return(
    <div className={`${mainsass.tableWrapper} ${sass.preOrdersTableWrapper}`}>
        <Search state={state} dispatch={dispatch} />
        {filtredData && <Table columns = {newColumnList} data = {filtredData} />}
    </div>
    )
}
export default PreOrders