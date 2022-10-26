/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { UilEllipsisV } from '@iconscout/react-unicons'
import { Button, Menu, MenuItem } from '@mui/material'
import { useState } from 'react'

interface IOrderItemActionsProps {
  handleEditClick: () => void
  handleDeleteClick: () => void
}

export default function MenuActions({
  handleDeleteClick,
  handleEditClick
}: IOrderItemActionsProps) {
  const [anchorEl, setAnchorEl] = useState(null)

  const handleClick = event => setAnchorEl(event.currentTarget)
  const handleClose = () => setAnchorEl(null)

  const styles = css`
    .deleteButton {
      color: var(--danger) !important;
    }

    .moreVertIcon {
      color: var(--lowContrast);
      height: 18px;
      transform: rotate(90deg);
    }

    .inputListItem {
      margin: 8px 0.5rem;
      input,
      textarea {
        font-size: 0.9rem;
      }

      &:hover {
        background: transparent !important;
      }
    }
  `
  return (
    <div className="noprint" css={styles}>
      <Button
        sx={{
          minWidth: '20px'
        }}
        aria-controls="simple-menu"
        aria-haspopup="true"
        onClick={handleClick}
        size="small"
      >
        <UilEllipsisV className="moreVertIcon" />
      </Button>
      <Menu
        id="simple-menu"
        anchorEl={anchorEl}
        keepMounted
        open={Boolean(anchorEl)}
        onClose={handleClose}
      >
        <div className="actionsWrapper">
          <MenuItem
            onClick={e => {
              handleClose()
              handleEditClick()
            }}
          >
            Редактировать
          </MenuItem>

          <MenuItem
            className="deleteButton"
            onClick={() => {
              handleClose()
              handleDeleteClick()
            }}
          >
            Удалить
          </MenuItem>
        </div>
      </Menu>
    </div>
  )
}
