/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { Box, Button, Stack, TextField, Typography } from '@mui/material'
import Popover from '@mui/material/Popover'
import moment from 'moment'
import * as React from 'react'
import { useAppContext } from 'src/hooks/useAppContext'
import { TOrder, UserStatus } from 'src/types/global'
import {
  useDeletePaymentMutation,
  useGetOrderPaymentsQuery,
  useInsertPaymentMutation
} from 'src/types/graphql-shema'
import { formatOnlyDate } from 'src/utils/date'
import { OrderInfoCard } from '.'
import { DateFormatCustom, MoneyFormatCustom } from './CutomFormattedInputs'
import * as formatter from 'src/utils/formatting'

type Order = Pick<TOrder, 'TotalAmount' | 'OrderID'>

export interface IPaymnetHistoryProps {
  data: Order
}

export const NO_TOTAL_AMOUNT_MESSAGE = 'Не задана сумма заказа'

export default function PaymnetHistory({ data }: IPaymnetHistoryProps) {
  const [deletePayment] = useDeletePaymentMutation()
  // const  = useGetOrderPaymentsLazyQuery({ variables: { _eq: data.OrderID } })
  const { data: payments, refetch } = useGetOrderPaymentsQuery({ variables: { _eq: data.OrderID } })
  const { store }: any = useAppContext()

  async function handleDelete(ID: number) {
    await deletePayment({
      variables: {
        ID
      }
    })

    refetch()
  }

  const isHaveFullRight = [
    UserStatus.general,
    UserStatus.management,
    UserStatus.bookkeeping
  ].includes(store?.user?.AccessLevelID)

  return (
    <OrderInfoCard heading="История оплаты">
      {data.TotalAmount ? (
        <Stack direction="column" width="100%">
          {payments?.erp_PaymentHistory.map(payment => (
            <Box
              width="100%"
              display="flex"
              flexDirection="row"
              css={css({
                '&:hover': {
                  '.editPayment': {
                    opacity: 1
                  }
                }
              })}
              key={payment.Date + payment.PaidAmount}
            >
              <Box width="25%">{formatter.percentage(payment.PaidAmount, data.TotalAmount)}</Box>
              <div>{formatOnlyDate(payment.Date)}</div>
              {isHaveFullRight && (
                <Button
                  variant="outlined"
                  size="small"
                  className="editPayment"
                  color="error"
                  css={css({
                    opacity: 0,
                    cursor: 'pointer',
                    marginLeft: '20px'
                  })}
                  onClick={() => handleDelete(payment.ID)}
                >
                  Удалить
                </Button>
              )}
            </Box>
          ))}
        </Stack>
      ) : (
        <Typography variant="body1">{NO_TOTAL_AMOUNT_MESSAGE}</Typography>
      )}
      {isHaveFullRight && (
        <AddNewPayment
          order={data}
          refetch={refetch}
          defaultValues={{ date: new Date().toISOString() }}
        />
      )}
    </OrderInfoCard>
  )
}

interface AddNewPaymentProps {
  defaultValues: {
    date?: string | null
    amount?: number
  }
  refetch(): void
  order: Order
}

function AddNewPayment(props: AddNewPaymentProps) {
  const [anchorEl, setAnchorEl] = React.useState<HTMLButtonElement | null>(null)
  const [insertPayment] = useInsertPaymentMutation()
  const [data, setData] = React.useState<{
    date?: string | null
    amount?: number
  }>(props.defaultValues)

  const handleClick = (event: React.MouseEvent<HTMLButtonElement>) => {
    setAnchorEl(event.currentTarget)
  }

  const handleClose = () => {
    setAnchorEl(null)
  }

  const open = Boolean(anchorEl)
  const id = open ? 'simple-popover' : undefined

  async function handleSave() {
    if (!data.date || !data.amount) {
      throw Error('data is not valid')
    }
    await insertPayment({
      variables: {
        Date: moment(data.date).toISOString(),
        OrderID: props.order.OrderID,
        PaidAmount: data.amount
      }
    })

    handleClose()
    props.refetch()
  }

  function handleDateChange(e: React.ChangeEvent<HTMLInputElement>) {
    setData({ ...data, date: moment(e.target.value, 'DDMMYY').toISOString() })
  }

  function handleAmountChange(e: React.ChangeEvent<HTMLInputElement>) {
    setData({ ...data, amount: parseInt(e.target.value) })
  }

  return (
    <>
      <Box mt={1}>
        <Button onClick={handleClick} variant="contained">
          Добавить
        </Button>
      </Box>
      <Popover
        id={id}
        open={open}
        anchorEl={anchorEl}
        onClose={handleClose}
        onKeyDown={e => {
          if (e.key === 'Enter') {
            handleSave()
          }
        }}
        anchorOrigin={{
          vertical: 'top',
          horizontal: 'left'
        }}
      >
        <Stack margin={1}>
          <TextField
            label="Дата"
            placeholder="dd.mm.yy"
            InputProps={{
              onChange: handleDateChange,
              defaultValue: moment(props.defaultValues?.date).format('DD.MM.YY'),
              inputComponent: DateFormatCustom as any
            }}
          />
          <Box display={'flex'} alignItems={'center'} gap={1}>
            <TextField
              label="Уже оплачено"
              autoFocus
              InputProps={{
                defaultValue: props.defaultValues?.amount,
                onChange: handleAmountChange,
                inputComponent: MoneyFormatCustom as any
              }}
            />
            <Typography variant="body2" color="textSecondary">
              из {formatter.money(props.order.TotalAmount)}
            </Typography>
          </Box>
          <Button onClick={handleSave}>Сохранить</Button>
        </Stack>
      </Popover>
    </>
  )
}
