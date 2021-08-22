import { useRef } from 'react'
import {TextField} from '@material-ui/core'
import { UilArrowUp } from '@iconscout/react-unicons'

import { useMutation } from "@apollo/client"
import { INSERT_ORDER_ITEM } from '../queries/MutationOrderItem'

const AddOrderItem = ({editState, orderID, refetch}) => {
    const [inserdOrderItem, { loading }] = useMutation(INSERT_ORDER_ITEM);

    const name = useRef(null)
    const quantity = useRef(null)


    const mutate = () => {
        if (quantity.current.value != ''){
            inserdOrderItem({variables: { orderID, name: name.current.value, quantity: quantity.current.value}}).then( () => refetch() )
        }
        
    
        name.current.value=null;
        quantity.current.value=null
    }

    const addOne = () => (
        <>
            <TextField
                className="Name"
                label="Наименование"
                autoComplete='off'
                inputRef={name}
              />
            <TextField
                className="Quantity"
                label="Кол-во"
                type="number"
                inputRef={quantity}
                autoComplete='off'
               />

        <div className="square-button push-order-item"
                onClick={mutate}><UilArrowUp/></div>
         </>
        )

    if (!editState) return null

    return(
        <div className="Unit addOrderItem">{addOne()}</div>
    )
}
export default AddOrderItem