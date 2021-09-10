import { useEffect } from 'react';
import {TextField} from '@material-ui/core';
import Autocomplete from '@material-ui/lab/Autocomplete';
import './EditableInfo.sass'

import { useMutation, useQuery } from '@apollo/client';
import { UPDATE_ORDER_INFO } from '../queries/MutationOrderInfo'
import { GET_USERS } from '../../../hasura-queries/getUsers';

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
  const { data: users = []} = useQuery(GET_USERS);
  
  console.log(users.erp_Users)

    const top100Films = [
      { title: 'The Shawshank Redemption', year: 1994 },
      { title: 'The Godfather', year: 1972 },
      { title: 'The Godfather: Part II', year: 1974 },
      { title: 'The Dark Knight', year: 2008 },
      { title: 'Dangal', year: 2016 },
      { title: 'The Sting', year: 1973 },
      { title: '2001: A Space Odyssey', year: 1968 },
      { title: "Singin' in the Rain", year: 1952 },
      { title: 'Toy Story', year: 1995 },
      { title: 'Bicycle Thieves', year: 1948 },
      { title: 'The Kid', year: 1921 },
      { title: 'Inglourious Basterds', year: 2009 },
      { title: 'Snatch', year: 2000 },
      { title: '3 Idiots', year: 2009 },
      { title: 'Monty Python and the Holy Grail', year: 1975 },
    ];

    const addField = (e) => fields[e.target.name] = e.target.value
    const [updateOrderInfo] = useMutation(UPDATE_ORDER_INFO);
  
    useEffect(() => {
        fields = {};
        
        return () => {
            console.log('doing mutation for order', orderID, fields)
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

        <Autocomplete
          id="combo-box-demo"
          options={users.erp_Users}
          getOptionLabel={(option) => `${option.FirstName} ${option.LastName}`}
          renderInput={(params) => <TextField {...params} label="Менеджер"  />}
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