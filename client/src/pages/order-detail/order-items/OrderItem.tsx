/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { Typography } from '@mui/material'
import { ReactNode } from 'react'
import { TOrderItem } from 'src/types/global'

export interface IOrderItemProps {
  sequence_number: number
  orderItem: TOrderItem
  children: ReactNode
}

export default function OrderItem({ sequence_number, orderItem, children }: IOrderItemProps) {
  const styles = css`
    position: relative;
    padding: 1.3em;
    display: grid;
    grid-template-columns: 15fr 1fr auto;

    .name,
    .quantity {
      font-family: 'IBM Plex Mono' !important;
      font-size: 1.2rem;
    }

    .quantity {
      color: var(--accent);
      min-width: max-content;
    }

    .fullName {
      grid-column-start: 1;
      grid-column-end: 3;
      color: var(--lowContrast) !important;
      font-weight: normal;
      padding-top: 5px;
    }
  `

  return (
    <div key={orderItem.OrderItemID} css={styles}>
      <Typography className="name">{orderItem.Name}</Typography>
      <span className="quantity"> {orderItem.Quantity} шт.</span>

      {children}

      <div className="fullName"> {orderItem.FullName}</div>
    </div>
  )
}
