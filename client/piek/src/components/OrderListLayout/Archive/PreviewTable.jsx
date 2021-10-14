//apollo 
import { useQuery } from '@apollo/client'
import { GET_ALL_ORDERS_AMOUNT } from './queries/getAllOrdersAmount'
import { GET_ARCHIVED_LATEST_ORDERS } from './queries/getArchivedLatestOrders'
import { GET_ARCHIVED_UNPAID_ORDERS } from './queries/getArchivedUnpaidOrders'

import Table from './TableMarkup'
import sass from './archive.module.sass'
import { Pane, Spinner } from 'evergreen-ui'


const PreviewTable = (props) => {
  const { state, dispatch, columns } = props

  const { data : latestOrders = [], loading: latestOrdersloading } = useQuery(GET_ARCHIVED_LATEST_ORDERS, {variables:{ limit: 10 }});

  const { loading } = useQuery(GET_ALL_ORDERS_AMOUNT, { onCompleted: (res) => {
    dispatch({ type: 'unpaidIDs', payload: res.erp_Orders.filter(e => e.PaidAmount / e.TotalAmount < .999).map(e => e.OrderID)})
  }})

  const { data : unpaidOrders = [], loading: unpaidOrdersLoading } = useQuery(GET_ARCHIVED_UNPAID_ORDERS, { variables: {unpaidIDs: state.unpaidIDs } })

  const previewData = () => {
    if (!unpaidOrders.erp_Orders || !latestOrders.erp_Orders) return []
    return ([
      ...unpaidOrders.erp_Orders.map(e => ({...e, unpaid: true})),
      // проверяем есть ли в последних заказах неоплаченный, если есть, то убираем из их заказ из latestOrders
      ...latestOrders.erp_Orders
      .filter(e => !state.unpaidIDs.includes(e.OrderID))
      .sort(function(a,b){
        return new Date(b.ActualShippingDate) - new Date(a.ActualShippingDate);
      })
      ])
  }

  if (latestOrdersloading || unpaidOrdersLoading || loading) return( 
  <Pane display="flex" alignItems="center" justifyContent="center" height={400}>
    <Spinner />
  </Pane>)

  return (<>
      <p className={sass.previewHeading}>Недавно отгруженные</p>
      <Table columns = {columns} data = {previewData()} className={sass.archiveTable}/>
  </>)
}
export default PreviewTable