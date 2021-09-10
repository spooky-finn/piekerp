import { DELETE_ORDER_ITEM, INSERT_ORDER_ITEM } from "./queries/MutationOrderItem"
import { useMutation } from "@apollo/client"

import { useReducer, useEffect } from 'react'
import {TextField} from '@material-ui/core'
import { UilArrowUp } from '@iconscout/react-unicons'


import { motion, AnimatePresence } from "framer-motion"

import sass from './sass/composition.module.sass'

const initialState = {
    name: '',
    fullName: '',
    quantity: '',
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
                name: action.payload[0],
                fullName: action.payload[1],
                quantity: action.payload[2]
            }
    }

}

const OrderComposition = ({ data, editState, refetch, orderID }) => {
    const [ deleteOrderItemMutation ] = useMutation(DELETE_ORDER_ITEM)
    const [ insertOrderItemMutation ] = useMutation(INSERT_ORDER_ITEM);

    const [state, dispatch ] = useReducer(reducer, initialState)

    const deleteItem = (itemID) => {
        deleteOrderItemMutation(
            { variables: { orderItemID: itemID} }
        )
        refetch()    
    }

    useEffect(() => {
        if (!editState && state.name !== '' && state.quantity !== ''){
            insertOrderItem()
        }

    }, [editState]);


    const editItem = (e, itemID) => {
        const itemData = data.find( el => el.OrderItemID == itemID)
        dispatch({ type: 'editItem', payload: [itemData.Name, itemData.FullName, itemData.Quantity] })
        console.log(e)
        deleteItem(itemID)
    }

    const insertOrderItem = () => {
        if (state.quantity == '' || state.name == '') return null

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

    const addNewOrderItem = () => (
        <>
            <TextField
                size='small' 
                label="Наименование"
                autoComplete='off'
                value={state.name}
                onChange={ (e) => dispatch({ type: 'name', payload: e.target.value }) }
              />
            <TextField
                size="small" 
                label="Кол-во"
                type="number"
                autoComplete='off'
                className={sass.quantityInput}
                value={state.quantity}
                onChange={ (e) => dispatch({ type: 'quantity', payload: e.target.value }) }

               />
           
           <TextField
                label="Полное наименование"
                multiline
                autoComplete="off"
                size='small'
                className={sass.fullNameInput}
                value={state.fullName}
                onChange= { (e) => dispatch({ type: 'fullName', payload: e.target.value }) }
                />

            <motion.button
                whileHover={{ scale: 1.1 }}
                whileTap={{ scale: .95 }}
                className={`square-button ${sass.pushOrderItemButton}`}
                onClick={insertOrderItem} >
                    <UilArrowUp/>
            </motion.button>
           
         </>
        )

    return(<>     
     <AnimatePresence>
            {data.map( el => 
            
            <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            key={el.OrderItemID} >
            

                <div key={el.OrderItemID} className={sass.Unit}>
                    <div className={sass.firstRow}>
                        <div className={sass.name}> {el.Name} </div>
                        <span  className={sass.quantity}> {el.Quantity}</span>
                    </div>
                    
                    <div  className={sass.fullName}> { el.FullName }</div>


                    {editState &&  
                        <div className={sass.orderItemActions}>
                            <a onClick={ (e) => editItem(e, el.OrderItemID) }>   Изменить</a>
                            <a onClick={ ()=> deleteItem(el.OrderItemID) } > Удалить </a>
                        </div>
                    }
                   

                </div>

            </motion.div>
            )}
            
        {editState && <div className={sass.addOrderItem}>{addNewOrderItem()}</div> }

    </AnimatePresence>
    </>)
}

export default OrderComposition