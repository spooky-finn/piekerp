import { UilListUl, UilUser } from '@iconscout/react-unicons'
import { ListItemIcon, Menu, MenuItem } from '@mui/material'
import sass from './index.module.sass'

interface IСommandsPopoverProps {
  anchorEl: Element | null
  open: boolean
  handleClose: () => void
  inputRef: React.RefObject<HTMLInputElement>
  setAnchorULP: React.Dispatch<React.SetStateAction<Element | null>>
}

export default function СommandListPopover({
  anchorEl,
  open,
  handleClose,
  setAnchorULP,
  inputRef
}: IСommandsPopoverProps) {
  function insertTodoinDOM() {
    const root = document.getElementById('Comments_InputForm')
    const elem = document.createElement('div')
    elem.classList.add(sass.checklistUnit)
    elem.setAttribute('data-testid', 'checkListUnit')
    root?.appendChild(elem)
  }

  function mentionHandler() {
    handleClose()
    setAnchorULP(inputRef.current)
  }

  return (
    <Menu
      id="Comments__commandMenu"
      aria-labelledby="Comments_InputForm"
      anchorEl={anchorEl}
      open={open}
      onClose={handleClose}
    >
      <MenuItem
        onClick={() => {
          handleClose()
          insertTodoinDOM()
        }}
      >
        <ListItemIcon>
          <UilListUl />
        </ListItemIcon>
        Чеклист
      </MenuItem>
      <MenuItem onClick={mentionHandler}>
        <ListItemIcon>
          <UilUser />
        </ListItemIcon>
        Упомянуть
      </MenuItem>
    </Menu>
  )
}
