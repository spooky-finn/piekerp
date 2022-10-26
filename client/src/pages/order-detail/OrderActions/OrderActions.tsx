import {
  Icon,
  UilFileCheck,
  UilLock,
  UilPlus,
  UilTrashAlt,
  UilTruck,
  UilUnlock
} from '@iconscout/react-unicons'
import { Box, Button } from '@mui/material'
import { useNavigate } from 'react-router-dom'
import useAppContext from 'src/hooks/useAppContext'
import { useOrderDetailStore } from 'src/hooks/useOrderDetailStore'
import { OrderStatus, TOrder, UserStatus } from 'src/types/global'
import {
  useDeleteOrderMutation,
  useMoveOrderToArchiveMutation,
  useMoveOrderToPriorityMutation
} from 'src/types/graphql-shema'

import { notif } from '../../../utils/notification'
import DeleteOrderDialog from '../dialogs/DeleteOrderDialog'
import TransferOrderDialog from '../dialogs/TransferOrderDialog'

import StatusButtons from './OrderStatusIndicator'

export type ActionButton = {
  tip: string
  handler?: () => void
  icon: Icon
  className?: string
  userRight: boolean
  hidden?: boolean
  dialog?: React.ElementType
  dialogHandler?: () => void
}

function actionButtonsRender(arrayOfBtns: ActionButton[]) {
  const renderResult = arrayOfBtns.map(each => {
    if (each.hidden) return <div key={each.tip}></div>

    const btnComponent = (
      <Button
        key={each.tip}
        variant="iconic"
        data-tip={each.tip}
        onClick={each.handler}
        className={each.className}
        disabled={!each.userRight}
      >
        <each.icon />
      </Button>
    )

    return each.dialog ? (
      <each.dialog handler={each.dialogHandler} key={each.tip}>
        {btnComponent}
      </each.dialog>
    ) : (
      btnComponent
    )
  })

  if (!renderResult.filter(each => each).length) return null
  return <Box sx={{ display: 'flex' }}>{renderResult.filter(each => each)}</Box>
}

export default function OrderActions({ order }: { order: TOrder }) {
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

  const navigate = useNavigate()

  const baseurl = () => {
    if (
      [OrderStatus.reclDecision, OrderStatus.reclInbox, OrderStatus.reclProduction].includes(
        order.OrderStatusID
      )
    )
      return '/reclamation'

    return '/'
  }

  // Перекидывает заказ в архив (убирает из очередности)
  async function transferOrderToArchive(OrderStatusID: number) {
    if (!orderId) throw Error('orderId is null')

    mutationMoveOrderToArchive({
      variables: {
        OrderID: orderId,
        ActualShippingDate: new Date(),
        OrderStatusID
      }
    }).then(res => {
      if (res.errors) throw new Error(res.errors.toString())
      notif('success', 'Заказ перенесен в архив')
    })
  }

  // Перекидывает предзаказ в очередность
  async function transferOrderToPriority() {
    if (!orderId) throw Error('orderId is null')

    const res = await mutationMoveOrderToPriority({
      variables: {
        OrderID: orderId,
        AcceptanceDate: new Date()
      }
    })
    if (res.errors) throw new Error(res.errors.toString())
    notif('success', 'Заказ внесен в очередность выполнения')
  }

  // для удаления заказа
  function mutationDeleteOrderHandler() {
    if (!orderId) throw Error('orderId is null')

    mutationDeleteOrder({
      variables: {
        OrderID: orderId
      }
    }).then(res => {
      if (res.errors) throw new Error(res.errors.toString())

      navigate(baseurl())
    })
  }

  const buttons: ActionButton[] = [
    {
      tip: 'В очередность',
      handler: transferOrderToPriority,
      icon: UilFileCheck,
      userRight: isHaveFullRight,
      hidden: ![OrderStatus.ordRegistration].includes(order.OrderStatusID)
    },
    {
      dialog: TransferOrderDialog,
      dialogHandler: () => transferOrderToArchive(3),
      tip: 'Закрыть заказ',
      icon: UilTruck,
      userRight: true,
      hidden: ![OrderStatus.ordProduction].includes(order.OrderStatusID)
    },
    {
      dialog: TransferOrderDialog,
      dialogHandler: () => transferOrderToArchive(13),
      tip: 'Закрыть рекламацию',
      icon: UilTruck,
      userRight: true,
      hidden: ![OrderStatus.reclProduction].includes(order.OrderStatusID)
    },
    {
      dialog: DeleteOrderDialog,
      dialogHandler: mutationDeleteOrderHandler,
      tip: 'Удалить заказ',
      icon: UilTrashAlt,
      userRight: isHaveFullRight,
      hidden: ![
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
      userRight: isHaveFullRight,
      hidden: [OrderStatus.ordArchived, OrderStatus.reclArchived].includes(order.OrderStatusID)
    },
    {
      tip: 'Поменять что-то',
      handler: () => setEditMode(!editMode),
      icon: editMode ? UilUnlock : UilLock,
      userRight: isHaveFullRight
    }
  ]

  return (
    <div style={{ display: 'flex' }}>
      <Box mr={'20px'}>
        <StatusButtons order={order} renderAlg={actionButtonsRender} />
      </Box>
      {actionButtonsRender(buttons)}
    </div>
  )
}
