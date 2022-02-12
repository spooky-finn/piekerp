import { columnsList } from '../UniversalTable/columnList'
import Table from "../UniversalTable/TableMarkup";

import Search from '../Search';
import { filter } from '../Search/filter'

//apollo
import { MUTATE_ORDER_STATUS } from "./MutationOrderStatus";
import { useMutation } from '@apollo/client';

//UI
import { UilFileCheck} from '@iconscout/react-unicons';
import sass from './preorders.module.sass'
import mainsass from '../main.module.sass'
import { Button } from '@mui/material';

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
        Header: 'Принять',
        accessor: data => 
        <Button onClick={() => onClickTransfer(data)} variant='iconic'><UilFileCheck/></Button>
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