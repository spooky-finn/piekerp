/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { TOrder } from 'src/types/global'
import { formatDateWithTime, formatOnlyDate } from 'src/utils/date'
import { OrderInfoCard } from '.'

export interface IAboutOrderProps {
  data: TOrder
}

export default function AboutOrder({ data }: IAboutOrderProps) {
  const columns = [
    {
      heading: 'Менеджер',
      data: data.User && `${data.User.FirstName} ${data.User.LastName}`
    },
    {
      heading: 'Создан',
      data: formatOnlyDate(data.CreatingDate)
    },
    {
      heading: 'В очередности',
      data: formatOnlyDate(data.AcceptanceDate)
    },
    {
      heading: 'Факт. отгрузка',
      data: formatOnlyDate(data.ActualShippingDate)
    },
    {
      heading: 'Проблемки с',
      data: formatDateWithTime(data.NeedAttention?.split(',')[1]!)
    }
  ]

  const styles = css`
    display: flex;
    flex-direction: 'row';
    gap: 10px;
    span:first-child {
      color: var(--lowContrast);
    }
  `
  return (
    <OrderInfoCard heading="О заказе">
      {columns.map(el => {
        if (!el.data || el.data === 'Invalid date') return null
        return (
          <div key={el.heading} css={styles}>
            <span>{el.heading}</span>
            <span>{el.data}</span>
          </div>
        )
      })}
    </OrderInfoCard>
  )
}
