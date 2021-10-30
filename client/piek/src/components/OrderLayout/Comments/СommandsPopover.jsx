import { Menu, MenuItem } from '@mui/material/';
import sass from './index.module.sass'

const СommandsPopover = props => {
  const {anchorEl, open, handleClose} = props

  function insertTodoinDOM (){
    const root = document.getElementById('Comments__commandMenu__button')
    const elem = document.createElement('div')
    elem.classList.add(sass.checklistUnit)
    root.appendChild(elem)
  }

  return (
    <Menu
        id="Comments__commandMenu"
        aria-labelledby="Comments__commandMenu__button"
        anchorEl={anchorEl}
        open={open}
        elevation={5}
        onClose={handleClose}
        sx={{
          border: '1px solid var(--border) !important',
          '.MuiList-root':{
            padding: '10px',

          }
        }}
      >
        <MenuItem onClick={() => {
          handleClose();
          insertTodoinDOM();
        }}>Чеклист</MenuItem>
        <MenuItem onClick={handleClose} sx={{ color: 'var(--border)'}}>Упомянуть</MenuItem>
    </Menu>
  )
}

export default СommandsPopover
