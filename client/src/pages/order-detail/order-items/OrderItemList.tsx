import { useOrderDetailStore } from 'src/hooks/useOrderDetailStore'
import { TOrderItem } from 'src/types/global'
import { useDeleteOrderItemByPkMutation } from 'src/types/graphql-shema'
import ActionsMenu from './ActionsMenu'
import OrderItem from './OrderItem'

interface IOrderItemListProps {
  data: TOrderItem[]
  refetch: () => void
}

export default function OrderItemList({ data, refetch }: IOrderItemListProps) {
  const { setEditedOrderItem, editMode } = useOrderDetailStore()
  const [deleteItemMutation] = useDeleteOrderItemByPkMutation()

  const handleEditClick = (target: TOrderItem) => setEditedOrderItem(target)

  function handleDeleteClick(target: TOrderItem) {
    deleteItemMutation({
      variables: { id: target.OrderItemID },
      onCompleted() {
        refetch()
      }
    })
  }

  return (
    <div className="Composition">
      {data.map((each, index) => (
        <OrderItem sequence_number={index + 1} orderItem={each} key={index}>
          {editMode && (
            <ActionsMenu
              handleEditClick={() => handleEditClick(each)}
              handleDeleteClick={() => handleDeleteClick(each)}
            />
          )}
        </OrderItem>
      ))}
    </div>
  )
}
