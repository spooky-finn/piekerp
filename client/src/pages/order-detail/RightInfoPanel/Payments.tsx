import { TOrder } from 'src/types/global'
import { formatOnlyDate } from 'src/utils/date_helper'
import { OrderInfoCard } from '.'

export interface IPaymnetHistoryProps {
  data: TOrder
}

export default function PaymnetHistory({ data }: IPaymnetHistoryProps) {
  if (data.PaymentHistories.length === 0 || !data.PaidAmount || !data.TotalAmount) return null

  return (
    <OrderInfoCard heading="Платежи">
      <table className="paidVisualization">
        <tbody>
          {data.PaymentHistories.map(e => (
            <tr key={e.Date}>
              <td>{((e.PaidAmount / data.TotalAmount) * 100).toFixed(0)} % </td>
              <td>{formatOnlyDate(e.Date)}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </OrderInfoCard>
  )
}
