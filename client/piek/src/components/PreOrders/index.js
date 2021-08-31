import { useState, useContext } from "react";
import { Context } from '../../index'

import Table, { columnsList } from '../PriorityLayout/tableLogic'

//apollo
import { MUTATE_ORDER_STATUS } from "../../hasura-queries/MutationOrderStatus";
import { useMutation } from '@apollo/client';

//UI
import {ExpansionPanel, ExpansionPanelSummary, ExpansionPanelDetails } from '@material-ui/core';
import { Heading} from 'evergreen-ui';
import {UilAngleRight, UilPlus} from '@iconscout/react-unicons';
import './index.sass'

const PreOrders = (props) => {
    const { store } = useContext(Context);

    const [expanded, setExpanded] = useState(store.showPreOrders);
    
    const [mutationOrderStatus] = useMutation(MUTATE_ORDER_STATUS);


    let dt = props.preOrders
    
    const handleChange = panel => (event, newExpanded) => {
        store.setShowPreOrders(newExpanded);
        setExpanded(newExpanded ? panel : false);
    };

    const onClickTransfer = (data) => {
        mutationOrderStatus({ variables: { OrderID: data.OrderID, OrderStatus: 1 } })
        dt.splice(dt.indexOf(data), 1)
        // if (dt.length == 0) handleToggle()
    }


    var newColumnList = [...columnsList];

    newColumnList.push({
        Header: ' ',
        accessor: data => 
        <div onClick={() => onClickTransfer(data)} className="square-button"><UilPlus/></div>
        ,
      })
   
               
    return(
        <div className={expanded ? "preorders-container active" : "preorders-container"} >
    
          <ExpansionPanel square expanded={expanded === true} onChange={handleChange(true)}>
            <ExpansionPanelSummary aria-controls="panel1d-content" id="panel1d-header">
            
            <Heading className='group-heading preorders-heading'> Предзаказы <span><UilAngleRight/></span></Heading>
            </ExpansionPanelSummary>
            <ExpansionPanelDetails>
                <Table id="measuringWrapper" columns={newColumnList} data={props.preOrders} />
            </ExpansionPanelDetails>

        </ExpansionPanel>


        </div>
    )
}

export default PreOrders