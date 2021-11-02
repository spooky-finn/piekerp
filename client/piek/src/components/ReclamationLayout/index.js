import { Link, useHistory } from 'react-router-dom'
import { useReducer } from 'react'


import sass from './index.module.sass'
import { Button, Typography, Box } from "@mui/material"

import { UilWrench, UilPlus, UilArchive } from '@iconscout/react-unicons'
import { DragDropContext, Droppable, Draggable } from 'react-beautiful-dnd';

import { reducer, initialState } from './reducer';
//apollo
import { useSubscription, useMutation } from '@apollo/client'
import { 
  SUBSCRIPTION_RECLAMATION_ORDERS, 
  UPDATE_ORDER_STATUS,
  INSERT_ORDER } from './queries';


// a little function to help us with reordering the result
const reorder = (list, startIndex, endIndex) => {
    const result = Array.from(list);
    const [removed] = result.splice(startIndex, 1);
    result.splice(endIndex, 0, removed);

    return result;
};

/**
 * Moves an item from one list to another list.
 */
const move = (source, destination, droppableSource, droppableDestination) => {
    const sourceClone = Array.from(source);
    const destClone = Array.from(destination);
    const [removed] = sourceClone.splice(droppableSource.index, 1);
    destClone.splice(droppableDestination.index, 0, removed);

    const result = {};
    result[droppableSource.droppableId] = sourceClone;
    result[droppableDestination.droppableId] = destClone;
    return {result, movedObj: removed };
};

const grid = 8;

const getItemStyle = (isDragging, draggableStyle) => ({
    // some basic styles to make the items look a bit nicer
    userSelect: 'none',

    // change background colour if dragging
    background: isDragging ? 'var(--accentLight)' : 'transparent',

    // styles we need to apply on draggables
    ...draggableStyle
});


const Reclamation = (props) => {
  const [state, dispatch] = useReducer(reducer, initialState)
  const { inbox, decision, inproduction } = state;
  const history = useHistory();


  const getState = id => {
    if (id === 'inbox') return inbox
    if (id === 'decision') return decision
    if (id === 'inproduction') return inproduction
  };

  const columns = [
    {
      columnName: 'Входящие',
      droppableId: 'inbox',
      data: inbox,
      orderStatusID: 10
    },
    {
      columnName: 'Принятие решения',
      droppableId: 'decision',
      data: decision,
      orderStatusID: 11
    },
    {
      columnName: 'В производстве',
      droppableId: 'inproduction',
      data: inproduction,
      orderStatusID: 12
    }
  ]

  const [mutateOrderStatusID] = useMutation(UPDATE_ORDER_STATUS);
  const [ insertOrder ] = useMutation(INSERT_ORDER, {variables: {
    'orderStatusID': columns[0].orderStatusID,
  }})

  function insertOrderHandler (){
    insertOrder().then( (res) => {
        history.push(`/orders/${res.data.insert_erp_Orders.returning[0].OrderID}?edit=true`)
    })
  }

  const onSubscriptionData = (options) => {
    const data = options.subscriptionData.data.erp_Orders 
    // для dnd небходимо установить id в string
    data.map( el => {
      el.id = el.OrderID.toString()
      return el
    })
    columns.forEach(col => {
      dispatch({
        type: col.droppableId,
        payload: data.filter(order => order.OrderStatusID === col.orderStatusID)
      })
    })
  }

  useSubscription(SUBSCRIPTION_RECLAMATION_ORDERS, { onSubscriptionData});

  const onDragEnd = result => {
    const { source, destination } = result;
    // dropped outside the list
    if (!destination) {
        return;
    }

    if (source.droppableId === destination.droppableId) {
        const items = reorder(
            getState(source.droppableId),
            source.index,
            destination.index
        );

        dispatch({ type: source.droppableId, payload: items })
    } else {
      //отрабатывает при перемещинии элемента в другой столбик
        const {result, movedObj } = move(
            getState(source.droppableId),
            getState(destination.droppableId),
            source,
            destination
        );
        Object.entries(result).map( el => {
          if (el[0] === el[0]) dispatch({ type: el[0], payload: el[1] })
        } )
        mutateOrderStatusID({
          variables: {
            OrderID: movedObj.OrderID, 
            OrderStatusID: columns.find(col => col.droppableId === destination.droppableId).orderStatusID
          }
        })
    }
};

  function getOrderStatus(order){
    if (order.NeedAttention) return sass.needAttention
    if (order.AwaitingDispatch) return sass.awaitingDispatch
  }

  function getOrderUnit(order){
      if (order.OrderItems.length === 0) return <Link to={`/orders/${order.OrderID}`} className={sass.item} ><div>Нет содержимого</div></Link>

      else return (
      <Link to={`/orders/${order.OrderID}`} className={`${sass.item} ${getOrderStatus(order)}`}>
        <div className={sass.items}>
          {order.OrderItems.map(item => (
            <div key={item.OrderItemID} className={sass.orderItem}>
              {item.Name}
            </div>
          ))}
        </div>
        <div>{order.Entity}</div>
        <div>{order.City}</div>
      </Link>)
  }

  return(
    <div className={sass.reclatationLayout}>
       <div className='pageLayout__header'>
        <UilWrench className='pageLayout__icon'/>
        <div className="pageLayout__title">Рекламация</div>

        <div className='pageLayout__actions'>
          <Button variant='iconic' onClick={insertOrderHandler}>
            <UilPlus/>
          </Button>
          <Button variant='iconic'>
            <UilArchive/>
          </Button>
        </div>
      </div>


      <DragDropContext onDragEnd={onDragEnd}>
        <Box className={sass.columnWrapper}>

        {columns.map( e => (<div key={e.columnName} className={sass.reclColumn}>
          <Typography className={sass.heading}>{e.columnName}</Typography>
          <Droppable droppableId={e.droppableId} >
          {(provided, snapshot) => (
              <div
                  ref={provided.innerRef}
                  className={sass.draggableWrapper}>
                  {e.data.map((item, index) => (
                      <Draggable
                          key={item.id}
                          draggableId={item.id}
                          index={index}>
                          {(provided, snapshot) => (
                              <div
                                  ref={provided.innerRef}   
                                  {...provided.draggableProps}
                                  {...provided.dragHandleProps}
                                  style={getItemStyle(
                                      snapshot.isDragging,
                                      provided.draggableProps.style
                                  )}>
                                    {getOrderUnit(item)}
                              </div>
                          )}
                      </Draggable>
                  ))}
                  {provided.placeholder}
              </div>
          )}
          </Droppable>
        </div>))}
        
        </Box>
      </DragDropContext>
    </div>
  )
}
export default Reclamation