import { useReducer, useEffect } from 'react'

//apollo 
import { useMutation } from "@apollo/client"
import { 
DELETE_ORDER_ITEM, 
INSERT_ORDER_ITEM, 
UPDATE_ORDER_ITEM, 
UPDATE_ORDER_ITEM_METADATA 
} from "./queries/MutationOrderItem"

// ui 
import { TextField, Button } from '@material-ui/core'
import { withStyles } from '@material-ui/core/styles';

import sass from './sass/composition.module.sass'

import OrderItemActions from './OrderItemActions'


const Input = withStyles({
  root: {
  }
})((props) => 
  <TextField 
    size='small' 
    autoComplete='off'
    InputProps={{ disableUnderline: true }}
    {...props} 
  />);

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

const OrderComposition = ({ data, editState, refetch, orderID }) => {
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

        // deleteItem(item.OrderItemID)
    }

    useEffect(() => {
        if (!editState && state.name !== '' && state.quantity !== ''){
            insertOrderItem()
        }

    }, [editState]);

    const insertOrderItem = () => {
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
      updateOrderItemMutation({variables: { 
          OrderItemID: state.id,
          Name: state.name, 
          Quantity: parseInt(state.quantity),
          FullName: state.fullName, }}).then( () => { dispatch({ type: 'reset'}); refetch() })    
  }
  
    const addItemForm = () => {
      if (!editState) return null
      return(
        <div className={sass.addOrderItem}>
            <Input
                label="Наименование"
                value={state.name}
                onChange={ (e) => dispatch({ type: 'name', payload: e.target.value }) }
              />
           <Input
                label="Полное наименование"
                multiline
                className={sass.fullNameInput}
                value={state.fullName}
                onChange= { (e) => dispatch({ type: 'fullName', payload: e.target.value }) }
                />
            <Input
                label="Кол-во"
                type="number"
                className={sass.quantityInput}
                value={state.quantity}
                onChange={ (e) => dispatch({ type: 'quantity', payload: e.target.value }) }
               />

              {!state.id 
              ? <Button className={sass.pushOrderItemButton} onClick={insertOrderItem}>Добавить</Button> 
              : <Button className={sass.pushOrderItemButton} onClick={updateOrderItem}>Изменить</Button> }
        </div>
        )
      }

    return(<>     
        {data.map( (el, index) => 
        
        <div
          key={el.OrderItemID}
          className={sass.Unit} 
        >
              <span className={sass.index}>{index+1}</span>
              <div className={sass.name}> {el.Name} </div>
              <span  className={sass.quantity}> {el.Quantity}</span>
              <OrderItemActions 
                  editState={editState} 
                  item={el}
                  editItemHandler={editItemHandler}
                  deleteItemHandler={deleteItemHandler}
                  updateItem={updateOrderItemMetadataMutation}
              />

              <div  className={sass.fullName}> { el.FullName }</div>

        </div>
        )}
        
      {addItemForm()}
    </>)
}

export default OrderComposition