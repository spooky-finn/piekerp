import { useState } from "react";

import Table, { columnsList } from '../PriorityLayout/tableLogic'

//apollo
import { MUTATE_ORDER_STATUS } from "../../hasura-queries/MutationOrderStatus";
import { useMutation } from '@apollo/client';

//UI
import { Heading} from 'evergreen-ui';
import {UilAngleRight, UilPlus} from '@iconscout/react-unicons';
import './index.sass'

const PreOrders = (props) => {
    const [showPreOrders, setShowPreOrders] = useState(false);

    const [mutationOrderStatus, { data }] = useMutation(MUTATE_ORDER_STATUS);


    let dt = props.preOrders
    
        const handleToggle = () => {
            setShowPreOrders(!showPreOrders);
            var growDiv = document.getElementById('grow');
            if (growDiv.clientHeight == 0) growDiv.style.height = document.getElementById('measuringWrapper')?.clientHeight + 10+ 'px';
            else growDiv.style.height = 0;
          };
          
    
        const onClickTransfer = (data) => {
          mutationOrderStatus({ variables: { OrderID: data.OrderID, OrderStatus: 1 } })
          dt.splice(dt.indexOf(data), 1)
          if (dt.length == 0) handleToggle()
        }


    var newColumnList = [...columnsList];

    newColumnList.push({
        Header: ' ',
        accessor: data => 
        <div onClick={() => onClickTransfer(data)} className="square-button"><UilPlus/></div>
        ,
      })

    return(
        <>
    
        <div className={showPreOrders ? "preorders-container active" : "preorders-container"} >
      
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