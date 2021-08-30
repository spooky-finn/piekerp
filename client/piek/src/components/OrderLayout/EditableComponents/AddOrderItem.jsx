import { useRef } from 'react'
import {TextField} from '@material-ui/core'
import { UilArrowUp } from '@iconscout/react-unicons'

import { useMutation } from "@apollo/client"
import { INSERT_ORDER_ITEM } from '../queries/MutationOrderItem'

const AddOrderItem = ({editState, orderID, refetch}) => {
    const [inserdOrderItem, { loading }] = useMutation(INSERT_ORDER_ITEM);

    const name = useRef(null)
    const quantity = useRef(null)
    const fullName = useRef(null)


    const mutate = () => {
        if (quantity.current.value != ''){
            inserdOrderItem({variables: { 
                orderID, name: name.current.value, 
                quantity: quantity.current.value,
                fullName: fullName.current.value, }}).then( () => refetch() )
        }
        
    
        name.current.value=null;
        quantity.current.value=null
        fullName.current.value=null
    }

    const addOne = () => (
        <>
            <TextField
                size="small" 
                className="name"
                label="Наименование"
                autoComplete='off'
                inputRef={name}
                // InputProps={{ disableUnderline: true }}
              />
            <TextField
                size="small" 
                className="quantity"
                label="Кол-во"
                type="number"
                inputRef={quantity}
                autoComplete='off'
                // InputProps={{ disableUnderline: true }}

               />
           

           <TextField
                label="Полное наименование"
                className="fullName"
                multiline
                autoComplete="off"
                name='Comment'
                // InputProps={{ disableUnderline: true }}
                inputRef={fullName}
                />

            <div className="square-button push-order-item"
                onClick={mutate}><UilArrowUp/>
            </div>

               

         </>
        )

    if (!editState) return null

    return(
        <div className="addOrderItem">{addOne()}</div>
    )
}
export default AddOrderItem