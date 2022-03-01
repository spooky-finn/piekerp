import { useReducer, useEffect, useState } from 'react'

//apollo 
import { useMutation } from "@apollo/client"
import { 
DELETE_ORDER_ITEM, 
INSERT_ORDER_ITEM, 
UPDATE_ORDER_ITEM, 
UPDATE_ORDER_ITEM_METADATA 
} from "./queries/MutationOrderItem";

// ui 
import { Button, TextField, Box, Typography, Dialog, DialogTitle, DialogContent, DialogActions } from '@mui/material';
import sass from './sass/composition.module.sass'
import OrderItemActions from './OrderItemActions'

const initialState = {
    name: '',
    fullName: '',
    quantity: '',
    id: null,
}

function reducer(state, action){
    switch(action.type){
        case 'name': 
        case 'fullName':
        case 'quantity':
            return {...state, [action.type]: action.payload };

        case 'reset':
            return initialState
        
        case 'editItem':
            return {
                id: action.payload[0],
                name: action.payload[1],
                fullName: action.payload[2],
                quantity: action.payload[3]
            }
        default: 
            return {...state}
    }

}

const OrderComposition = props => {
    const { data, editState, refetch, orderID, OIDialog, setOIDialog } = props
    const [ deleteOrderItemMutation ]         = useMutation(DELETE_ORDER_ITEM)
    const [ insertOrderItemMutation ]         = useMutation(INSERT_ORDER_ITEM);
    const [ updateOrderItemMutation ]         = useMutation(UPDATE_ORDER_ITEM);
    const [ updateOrderItemMetadataMutation ] = useMutation(UPDATE_ORDER_ITEM_METADATA);
    const [state, dispatch ] = useReducer(reducer, initialState)
    
    const deleteItemHandler = (itemID) => {
        deleteOrderItemMutation({ variables: { orderItemID: itemID} })
        refetch()    
    }
    const editItemHandler = (e, item) => {
        dispatch({ type: 'editItem', payload: [item.OrderItemID, item.Name, item.FullName, item.Quantity] })
    }

    const closeOIDialog = () => {
      setOIDialog(false);
    };

    useEffect(() => {
        if (!editState && state.name !== '' && state.quantity !== ''){
            insertOrderItem()
        }

    }, [editState]);

    const insertOrderItem = () => {
        closeOIDialog();
        if (state.quantity === '' || state.name === '') return null
        insertOrderItemMutation({variables: { 
            orderID,
            name: state.name, 
            quantity: parseInt(state.quantity),
            fullName: state.fullName, }}).then( 
                () => {
                    dispatch({ type: 'reset'})
                    refetch() 
                })    
    }

    const updateOrderItem = () => {
      if (state.quantity === '' || state.name === '') return null
      closeOIDialog();
      updateOrderItemMutation({variables: { 
        OrderItemID: state.id,
        Name: state.name, 
        Quantity: parseInt(state.quantity),
        FullName: state.fullName, }}).then( () => { dispatch({ type: 'reset'}); refetch() })    
  }
  
    return(<div className='Composition'>     
        {data.map( (el, index) => 
        <div
          key={el.OrderItemID}
          className={sass.Unit} 
        >
              <span className={sass.index}>{index+1}</span>
              <Typography color='textPrimary' className={sass.name}> {el.Name} </Typography>
              <span  className={sass.quantity}> {el.Quantity}</span>

              {editState && 
              <OrderItemActions
                  {...props}
                  item={el}
                  editItemHandler={editItemHandler}
                  deleteItemHandler={deleteItemHandler}
                  updateItem={updateOrderItemMetadataMutation}
               />
               }

              <div className={sass.fullName}> { el.FullName }</div>

        </div>
        )}
        
      <Dialog maxWidth='sm' fullWidth={true} open={OIDialog} onClose={closeOIDialog}>
        <DialogTitle>Добавить позицию</DialogTitle>
        <DialogContent>
        <Box className={sass.addOrderItem}>
          <TextField
            label="Наименование"
            value={state.name}
            variant='filled'
            sx={{mb: '8px'}}
            onChange={ (e) => dispatch({ type: 'name', payload: e.target.value }) }
            />
        <TextField
            label="Полное наименование"
            multiline
            variant='filled'
            sx={{mb: '8px'}}
            className={sass.fullNameInput}
            value={state.fullName}
            onChange= { (e) => dispatch({ type: 'fullName', payload: e.target.value }) }
            />
        <TextField
            label="Кол-во"
            type="number"
            variant='filled'
            sx={{mb: '8px'}}
            className={sass.quantityInput}
            value={state.quantity}
            onChange={ (e) => dispatch({ type: 'quantity', payload: e.target.value }) }
            />
        </Box>
        </DialogContent>
        <DialogActions sx={{ justifyContent: 'start'}} >
            {state.name && state.quantity && (!state.id 
            ? <Box><Button variant='contained' onClick={insertOrderItem}>Добавить</Button> </Box>
            : <Box><Button variant='contained' onClick={updateOrderItem}>Изменить</Button></Box> )}
              <Box  ><Button onClick={() => {
                  closeOIDialog();
                  dispatch({type: 'reset'});
              }}>Закрыть</Button></Box>
        </DialogActions>
      </Dialog>
    </div>)
}

export default OrderComposition