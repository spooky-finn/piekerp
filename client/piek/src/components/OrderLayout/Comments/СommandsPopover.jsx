import PropTypes from 'prop-types'
import { Menu, MenuItem, Box } from '@mui/material/';
import ReactDOM from 'react-dom';
import sass from './index.module.sass'

const СommandsPopover = props => {
  const {anchorEl, open, handleClose, inputRef} = props

  function insertTodoinDOM (){
    const s = <div className={sass.checklistUnit}>что</div>
    ReactDOM.render(s, inputRef.current)
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

СommandsPopover.propTypes = {

}

export default СommandsPopover
