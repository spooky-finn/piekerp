import { useState, useEffect } from "react";
import {  Heading} from 'evergreen-ui';
import {UilAngleRight, UilPlus} from '@iconscout/react-unicons';
import './index.sass'
import Table, { columnsList } from '../PriorityLayout/tableLogic';
import { ChangeOrderStatus } from "../../hasura-queries/changeOrderStatus";
import { useMutation } from '@apollo/client';

const PreOrders = (props) => {
    const [preOrders, setPreOrders] = useState(false);
    const [changeStatus, { data }] = useMutation(ChangeOrderStatus);
    
        const handleToggle = () => {
            setPreOrders(!preOrders);
            var growDiv = document.getElementById('grow');
            if (growDiv.clientHeight == 0) growDiv.style.height = document.getElementById('measuringWrapper')?.clientHeight + 10+ 'px';
            else growDiv.style.height = 0;
          };
          

        var newColumnList = [...columnsList];
    
    newColumnList.push({
        Header: ' ',
        accessor: data => 
        <div onClick={() => {
          changeStatus({ variables: { OrderID: data.OrderID, OrderStatus: 1 } })
        }} className="acceptOrderButton"><UilPlus/></div>
        ,
      })

    return(
        <>
    
        <div className={preOrders ? "preorders-container active" : "preorders-container"} >
      
        <Heading  onClick={handleToggle} className='group-heading preorders-heading'> Предзаказы <span><UilAngleRight/></span>
        </Heading>

        <div id="grow">
         <Table id="measuringWrapper" columns={newColumnList} data={props.preOrders} />
        </div>
        </div>
       
        </>
    )
}

export default PreOrders