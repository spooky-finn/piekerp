import { useState, useRef } from 'react';
import { useMutation, useSubscription } from '@apollo/client';
import { INSERT_ORDER_COMMENT, UPDATE_ORDER_COMMENT, DELETE_ORDER_COMMENT } from '../queries/MutationOrderCommnets'
import { SUBSCRIBTION_ORDER_COMMENT } from '../queries/SubscriptionComments'
import sass from './index.module.sass'

import { TextField, Menu, MenuItem, Box } from '@mui/material/';
import Comment from './Comment'
import ReactDOM from 'react-dom';

const CommentsList = (props) => {
  const { orderID, user } = props
  const [ insertOrderCommentMutation ] = useMutation(INSERT_ORDER_COMMENT);
  const [ updateOrderCommentMutation ] = useMutation(UPDATE_ORDER_COMMENT);
  const [ deleteOrderCommentMutation ] = useMutation(DELETE_ORDER_COMMENT);
  const [state, setState]           = useState('');
  var inputRef = useRef();
  const [nowEditing, setNowEditing] = useState();
  const { data = [], loading } = useSubscription(SUBSCRIBTION_ORDER_COMMENT, { variables: { OrderID: orderID }});

  const [anchorEl, setAnchorEl] = useState(null);
  const open = Boolean(anchorEl);

  function insertComment(){
    const text = inputRef.current.innerHTML
    if (!text) return null
    insertOrderCommentMutation({ variables: {
      OrderID: orderID,
      UserID: user.UserID,
      Text: text
      }
    })
    setState('')
  }

  function updateComment(id, newText){
    updateOrderCommentMutation({ variables: {
      CommentID: id,
      Text: newText,
      Timestamp: new Date()
    }})
  }

  function deleteComment(id){
    deleteOrderCommentMutation({ variables: {
      CommentID: id
    }
  })
  }
  
  function inputHandler(e){
    if (e.target.innerHTML == '/') setAnchorEl(e.target)
    // setState(e.target.innerHTML)
    // inputRef.current.innerHTML = `<div>hehehe</div>`
    // console.log(inputRef.current.innerHTML)

    let elements = [...document.querySelectorAll('div.Comments_checklistUnit__2rS_e')].forEach(item => { 
      item.removeEventListener('click', ()=>{
        console.log('1');
        }, false);
      item.addEventListener('click', ()=>{
        console.log('1');
        }, false);
    });
    console.log(document.querySelectorAll('div.Comments_checklistUnit__2rS_e'))
  }
  
 
  const handleClick = (event) => {
    setAnchorEl(event.currentTarget);
  };
  const handleClose = () => {
    setAnchorEl(null);
  };
  
  function switchTodo() {
    console.log('switch func')
    // e.target.classList.toggle(sass.checklistUnit_complited)
  }
  return(
    <div className={sass.commentsListWrapper}>
     <div className={sass.commentInputForm}>
      <Menu
        id="demo-positioned-menu"
        aria-labelledby="demo-positioned-button"
        anchorEl={anchorEl}
        open={open}
        onClose={handleClose}
        
        sx={{
          '.MuiList-root':{
            padding: '10px'
          }
        }}
      >
        <MenuItem onClick={() => {
          handleClose();
          const s = <div className={sass.checklistUnit} data-id={Math.random().toString(36).substr(2, 5)} >type smth</div>
          
          ReactDOM.render(s, inputRef.current)
          // const unit = <div class={sass.checklistUnit}>type smth</div>
          // console.log(unit)
          // inputRef.current.children[1] = [unit]
        }}>Чеклист</MenuItem>
        <MenuItem onClick={handleClose}>Упомянуть</MenuItem>
      </Menu>

      <Box id="demo-positioned-button"
          aria-controls="demo-positioned-menu"
          aria-haspopup="true">
        

        <div 
        // dangerouslySetInnerHTML={{__html: }
        id='inputField'
        contentEditable='true'
        ref={inputRef}
        className={sass.commentInput}
        onInput={inputHandler}
        >
        </div>

        {/* <TextField
          variant='standard'
          placeholder='Введите комментарий' 
          className={sass.commentInput}
          multiline
          fullWidth
          size='small'
          autoComplete="off"
          value={state}
          onChange={inputHandler}
          /> */}
      </Box>
    

      {inputRef.current &&
      <div 
      onClick={insertComment} 
      className={sass.saveButton}>
        Сохранить
      </div>
      }
    </div>


     {!loading && 
      data.erp_Comments.map( (data) => <Comment 
        data={data} 
        key={data.CommentID}
        userID={user.UserID}
        deleteComment={deleteComment}
        updateComment={updateComment}
        nowEditing={nowEditing}
        setNowEditing={setNowEditing}
      />)}
    </div>
  )
}

export default CommentsList