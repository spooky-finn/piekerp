import { useState } from 'react';
import PropTypes from 'prop-types';

import { Button, Menu, MenuItem, TextField } from '@mui/material';
import { UilEllipsisV } from '@iconscout/react-unicons'
import sass from './index.module.sass'
  
const OrderItemActions = ({ editState, item, editItemHandler, deleteItemHandler, updateItem, setOIDialog }) => {
  const [anchorEl, setAnchorEl] = useState(null);
  const [state, setState] = useState({
    'serialNumber': item.SerialNumber,
    'fitter': item.Fitter
  });

  const handleClick = (event) => {
    setAnchorEl(event.currentTarget);
  };
  
  const handleClose = () => {
    setAnchorEl(null);

    if (item.SerialNumber !== state.serialNumber || item.Fitter !== state.fitter){
      updateItem({ variables: {
        'OrderItemID': item.OrderItemID,
        'Fitter': state.fitter,
        'SerialNumber': state.serialNumber.toString()
      } })
    }
  };
    
  return (
  <div className='noprint'>
    <Button aria-controls="simple-menu" aria-haspopup="true" onClick={handleClick} size='small'>
      <UilEllipsisV className={sass.moreVertIcon}/>
    </Button>
    <Menu
      id="simple-menu"
      anchorEl={anchorEl}
      keepMounted
      open={Boolean(anchorEl)}
      PaperProps={{
        sx: {
          boxShadow: '0 10px 50px 0 var(--bs)',
          background: 'var(--LI)',
          borderRadius: 'var(--br)' }
      }}
      onClose={handleClose}
    >


      <MenuItem className={sass.inputListItem} >
        <TextField 
          type="number"
          label="Серийный номер" 
          multiline
          variant="filled"
          size='small'
          onChange={(e) => setState(prevState => ({
          ...prevState,
          'serialNumber': e.target.value
          }))}
          defaultValue={state.serialNumber}
          />
      </MenuItem>

      <MenuItem className={sass.inputListItem} >
        <TextField 
          label="Сборщик"  
          variant="filled"
          size='small'
          onChange={(e) => setState(prevState => ({
          ...prevState,
          'fitter': e.target.value
          }))}
          defaultValue={state.fitter}
        />
      </MenuItem>


      {editState && (
        <div className={sass.actionsWrapper}>
          <MenuItem onClick={ (e) => {
              setOIDialog(true)
              handleClose();
              editItemHandler(e, item);
          }}>Редактировать</MenuItem>

          <MenuItem 
            className={sass.deleteButton}
            onClick={ ()=> {
              handleClose();
              deleteItemHandler(item.OrderItemID);
          }}>Удалить</MenuItem>
        </div>
      )}

    </Menu>
  </div>
  );
}

OrderItemActions.propTypes = { 
    editState: PropTypes.bool,
    item:      PropTypes.object,
    editItemHandler:  PropTypes.func, 
    deleteItemHandler: PropTypes.func,
    updateItem: PropTypes.func
}

export default OrderItemActions

