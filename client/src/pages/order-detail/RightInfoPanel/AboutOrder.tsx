import { TOrder } from 'src/types/global'
import { formatDateWithTime, formatOnlyDate } from 'src/utils/date_helper'
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

  return (
    <OrderInfoCard heading="О заказе">
      <table>
        <tbody>
          {columns.map(el => {
            if (!el.data || el.data === 'Invalid date') return null
            return (
              <tr key={`${el.heading} ${el.data}`}>
                <td>{el.heading}</td>
                <td>{el.data}</td>
              </tr>
            )
          })}
        </tbody>
      </table>
    </OrderInfoCard>
  )
}
