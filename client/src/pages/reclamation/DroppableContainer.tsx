/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { Typography } from '@mui/material'
import { Draggable, Droppable } from 'react-beautiful-dnd'
import { TReclamationOrder } from 'src/types/global'
import { ColocatedStateKey } from './Reclamation'
import ReclamationItem from './ReclamationItem'
import { getItemStyle, getListStyle } from './utils'

export interface IDroppableContainerProps {
  columnName: string
  droppableId: ColocatedStateKey
  data: TReclamationOrder[]
}

export default function DroppableContainer({
  columnName,
  droppableId,
  data
}: IDroppableContainerProps) {
  const styles = css`
    background: var(--L1);
    padding-bottom: 20px;
    border-radius: var(--br);
    overflow: hidden;

    .heading {
      color: var(--accent);
      padding: 10px 15px 10px;
      font-weight: 600;
    }
    .list {
      min-height: 600px;
      height: 100%;
      display: flex;
      flex-grow: 1;
      flex-direction: column;
    }
  `
  return (
    <div key={droppableId} css={styles}>
      <Typography className="heading">{columnName}</Typography>
      <Droppable droppableId={droppableId}>
        {(provided, snapshot) => (
          <div
            style={getListStyle(snapshot.isDraggingOver)}
            ref={provided.innerRef}
            className="list"
          >
            {data.map((item, index) => (
              <Draggable
                key={item.OrderID.toString()}
                draggableId={item.OrderID.toString()}
                index={index}
              >
                {(provided, snapshot) => (
                  <div
                    ref={provided.innerRef}
                    {...provided.draggableProps}
                    {...provided.dragHandleProps}
                    style={getItemStyle(snapshot.isDragging, provided.draggableProps.style!)}
                  >
                    {<ReclamationItem order={item} />}
                  </div>
                )}
              </Draggable>
            ))}

            {provided.placeholder}
          </div>
        )}
      </Droppable>
    </div>
  )
}
