import {
  UilFileCheck,
  UilLock,
  UilPlus,
  UilTrashAlt,
  UilTruck,
  UilUnlock
} from '@iconscout/react-unicons'
import { Box, Button } from '@mui/material'
import { useHistory } from 'react-router-dom'
import useAppContext from 'src/hooks/useAppContext'
import { useOrderDetailStore } from 'src/hooks/useOrderDetailStore'
import { OrderStatus, UserStatus } from 'src/types/global'
import {
  useDeleteOrderMutation,
  useMoveOrderToArchiveMutation,
  useMoveOrderToPriorityMutation
} from 'src/types/graphql-shema'

import { notif } from '../../../../utils/notification'
import DeleteOrderDialog from '../../dialogs/DeleteOrderDialog'
import TransferOrderDialog from '../../dialogs/TransferOrderDialog'

import StatusButtons from './OrderStatusIndicator'

function renderAlg(arrayOfBtns) {
  /*The buttons render algoritm recive an array which consists of buttons, like an object
  {
      tip: tooltip name,
      handler: mutation or some another function,
      icon: icon component,
      requirement: the condition under which will be render this button,
      className: specific class 
  },
  */

  // if (!arrayOfBtns.length) return null
  const renderResult = arrayOfBtns.map(each => {
    if (each.requirement || each.requirement === undefined) {
      const btnComponent = (
        <Button
          key={each.tip}
          variant="iconic"
          data-tip={each.tip}
          onClick={each.handler}
          className={each.className}
        >
          <each.icon />
        </Button>
      )

      if (each.dialog)
        return (
          <each.dialog handler={each.dialogHandler} key={each.tip}>
            {btnComponent}
          </each.dialog>
        )
      else return btnComponent
    }
  })

  if (!renderResult.filter(each => each).length) return null
  return <Box sx={{ display: 'flex' }}>{renderResult.filter(each => each)}</Box>
}

export default function OrderActions({ order }) {
  // const orderId = order.OrderID
  const { store }: any = useAppContext()
  const { orderId, editMode, setEditMode, setAddOrderItemDialog, setEditedOrderItem } =
    useOrderDetailStore()

  const isHaveFullRight = [
    UserStatus.general,
    UserStatus.management,
    UserStatus.bookkeeping
  ].includes(store.user.AccessLevelID)

  const [mutationMoveOrderToArchive] = useMoveOrderToArchiveMutation()
  const [mutationMoveOrderToPriority] = useMoveOrderToPriorityMutation()
  const [mutationDeleteOrder] = useDeleteOrderMutation()

  const history = useHistory()

  const baseurl = () => {
    if ([1, 2].includes(order.OrderStatusID)) return '/'
    if ([10, 11, 12].includes(order.OrderStatusID)) return '/reclamation'
  }

  // Перекидывает заказ в архив (убирает из очередности)
  async function transferOrderToArchive(OrderStatusID) {
    mutationMoveOrderToArchive({
      variables: {
        OrderID: orderId,
        ActualShippingDate: new Date(),
        OrderStatusID
      }
    }).then(res => {
      if (res.data.update_erp_Orders_by_pk.OrderID) {
        notif('success', 'Заказ перенесен в архив')
      }
    })
  }

  // Перекидывает предзаказ в очередность
  async function transferOrderToPriority() {
    const res = await mutationMoveOrderToPriority({
      variables: {
        OrderID: orderId,
        AcceptanceDate: new Date()
      }
    })
    if (res.data.update_erp_Orders_by_pk.OrderID) {
      notif('success', 'Заказ внесен в очередность выполнения')
    }
  }

  // для удаления заказа
  function mutationDeleteOrderHandler() {
    mutationDeleteOrder({
      variables: {
        OrderID: orderId
      }
    }).then(res => {
      if (res.data.delete_erp_Orders_by_pk.OrderID) {
        history.push(baseurl())
      }
    })
  }

  const buttons = [
    {
      tip: 'В очередность',
      handler: transferOrderToPriority,
      icon: UilFileCheck,
      requirement: isHaveFullRight && [OrderStatus.ordRegistration].includes(order.OrderStatusID)
    },
    {
      dialog: TransferOrderDialog,
      dialogHandler: () => transferOrderToArchive(3),
      tip: 'Закрыть заказ',
      icon: UilTruck,
      requirement: [OrderStatus.ordProduction].includes(order.OrderStatusID)
    },
    {
      dialog: TransferOrderDialog,
      dialogHandler: () => transferOrderToArchive(13),
      tip: 'Закрыть рекламацию',
      icon: UilTruck,
      requirement: [OrderStatus.reclProduction].includes(order.OrderStatusID)
    },
    {
      dialog: DeleteOrderDialog,
      dialogHandler: mutationDeleteOrderHandler,
      tip: 'Удалить заказ',
      icon: UilTrashAlt,
      requirement:
        isHaveFullRight &&
        [
          OrderStatus.ordRegistration,
          OrderStatus.ordProduction,
          OrderStatus.reclInbox,
          OrderStatus.reclDecision,
          OrderStatus.reclInbox
        ].includes(order.OrderStatusID)
    },
    {
      tip: 'Добавить позицию',
      handler: () => {
        setEditedOrderItem(null)
        setAddOrderItemDialog(true)
      },
      icon: UilPlus,
      requirement:
        isHaveFullRight &&
        ![OrderStatus.ordArchived, OrderStatus.reclArchived].includes(order.OrderStatusID)
    },
    {
      tip: 'Поменять что-то',
      handler: () => setEditMode(!editMode),
      icon: editMode ? UilUnlock : UilLock,
      requirement: isHaveFullRight
    }
  ]

  return (
    <>
      <StatusButtons order={order} renderAlg={renderAlg} />
      {renderAlg(buttons)}
    </>
  )
}
