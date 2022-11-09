import { Link } from 'react-router-dom'
import { Column, useTable } from 'react-table'
import styles from './table.module.sass'
import moment from 'moment'
import { AppRoutes } from 'src/routers/Router'
import { percentage } from 'src/utils/Formatting'
import { TOrderColumnData } from 'src/types/global'

function statusHighlighting(order: TOrderColumnData) {
  // if (showUnpaid && order.unpaid) return styles.unpaidOrder

  // Выделение заказов требующих внимания имеют приоритет
  if (order.NeedAttention?.split(',')[0] === 'true') return styles.needAttention
  else if (order.AwaitingDispatch) return styles.awaitingDispatch
  else return ''
}

type TableProps = {
  columns: any
  data: any[]
  className?: string
  showUnpaid?: boolean
}

export function Table({ columns, data, className, showUnpaid }: TableProps) {
  const { getTableProps, getTableBodyProps, headerGroups, rows, prepareRow } = useTable({
    columns,
    data
  })

  if (data.length === 0) return null
  return (
    <div className={`${styles.tableMain} ${className} ${styles.table}`} {...getTableProps()}>
      <div className={styles.thead}>
        {headerGroups.map((headerGroup, i) => (
          <div className={styles.tr} {...headerGroup.getHeaderGroupProps()}>
            {headerGroup.headers.map((column, i) => (
              <div className={styles.th} {...column.getHeaderProps()}>
                {column.render('Header')}
              </div>
            ))}
          </div>
        ))}
      </div>
      <div {...getTableBodyProps()} className={styles.tbody}>
        {rows.map((row, i) => {
          prepareRow(row)

          const { OrderID } = row.original
          return (
            <Link
              to={AppRoutes.order_detail + OrderID}
              className={`${statusHighlighting(row.original)} ${styles.tableRow}`}
              {...row.getRowProps()}
            >
              {row.cells.map((cell, i) => {
                return (
                  <div className={styles.td} {...cell.getCellProps()}>
                    {cell.render('Cell')}
                  </div>
                )
              })}
            </Link>
          )
        })}
      </div>
    </div>
  )
}

export const columnsList: Column<TOrderColumnData>[] = [
  {
    Header: '',
    id: 'index',
    accessor: (_row, counter) => counter + 1
  },
  {
    Header: 'Наим.',
    id: 'orderItems',
    accessor: data => {
      if (data.OrderItems.length === 0)
        return (
          <Link to={`/orders/${data.OrderID}`}>
            <div>Нет содержимого</div>
          </Link>
        )
      else
        return (
          <>
            {data.OrderItems.map(item => (
              <div key={item.OrderItemID}>
                <span>{item.Name}</span>
              </div>
            ))}
          </>
        )
    }
  },
  {
    Header: 'Кол-во',
    accessor: data =>
      data.OrderItems.map(item => (
        <div key={item.OrderItemID}>
          <div>{item.Quantity}</div>
        </div>
      ))
  },
  {
    Header: 'План. отгрузка',
    accessor: order => <> {order.ShippingDate && moment(order.ShippingDate).format('DD.MM.YY')} </>
  },
  {
    Header: 'Компания / город',
    accessor: data => (
      <div>
        <div>
          <b>{data.Entity}</b>
        </div>
        <>{data.City}</>
      </div>
    )
  },
  {
    Header: 'Счет',
    accessor: 'InvoiceNumber'
  },
  {
    Header: 'Оплата',
    accessor: data => percentage(data.TotalAmount, data.PaidAmount)
  },
  {
    Header: 'Менеджер',
    accessor: data => <> {data.User?.FirstName ? data.User?.FirstName : ''} </>
  }
]
