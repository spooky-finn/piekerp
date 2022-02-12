import { Menu, MenuItem } from '@mui/material/';
import sass from './index.module.sass'
import placeCaretAtEnd from '../../../utils/placeCaretAtEnd'


const UserListPopover = props => {
  const { anchorEl, open, handleClose, users, inputRef } = props;

  const onClick = (e) => {
    handleClose();
    const userID = e.target.getAttribute('userid')
    const user = users.find(e => e.UserID == userID)
    const inputform = document.getElementById('Comments_InputForm')
    const elem = document.createElement('span')
    inputRef.current.innerText = inputRef.current.innerText.slice(0, -1)

    elem.innerHTML= '@' + [user.FirstName, user.LastName].join(' ') + ', '
    elem.classList.add(sass.mentionedUserHiglight)
    elem.dataset.mentionedUser = user.UserID
    elem.contentEditable = 'false'
    inputform.appendChild(elem)

    placeCaretAtEnd(inputform)

    const space = document.createElement('span')
    inputform.appendChild(space)
  }

  return (
    <Menu
    id="Comments__userListMenu"
    aria-labelledby="Comments_InputForm"
    anchorEl={anchorEl}
    open={open}
    onClose={handleClose}
  >
  
    { users && users.map( (user) => (
      <MenuItem 
      sx      = {{
        padding: '4px 10px',
      }}
      userid  = {user.UserID} 
      key     = {user.UserID} 
      onClick = {onClick}>
        {user.FirstName} {user.LastName}
      </MenuItem>
    ))}
 
  </Menu>
  )
}
export default UserListPopover