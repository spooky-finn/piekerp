import { UilMessage } from '@iconscout/react-unicons'
import { Box, Button } from '@mui/material'
import React, { useState } from 'react'
import { useGetAllUsersQuery } from 'src/types/graphql-shema'
import sass from './index.module.sass'
import UserListPopover from './UserListPopover'
import СommandListPopover from './СommandListPopover'

interface InputFormProps {
  insertComment: () => void
  inputRef: React.RefObject<HTMLInputElement>
}

export default function InputForm({ insertComment, inputRef }: InputFormProps) {
  const { data: users } = useGetAllUsersQuery()

  const [anchorEl, setAnchorEl] = useState<Element | null>(null)
  // User List Popover
  const [anchorULP, setAnchorULP] = useState<Element | null>(null)

  function handleChange(e: React.ChangeEvent<HTMLDivElement>) {
    const innerText = e.target.textContent?.trim()
    if (!innerText) return

    if (innerText.at(-1) === '/') {
      setAnchorEl(e.target)
      e.target.textContent = innerText.slice(0, innerText.length - 1) + ' '
    }
    if (e.target.textContent?.trim() === '@') {
      setAnchorULP(e.target)
    }
  }

  const handleClose = () => setAnchorEl(null)
  const handleCloseUserListPopover = () => setAnchorULP(null)

  return (
    <div className={`${sass.commentInputForm} noprint`}>
      <СommandListPopover
        setAnchorULP={setAnchorULP}
        anchorEl={anchorEl}
        open={Boolean(anchorEl)}
        handleClose={handleClose}
        inputRef={inputRef}
      />
      <UserListPopover
        anchorEl={anchorULP}
        open={Boolean(anchorULP)}
        handleClose={handleCloseUserListPopover}
        users={users?.erp_Users || []}
        inputRef={inputRef}
      />

      <Box
        id="Comments_InputForm"
        aria-controls="Comments__commandMenu"
        aria-haspopup="true"
        contentEditable="true"
        ref={inputRef}
        sx={{ minHeight: 20, padding: '10px 5px' }}
        data-ph="Комментарий или ' / ' для команды"
        suppressContentEditableWarning={true}
        onInput={handleChange}
        data-testid="inputForm"
      ></Box>

      <Button variant="iconic" onClick={insertComment}>
        <UilMessage />
      </Button>
    </div>
  )
}
