import moment  from 'moment'
import { useEffect } from 'react';
import { useMutation } from '@apollo/client';

import NumberFormat from 'react-number-format';
import { TextField, Autocomplete } from '@mui/material';

import { UPDATE_ORDER_INFO } from '../queries/MutationOrderInfo'
import { INSERT_PAYMENT } from '../queries/MutationPaymentHistory'

import { notif } from '../../../utils/notification'
import './EditRightInfoPanel.sass'

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

const EditableInfo = ({ data, orderID, refetch, users }) => {  
  
    const addField = (e) => fields[e.target.name] = e.target.value
    const [updateOrderInfo] = useMutation(UPDATE_ORDER_INFO);
    const [insertPayment] = useMutation(INSERT_PAYMENT)
  
    async function saveChanges(){
        if (!Object.keys(fields).length) return;

        try {
            const res = await updateOrderInfo({variables: {
                OrderID: orderID,
                fields,
            }})
            
            if (res.data)
                notif('info', 'Заказ поправлен')

            if (fields.PaidAmount) insertPayment({ variables: {
                Date: new Date(),
                OrderID: orderID,
                PaidAmount: fields.PaidAmount
                }})
            
            refetch()
        } catch (error) {
            console.log(error);
            notif('danger', 'Что-то пошло не так...', JSON.stringify(error), 0)
        }
    }

    useEffect(() => {
        fields = {};
        return () => {
            saveChanges()
        };
    }, []);

    function findSelectedManeger(users, managerID){
        if (!users) return null
        const index = users.indexOf(users.find(user => user.UserID === managerID))
        return users[index]
    }

  return(
    <form className="EditableInfo">  
      <div className="wrap">
       <TextField
          label="План. отгрузка"
          name='ShippingDate'
          defaultValue={moment(data.ShippingDate).format('DD.MM.YY')}
          onChange={(e) => {
            e.target.value = moment(e.target.value, "DD-MM-YY").format('YYYY-MM-DD')
            if (e.target.value === 'Invalid date') e.target.value=null
            addField(e)
          }}
          placeholder="dd.mm.yy"
          InputProps={{
            inputComponent: DateFormatCustom,
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
          name='OrderNumber'
          defaultValue={data.OrderNumber}
          onChange={addField}
        />

        <Autocomplete
          id="combo-box-demo"
          options={users.filter( (user) => user.AccessLevelID != 3)}
          getOptionLabel={(option) => `${option.FirstName} ${option.LastName}`}
          renderInput={(params) => <TextField {...params} label="Менеджер"/>}
          defaultValue={() => findSelectedManeger(users, data.ManagerID)}
          onChange={(event, newValue) => {
            fields['ManagerID'] = (newValue?.UserID || null)
          }}
        />

         <TextField
          label="Контрагент"
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
          name='TotalAmount'
          defaultValue={data.TotalAmount}
          onChange={addField}
          InputProps={{
            inputComponent: MoneyFormatCustom,
          }}
          />
        
        <TextField
          label="Оплачено"
          name='PaidAmount'
          defaultValue={data.PaidAmount}
          onChange={addField}
          InputProps={{
            inputComponent: MoneyFormatCustom,
          }}
        />

        <TextField
          label="Комментарий"
          multiline
          InputProps={{
            sx: {fontSize: '.9rem !important'}
          }}
          name='Comment'
          defaultValue={data.Comment}
          onChange={addField}
        />
       </div>
    </form>
  )
}

export default EditableInfo