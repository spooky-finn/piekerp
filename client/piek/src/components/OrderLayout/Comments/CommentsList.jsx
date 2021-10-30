import { useState, useRef, useEffect } from 'react';
import { useMutation, useSubscription } from '@apollo/client';
import { INSERT_ORDER_COMMENT, UPDATE_ORDER_COMMENT, DELETE_ORDER_COMMENT } from '../queries/MutationOrderCommnets'
import { SUBSCRIBTION_ORDER_COMMENT } from '../queries/SubscriptionComments'
import sass from './index.module.sass'

import { Box } from '@mui/material/';
import Comment from './Comment'
import { UilMessage } from '@iconscout/react-unicons'
import СommandsPopover from './СommandsPopover'

const CommentsList = (props) => {
  const { orderID, user } = props
  const [ insertOrderCommentMutation ] = useMutation(INSERT_ORDER_COMMENT);
  const [ updateOrderCommentMutation ] = useMutation(UPDATE_ORDER_COMMENT);
  const [ deleteOrderCommentMutation ] = useMutation(DELETE_ORDER_COMMENT);

  var   inputRef = useRef();
  const [nowEditing, setNowEditing] = useState();
  
  const { data: comments = [], loading } = useSubscription(SUBSCRIBTION_ORDER_COMMENT, { variables: { OrderID: orderID }});

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
    inputRef.current.innerText = ''
   
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
  
  function switchTodo(e) {
    e.target.classList.toggle(sass.checklistUnit_complited)
  }

  function inputHandler(e){
    if (e.target.innerText.trim() === '/'){
      setAnchorEl(e.target)
      e.target.innerHTML = ''
    }
  }
  
  const handleClose = () => {
    setAnchorEl(null);
  };
  
  useEffect(() => {
    const els = [...document.querySelectorAll(`div.${sass.commentUnit} div.${sass.checklistUnit}`)]
    els.forEach( el => {
      el.addEventListener('click', switchTodo, false);
    }, {once : true})
    return () => {
      els.forEach( el => {
        el.removeEventListener('click', switchTodo, false);
      })
    }
  }, [comments])

  return(
    <div className={sass.commentsListWrapper}>
     <div className={sass.commentInputForm}>
      
      <СommandsPopover anchorEl={anchorEl} open={open} handleClose={handleClose}/>

      <Box id="Comments__commandMenu__button"
        aria-controls="Comments__commandMenu"
        aria-haspopup="true"
        contentEditable='true'
        ref={inputRef}
        sx={{ minHeight: 20, padding: '10px 5px'}}
        data-ph="Комментарий или ' / ' для команды"
        suppressContentEditableWarning={true}
        onInput={inputHandler}>
      </Box>
    
      <div onClick={insertComment} className={sass.saveButton}><UilMessage/></div>
    </div>

     {!loading && 
      comments.erp_Comments.map( (comment) => <Comment 
        data={comment} 
        key={comment.CommentID}
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