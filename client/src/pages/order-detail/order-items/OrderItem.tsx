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
    grid-template-columns: 0.3fr 15fr 1fr auto;

    .index {
      color: var(--lowContrast);
      display: flex;
      align-self: center;
      padding-right: 10px;
    }
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
      grid-column-start: 2;
      grid-column-end: 4;
      color: var(--lowContrast) !important;
      font-weight: normal;
      padding-top: 5px;
    }
  `

  return (
    <div key={orderItem.OrderItemID} css={styles}>
      <span className="index">{sequence_number}</span>
      <Typography className="name">{orderItem.Name}</Typography>
      <span className="quantity"> {orderItem.Quantity} шт.</span>

      {children}

      <div className="fullName"> {orderItem.FullName}</div>
    </div>
  )
}
