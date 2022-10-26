/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { Box } from '@mui/material'
import { useState } from 'react'
import { DragDropContext, OnDragEndResponder } from 'react-beautiful-dnd'
import { TReclamationOrder } from 'src/types/global'
import { useUpdateOrderStatusMutation } from 'src/types/graphql-shema'
import DroppableContainer from './DroppableContainer'
import { getOrderStatusByDroppableId, move, reorder } from './utils'

export interface IReclamationProps {
  inbox: TReclamationOrder[]
  decision: TReclamationOrder[]
  inproduction: TReclamationOrder[]
}

export type ColocatedStateKey = 'inbox' | 'decision' | 'inproduction'

type State = Record<ColocatedStateKey, TReclamationOrder[]>

export default function Reclamation(props: IReclamationProps) {
  const [updateOrderStatus] = useUpdateOrderStatusMutation()

  const [state, setState] = useState<State>({
    inbox: props.inbox,
    decision: props.decision,
    inproduction: props.inproduction
  })

  const handleOnDragEnd: OnDragEndResponder = result => {
    const { source, destination, draggableId } = result

    // dropped outside the list
    if (!destination) {
      return
    }

    const sInd = source.droppableId as ColocatedStateKey
    const dInd = destination.droppableId as ColocatedStateKey

    if (source.droppableId === destination.droppableId) {
      const array = state[sInd]
      const items = reorder(array, source.index, destination.index)

      setState({
        ...state,
        [source.droppableId]: items
      })
    } else {
      const result = move(state[sInd], state[dInd], source, destination)

      setState({ ...state, ...result })

      const draggableElement: TReclamationOrder = state[sInd].find(
        each => each.OrderID.toString() === draggableId
      )!

      updateOrderStatus({
        variables: {
          OrderID: draggableElement.OrderID,
          OrderStatusID: getOrderStatusByDroppableId(dInd)
        }
      })
    }
  }

  const styles = css`
    margin: 0 20px;
    bottom: 0;
    display: grid !important;
    grid-template-columns: 1fr 1fr 1fr;
    gap: 15px;
  `

  return (
    <DragDropContext onDragEnd={handleOnDragEnd}>
      <Box css={styles}>
        <DroppableContainer columnName="Входящие" droppableId="inbox" data={state.inbox} />
        <DroppableContainer
          columnName="Принятие решения"
          droppableId="decision"
          data={state.decision}
        />
        <DroppableContainer
          columnName="В производстве"
          droppableId="inproduction"
          data={state.inproduction}
        />
      </Box>
    </DragDropContext>
  )
}
