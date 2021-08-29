import { useEffect } from 'react';
import {TextField} from '@material-ui/core';
import './EditableInfo.sass'

import { useMutation } from '@apollo/client';
import { UPDATE_ORDER_INFO } from '../queries/MutationOrderInfo'

import NumberFormat from 'react-number-format';
import moment  from 'moment'

let fields = {}


function DateFormatCustom(props) {
  const { inputRef, onChange, ...other } = props;

  return (
    <NumberFormat
      {...other}
      getInputRef={inputRef}
      onValueChange={values => {
        onChange({
          target: {
            name: props.name,
            value: values.value
          }
        });
      }}
      format='##.##.##'
    />
  );
}

function MoneyFormatCustom(props) {
  const { inputRef, onChange, ...other } = props;

  return (
    <NumberFormat
      {...other}
      getInputRef={inputRef}
      onValueChange={values => {
        onChange({
          target: {
            name: props.name,
            value: values.value
          }
        });
      }}
      prefix={'₽ '}
      thousandSeparator={true}
    />
  );
}

const EditableInfo = ({ data, orderID, refetch }) => {  

    const addField = (e) => fields[e.target.name] = e.target.value
    const [updateOrderInfo] = useMutation(UPDATE_ORDER_INFO);
  
    console.log(moment(data.ShippingDate).format('DD.MM.YY'))
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
          defaultValue={moment(data.ShippingDate).format('DD.MM.YY')}
          onChange={(e) => {
            e.target.value = moment(e.target.value, "DD-MM-YY").format('YYYY-MM-DD')
            addField(e)
          }}
          placeholder="dd.mm.yy"
          autoComplete="off"
          InputProps={{
            inputComponent: DateFormatCustom
          }}
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
          autoComplete="off"
          name='Entity'
          defaultValue={data.Entity}
          onChange={addField}
        />
        
        <TextField
          label="Город"
          autoComplete="off"
          name='City'
          defaultValue={data.City}
          onChange={addField}
        />

         <TextField
          label="Сумма заказа"
          name='TotalAmount'
          defaultValue={data.TotalAmount}
          autoComplete="off"
          onChange={addField}
          InputProps={{
            inputComponent: MoneyFormatCustom
          }}
          />
        
        <TextField
          label="Оплачено"
          name='PaidAmount'
          defaultValue={data.PaidAmount}
          autoComplete="off"
          onChange={addField}
          InputProps={{
            inputComponent: MoneyFormatCustom
          }}
        />

        <TextField
          label="Комментарий"
          multiline
          autoComplete="off"
          name='Comment'
          defaultValue={data.Comment}
          onChange={addField}
        />
    </form>
  )
}

export default EditableInfo