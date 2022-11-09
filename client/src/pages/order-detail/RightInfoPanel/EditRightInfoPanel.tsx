/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { FormControl, InputLabel, MenuItem, Select, TextField } from '@mui/material'
import moment from 'moment'
import React, { useEffect } from 'react'
import NumberFormat, { InputAttributes } from 'react-number-format'
import { TOrder, TUser } from 'src/types/global'
import { useInsertPaymentMutation, useUpdateOrderInfoMutation } from 'src/types/graphql-shema'
import { formatOnlyDate } from 'src/utils/Date'

enum FieldNames {
  InvoiceNumber = 'InvoiceNumber',
  ShippingDate = 'ShippingDate',
  OrderNumber = 'OrderNumber',
  ManagerID = 'ManagerID',
  Entity = 'Entity',
  City = 'City',
  TotalAmount = 'TotalAmount',
  PaidAmount = 'PaidAmount',
  Comment = 'Comment'
}

type FieldsValuesMap = {
  [key in FieldNames]: any
}

interface CustomProps {
  onChange: (event: { target: { name: string; value: string } }) => void
  name: string
}

interface IEditableInfoProps {
  data: TOrder
  refetch(): void
  users: TUser[]
}

let fields: Partial<FieldsValuesMap> = {}

const DateFormatCustom = React.forwardRef<NumberFormat<InputAttributes>, CustomProps>(
  function NumberFormatCustom(props, ref) {
    const { onChange, ...other } = props

    return (
      <NumberFormat
        {...other}
        getInputRef={ref}
        onValueChange={values => {
          onChange({
            target: {
              name: props.name,
              value: values.value
            }
          })
        }}
        format="##.##.##"
      />
    )
  }
)

const MoneyFormatCustom = React.forwardRef<NumberFormat<InputAttributes>, CustomProps>(
  function NumberFormatCustom(props, ref) {
    const { onChange, ...other } = props

    return (
      <NumberFormat
        {...other}
        getInputRef={ref}
        onValueChange={values => {
          onChange({
            target: {
              name: props.name,
              value: values.value
            }
          })
        }}
        prefix={'₽ '}
        thousandSeparator={true}
      />
    )
  }
)

export default function EditableInfo({ data, refetch, users }: IEditableInfoProps) {
  const addField = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) =>
    (fields[e.target.name as FieldNames] = e.target.value)

  const [updateOrderInfo] = useUpdateOrderInfoMutation()
  const [insertPayment] = useInsertPaymentMutation()

  async function saveChanges() {
    if (!Object.keys(fields).length) return
    try {
      await updateOrderInfo({
        variables: {
          OrderID: data.OrderID,
          fields
        }
      })

      if (fields.PaidAmount)
        insertPayment({
          variables: {
            Date: new Date(),
            OrderID: data.OrderID,
            PaidAmount: fields.PaidAmount
          }
        })

      refetch()
    } catch (error) {
      console.log(error)
    }
  }

  useEffect(() => {
    fields = {}
    return () => {
      saveChanges()
    }
  }, [])

  const styles = css`
    border-left: var(--border);
    height: 100%;
    display: flex;
    flex-flow: column;
    padding: 0 0.5rem;
  `

  return (
    <form css={styles}>
      <TextField
        label="План. отгрузка"
        name={FieldNames.ShippingDate}
        placeholder="dd.mm.yy"
        InputProps={{
          onChange: e => {
            e.target.value = moment(e.target.value, 'DD-MM-YY').format('YYYY-MM-DD')
            addField(e)
          },
          defaultValue: formatOnlyDate(data.ShippingDate),
          inputComponent: DateFormatCustom as any
        }}
      />

      <TextField
        label="Номер счета"
        type="number"
        name={FieldNames.InvoiceNumber}
        defaultValue={data.InvoiceNumber}
        onChange={addField}
      />

      <TextField
        label="Номер заказа"
        name={FieldNames.OrderNumber}
        defaultValue={data.OrderNumber}
        onChange={addField}
      />

      <FormControl>
        <InputLabel>Менеджер</InputLabel>
        <Select
          name={FieldNames.ManagerID}
          defaultValue={data.User?.UserID}
          onChange={e => {
            fields.ManagerID = parseInt(e.target.value.toString()) || null
          }}
          label="Менеджер"
        >
          <MenuItem value="">Никто</MenuItem>
          {users.map(each => (
            <MenuItem value={each.UserID} key={each.UserID}>
              {each.FirstName} {each.LastName}
            </MenuItem>
          ))}
        </Select>
      </FormControl>

      <TextField
        label="Контрагент"
        name={FieldNames.Entity}
        defaultValue={data.Entity}
        onChange={addField}
      />

      <TextField
        label="Город"
        name={FieldNames.City}
        defaultValue={data.City}
        onChange={addField}
      />

      <TextField
        label="Сумма заказа"
        name={FieldNames.TotalAmount}
        InputProps={{
          defaultValue: data.TotalAmount,
          onChange: addField,
          inputComponent: MoneyFormatCustom as any
        }}
      />

      <TextField
        label="Оплачено"
        name={FieldNames.PaidAmount}
        InputProps={{
          defaultValue: data.PaidAmount,
          onChange: addField,
          inputComponent: MoneyFormatCustom as any
        }}
      />

      <TextField
        label="Комментарий"
        multiline
        name={FieldNames.Comment}
        defaultValue={data.Comment}
        onChange={addField}
      />
    </form>
  )
}
