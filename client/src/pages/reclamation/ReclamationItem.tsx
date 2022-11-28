/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { Link } from 'react-router-dom'
import { AppRoutes } from 'src/routers/Router'
import { TReclamationOrder } from 'src/types/global'
import { orderStatusHighlighting } from 'src/utils/orderColorIndication'

export interface IReclamationItemProps {
  order: TReclamationOrder
}

export default function ReclamationItem({ order }: IReclamationItemProps) {
  const styles = css`
    display: grid;

    grid-template-columns: 4fr 1fr;
    align-items: center;
    position: relative;
    border-bottom: 1px solid var(--border-color);
    padding: 30px 10px;
    grid-gap: 13px;

    &:hover {
      background: var(--L2);
    }

    .orderItem {
      font-family: 'IBM Plex Mono';
      color: var(--highContrast);
      flex-grow: 1;
      font-size: 1.1rem;
    }

    .customerInfo {
      flex-shrink: 4;
      div:first-of-type {
        font-size: 0.9rem;
        color: var(--highContrast);
        font-weight: 600;
      }
    }
    div {
      color: var(--lowContrast);
    }

    &.needAttention::before,
    &.awaitingDispatch::before {
      content: '';
      position: absolute;
      bottom: 0;
      top: 0;
      left: 0;
      background: var(--needAttention);
      height: 100%;
      width: 3px;
    }

    &.awaitingDispatch::before {
      background: var(--awaitingDispatch);
    }
  `

  return (
    <Link
      to={AppRoutes.order_detail + order.OrderID}
      css={styles}
      className={orderStatusHighlighting(order)}
    >
      <div>
        {order.OrderItems.length ? (
          order.OrderItems.map(item => (
            <div key={item.OrderItemID} className="orderItem">
              {item.Name}
            </div>
          ))
        ) : (
          <div>Не заполнено</div>
        )}
      </div>

      <div className="customerInfo">
        <div>{order.Entity}</div>
        <div>{order.City}</div>
      </div>
    </Link>
  )
}
