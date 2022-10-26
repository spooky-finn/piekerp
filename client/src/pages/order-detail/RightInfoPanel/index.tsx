/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { Box, Typography } from '@mui/material'
import { ReactNode } from 'react'
import { TOrder } from 'src/types/global'
import { formatOnlyDate } from 'src/utils/Date'
import { percentage } from 'src/utils/Formatting'
import AboutOrder from './AboutOrder'
import PaymnetHistory from './Payments'

interface IOrderInfoCardProps {
  heading: string
  children: ReactNode
}

export const OrderInfoCard = ({ heading, children }: IOrderInfoCardProps) => {
  const styles = css`
    margin: 15px 0;
    border-bottom: var(--border);
    border-top: var(--border);
    padding: 0.7rem 1rem;
    line-height: 1.5;
    .body {
      width: 100%;
      padding-top: 8px;
    }
  `
  return (
    <Box css={styles}>
      <Typography variant="subtitle2">{heading}</Typography>
      <div className="body">{children}</div>
    </Box>
  )
}

export default function OrderMeta({ data }: { data: TOrder }) {
  const styles = css`
    border-left: var(--border);
    height: 100%;

    .significantInfo {
      display: flex;
      flex-flow: row;
      gap: 20px 0;
      flex-wrap: wrap;
      margin: 0.7rem 1rem;
      div {
        width: 50%;
        font-weight: 600;
        font-size: 1.2rem;
        h5 {
          font-size: 0.9rem;
          margin: 5px 0;
          font-weight: normal;
        }
      }

      .OrderComment {
        border-top: var(--border);
        width: 100%;
        font-weight: normal;
        font-size: 1rem;
        line-height: 1.5;
      }
    }
  `
  return (
    <div css={styles}>
      <Box className="significantInfo">
        <div>
          <h5>План. отгрузка</h5>
          {data.ShippingDate && formatOnlyDate(data.ShippingDate)}
        </div>
        <div>
          <h5>Номер заказа</h5>
          {data.OrderNumber}
        </div>
        <div>
          <h5>Счет / оплата</h5>
          {'№ ' +
            (data.InvoiceNumber || '') +
            ' - ' +
            percentage(data.TotalAmount, data.PaidAmount)}
        </div>
      </Box>

      {data.Comment && <OrderInfoCard heading="Комментарий">{data.Comment}</OrderInfoCard>}
      <AboutOrder data={data} />
      <PaymnetHistory data={data} />
    </div>
  )
}
