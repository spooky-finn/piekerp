/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { UilEdit, UilEditAlt, UilEllipsisV, UilTrash } from '@iconscout/react-unicons'
import { Button, ListItemIcon, Menu, MenuItem } from '@mui/material'
import React, { useState } from 'react'

interface IOrderItemActionsProps {
  handleEditClick: () => void
  handleDeleteClick: () => void
}

export default function ActionsMenu({
  handleDeleteClick,
  handleEditClick
}: IOrderItemActionsProps) {
  const [anchorEl, setAnchorEl] = useState<Element | null>(null)

  const handleClick = (event: React.MouseEvent<HTMLButtonElement>) =>
    setAnchorEl(event.currentTarget)
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
            <ListItemIcon>
              <UilEdit />
            </ListItemIcon>
            Редактировать
          </MenuItem>

          <MenuItem
            className="deleteButton"
            onClick={() => {
              handleClose()
              handleDeleteClick()
            }}
          >
            <ListItemIcon>
              <UilTrash />
            </ListItemIcon>
            Удалить
          </MenuItem>
        </div>
      </Menu>
    </div>
  )
}
