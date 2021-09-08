import { useState, useContext } from "react";
import { Context } from '../../../index'

import { columnsList } from '../UniversalTable/columnList'
import Table from "../UniversalTable/TableMarkup";

//apollo
import { MUTATE_ORDER_STATUS } from "./MutationOrderStatus";
import { useMutation } from '@apollo/client';

//UI
import {Accordion, AccordionSummary, AccordionDetails } from '@material-ui/core';
import {UilAngleRight, UilPlus} from '@iconscout/react-unicons';
import sass from './preorders.module.sass'

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
        dt.splice(dt.indexOf(data), 1)
        mutationOrderStatus({ variables: { OrderID: data.OrderID} })
    }
    var newColumnList = [...columnsList];

    newColumnList.push({
        Header: ' ',
        accessor: data => 
        <div onClick={() => onClickTransfer(data)} className="square-button"><UilPlus/></div>
        ,
      })
   
               
    return(
        <div className={expanded ? `${sass.preordersContainer} ${sass.active}` : sass.preordersContainer }>
    
          <Accordion expanded={expanded === true} onChange={handleChange(true)}>
            <AccordionSummary>
                <h6 className={sass.preordersHeading}>
                    Предзаказы 
                    <span><UilAngleRight/></span>
                </h6>
            </AccordionSummary>
            <AccordionDetails >
                <Table  columns={newColumnList} data={props.preOrders}/>
            </AccordionDetails>

        </Accordion>
        </div>
    )
}
export default PreOrders