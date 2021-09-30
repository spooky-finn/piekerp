import { useState } from 'react';
import PropTypes from 'prop-types';

import { Button, Menu, MenuItem, TextField } from '@material-ui/core';
import { withStyles } from '@material-ui/core/styles';
import { UilEllipsisV } from '@iconscout/react-unicons'
import sass from './index.module.sass'

const StyledMenuItem = withStyles((theme) => ({
    root: {
        fontSize: '.8rem',
        color: 'var(--highContrast)',
    },
  }))( (props) => (
    <MenuItem disableRipple={true} {...props} /> 
  ));

  const StyledInput = withStyles((theme) => ({
    root: {
        fontSize: '.8rem',
    },
  }))( (props) => (
      <TextField
        size='small' 
        variant='outlined' 
        InputLabelProps={{shrink: true}} 
        {...props} />
  ));

  
const OrderItemActions = ({ editState, item, editItemHandler, deleteItemHandler, updateItem }) => {
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
            onClose={handleClose}
          >


            <StyledMenuItem className={sass.inputListItem} >
              <StyledInput 
                type="number"
                label="Серийный номер" 
                multiline
                onChange={(e) => setState(prevState => ({
                ...prevState,
                'serialNumber': e.target.value
                }))}
                defaultValue={state.serialNumber}
                />
            </StyledMenuItem>

            <StyledMenuItem className={sass.inputListItem} >
              <StyledInput 
                label="Сборщик"  
                onChange={(e) => setState(prevState => ({
                ...prevState,
                'fitter': e.target.value
                }))}
                defaultValue={state.fitter}
              />
            </StyledMenuItem>


            {editState && (
              <div className={sass.actionsWrapper}>
                <StyledMenuItem onClick={ (e) => {
                    handleClose();
                    editItemHandler(e, item);
                }}>Изменить</StyledMenuItem>

                <StyledMenuItem 
                  className={sass.deleteButton}
                  onClick={ ()=> {
                    handleClose();
                    deleteItemHandler(item.OrderItemID);
                }}>Удалить</StyledMenuItem>
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

