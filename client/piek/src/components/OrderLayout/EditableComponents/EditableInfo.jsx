import { useEffect } from 'react';
import {TextField} from '@material-ui/core';
import './EditableInfo.sass'

import { useMutation } from '@apollo/client';
import { UPDATE_ORDER_INFO } from '../queries/MutationOrderInfo'

let fields = {}

const EditableInfo = ({data, orderID, refetch}) => {  
    const addField = (e) => fields[e.target.name] = e.target.value
    const [updateOrderInfo] = useMutation(UPDATE_ORDER_INFO);
  
    useEffect(() => {
        return () => {
            updateOrderInfo({variables: {
            orderID,
            fields,
            }})
            refetch()
        };
    }, []);

  return(
    <form className="Meta EditableInfo">
        <TextField
          label="План. отгрузка"
          name='ShippingDate'
          defaultValue={data.ShippingDate}
          onChange={addField}
          placeholder="dd.mm.yy"
        />

        <TextField
          label="Номер счета"
          type="number"

          name='InvoiceNumber'
          defaultValue={data.InvoiceNumber}
          onChange={addField}
        />

        <TextField
          label="Номер заказа"
          type="number"

          name='OrderNumber'
          defaultValue={data.OrderNumber}
          onChange={addField}
        />

         <TextField
          label="Юр лицо"
          
          name='Entity'
          defaultValue={data.Entity}
          onChange={addField}
        />
        
        <TextField
          label="Город"

          name='City'
          defaultValue={data.City}
          onChange={addField}
        />

         <TextField
          label="Сумма заказа"
          type="number"

          name='TotalAmount'
          defaultValue={data.TotalAmount}
          onChange={addField}
        />
        
        <TextField
          label="Оплачено"
          type="number"

          name='PaidAmount'
          defaultValue={data.PaidAmount}
          onChange={addField}
        />

        <TextField
          label="Комментарий"
          multiline

          name='Comment'
          defaultValue={data.Comment}
          onChange={addField}
        />
    </form>
  )
}

export default EditableInfo