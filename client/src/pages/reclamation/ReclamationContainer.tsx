import { UilWrench } from '@iconscout/react-unicons'
import { useNavigate } from 'react-router-dom'
import { AppRoutes } from 'src/routers/Router'
import { OrderStatus, TReclamationOrder } from 'src/types/global'
import { useGetReclamationOrdersQuery, useInsertOrderMutation } from 'src/types/graphql-shema'
import CreateRecordButton from '../../components/CreateRecordButton'
import Reclamation from './Reclamation'

export default function ReclamationContainer() {
  const navigate = useNavigate()

  const [insertOrder] = useInsertOrderMutation({
    variables: {
      orderStatusID: OrderStatus.reclInbox
    }
  })

  async function handleAddOrder() {
    const res = await insertOrder()
    const id = res.data?.insert_erp_Orders?.returning[0].OrderID
    navigate(AppRoutes.order_detail + id + ' ?edit=true')
  }

  const { data, loading } = useGetReclamationOrdersQuery({ fetchPolicy: 'cache-and-network' })

  const filterByStatus = (array: TReclamationOrder[], status: OrderStatus) => {
    if (!array) return []
    return array.filter(each => each.OrderStatusID === status)
  }

  return (
    <>
      <div className="pageLayout__header">
        <UilWrench className="pageLayout__icon" />
        <div className="pageLayout__title">Рекламация</div>

        <div className="pageLayout__actions">
          <CreateRecordButton onClick={handleAddOrder} />
        </div>
      </div>

      {!loading && (
        <Reclamation
          inbox={filterByStatus(data?.erp_Orders || [], OrderStatus.reclInbox)}
          decision={filterByStatus(data?.erp_Orders || [], OrderStatus.reclDecision)}
          inproduction={filterByStatus(data?.erp_Orders || [], OrderStatus.reclProduction)}
        />
      )}
    </>
  )
}
