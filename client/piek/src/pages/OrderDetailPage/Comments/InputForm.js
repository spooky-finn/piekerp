import { useState } from 'react';

import { useQuery } from '@apollo/client';
import { GET_ALL_USERS } from '../queries/GetAllUsers';

//ui
import { Box } from '@mui/material/';
import { UilMessage } from '@iconscout/react-unicons'
import sass from './index.module.sass'

// components
import СommandsPopover from './СommandsPopover'
import UserListPopover from './UserListPopover';

const InputForm = props => {
  const { insertComment, inputRef } = props

  const { data: users = [] } = useQuery(GET_ALL_USERS)

  const [anchorEl, setAnchorEl] = useState(null);
  // User List Popover
  const [anchorULP, setAnchorULP] = useState(null)

  function inputHandler(e){
    if (e.target.innerText.trim() === '/'){
      setAnchorEl(e.target)
      e.target.innerHTML = ''
    }
    if (e.target.innerText.trim() === '@'){
      setAnchorULP(e.target)
    }
  }

  function keyPressHandler(e){
    if ((e.ctrlKey || e.metaKey) && (e.keyCode === 13 || e.keyCode === 10)) {
      insertComment()
    }
  }

  const handleClose = () => {
    setAnchorEl(null);
  };
  const handleCloseUserListPopover = () => {
    setAnchorULP(null)
  }

  return (
    <div className={`${sass.commentInputForm} noprint`}>
      
      <СommandsPopover 
      setAnchorULP = {setAnchorULP} 
      anchorEl     = {anchorEl} 
      open         = {Boolean(anchorEl)} 
      handleClose  = {handleClose}
      inputRef     = {inputRef} />
      <UserListPopover 
      anchorEl    = {anchorULP} 
      open        = {Boolean(anchorULP)} 
      handleClose = {handleCloseUserListPopover}
      users       = {users.erp_Users}
      inputRef    = {inputRef} />

      <Box id="Comments_InputForm"
        aria-controls="Comments__commandMenu"
        aria-haspopup="true"
        contentEditable='true'
        ref={inputRef}
        sx={{ minHeight: 20, padding: '10px 5px'}}
        data-ph="Комментарий или ' / ' для команды"
        suppressContentEditableWarning={true}
        onInput={inputHandler}
        onKeyUp={keyPressHandler}
        >
      </Box>
    
      <div onClick={insertComment} className={sass.saveButton}><UilMessage/></div>
    </div>
  )
}
export default InputForm