import { Menu, MenuItem } from '@mui/material/';
import sass from './index.module.sass'

const СommandsPopover = props => {
  const {anchorEl, open, handleClose, setAnchorULP, inputRef} = props

  function insertTodoinDOM (){
    const root = document.getElementById('Comments_InputForm')
    const elem = document.createElement('div')
    elem.classList.add(sass.checklistUnit)
    root.appendChild(elem)
  }

  function mentionHandler(){
    handleClose();
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
        <MenuItem onClick={() => {
          handleClose();
          insertTodoinDOM();
        }}>Чеклист</MenuItem>
        <MenuItem onClick={mentionHandler}>Упомянуть</MenuItem>
    </Menu>
  )
}

export default СommandsPopover
