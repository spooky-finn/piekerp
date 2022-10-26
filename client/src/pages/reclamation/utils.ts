import { DraggableLocation, DraggingStyle, NotDraggingStyle } from 'react-beautiful-dnd'
import { OrderStatus, TReclamationOrder } from 'src/types/global'
import { ColocatedStateKey } from './Reclamation'

// a little function to help us with reordering the result
export const reorder = (list: TReclamationOrder[], startIndex: number, endIndex: number) => {
  const result = Array.from(list)
  const [removed] = result.splice(startIndex, 1)
  result.splice(endIndex, 0, removed)

  return result
}

/**
 * Moves an item from one list to another list.
 */
export const move = (
  source: TReclamationOrder[],
  destination: TReclamationOrder[],
  droppableSource: DraggableLocation,
  droppableDestination: DraggableLocation
) => {
  const sourceClone = Array.from(source)
  const destClone = Array.from(destination)
  const [removed] = sourceClone.splice(droppableSource.index, 1)

  destClone.splice(droppableDestination.index, 0, removed)

  return {
    [droppableSource.droppableId]: sourceClone,
    [droppableDestination.droppableId]: destClone
  }
}

export const getOrderStatusByDroppableId = (droppableId: ColocatedStateKey) => {
  switch (droppableId) {
    case 'inbox':
      return OrderStatus.reclInbox
    case 'decision':
      return OrderStatus.reclDecision
    case 'inproduction':
      return OrderStatus.reclProduction
  }
}

export const getItemStyle = (
  isDragging: boolean,
  draggableStyle: DraggingStyle | NotDraggingStyle
) => ({
  // change background colour if dragging
  background: isDragging ? 'var(--accentLight)' : 'transparent',
  // styles we need to apply on draggables
  ...draggableStyle
})

export const getListStyle = (isDraggingOver: boolean) => ({
  background: isDraggingOver ? 'var(--L2)' : 'inherit'
})
