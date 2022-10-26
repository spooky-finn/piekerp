import { Menu, MenuItem } from '@mui/material'
import sass from './index.module.sass'
import placeCaretAtEnd from 'src/utils/PlaceCaretAtEnd'
import { TUser } from 'src/types/global'

interface IUserListPopoverProps {
  anchorEl: Element | null
  open: boolean
  handleClose: () => void
  users: TUser[]
  inputRef: React.RefObject<HTMLInputElement>
}

export default function UserListPopover({
  anchorEl,
  open,
  handleClose,
  users,
  inputRef
}: IUserListPopoverProps) {
  const handleClick = (user_id: number) => {
    handleClose()
    if (!inputRef.current) return

    const user = users.find(e => e.UserID === user_id)
    const inputform = document.getElementById('Comments_InputForm')

    if (!user) throw Error('user is null')
    if (!inputform) throw Error('cant get Comments_InputForm link')

    const elem = document.createElement('span')
    inputRef.current.innerText = inputRef.current?.innerText.slice(0, -1)

    elem.innerHTML = '@' + [user.FirstName, user.LastName].join(' ') + ', '
    elem.classList.add(sass.mentionedUserHiglight)
    elem.dataset.mentionedUser = user.UserID.toString()
    elem.contentEditable = 'false'
    inputform?.appendChild(elem)

    placeCaretAtEnd(inputform)

    const space = document.createElement('span')
    inputform?.appendChild(space)
  }

  return (
    <Menu
      id="Comments__userListMenu"
      aria-labelledby="Comments_InputForm"
      anchorEl={anchorEl}
      open={open}
      onClose={handleClose}
    >
      {users &&
        users.map(user => (
          <MenuItem
            sx={{
              padding: '4px 10px'
            }}
            key={user.UserID}
            onClick={() => handleClick(user.UserID)}
          >
            {user.FirstName} {user.LastName}
          </MenuItem>
        ))}
    </Menu>
  )
}
