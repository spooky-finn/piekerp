import { useState, useRef, useEffect } from 'react';
import { useMutation, useSubscription } from '@apollo/client';
import { 
  INSERT_ORDER_COMMENT,
  UPDATE_ORDER_COMMENT,
  DELETE_ORDER_COMMENT 
} from '../queries/MutationOrderCommnets'
import { INSERT_NOTIFICATION } from '../queries/MutationNotification';
import { SUBSCRIBTION_ORDER_COMMENT } from '../queries/SubscriptionComments'
import sass from './index.module.sass'

import Comment from './Comment'
import InputForm from './InputForm';
import { Typography } from '@mui/material';

const CommentsList = (props) => {
  const { orderID, user } = props
  const [ insertOrderCommentMutation ] = useMutation(INSERT_ORDER_COMMENT);
  const [ updateOrderCommentMutation ] = useMutation(UPDATE_ORDER_COMMENT);
  const [ deleteOrderCommentMutation ] = useMutation(DELETE_ORDER_COMMENT);
  const [ insertNotificationMutation ] = useMutation(INSERT_NOTIFICATION);

  var   inputRef = useRef();
  const [nowEditing, setNowEditing] = useState();
  
  const { data: comments = [], loading } = useSubscription(SUBSCRIBTION_ORDER_COMMENT, { variables: { OrderID: orderID }});

  function insertComment(){
    const text = inputRef.current.innerHTML
    if (!text) return null
    
    const root = document.getElementById('Comments_InputForm')
    const mentioned = root.querySelectorAll(`.${sass.mentionedUserHiglight}`)
    insertOrderCommentMutation({ variables: {
      OrderID: orderID,
      UserID: user.UserID,
      Text: text
      }
    }).then((res) => {
      const { CommentID, OrderID } = res.data.insert_erp_Comments_one
        mentioned.forEach( el => {
          const MentionedUser = el.dataset.mentionedUser
          insertNotificationMutation({ variables: {
            CommentID, OrderID, MentionedUser
          }})
    
        })
      }
    )
    inputRef.current.innerText = ''
  }

  function updateComment(id, newText){
    updateOrderCommentMutation({ variables: {
      CommentID: id,
      Text: newText,
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

  const line = comments?.erp_Comments?.length ? sass.commentListThread : ''
  
  return(
    <div className={`${sass.commentsListWrapper} ${line}`}>
      <InputForm 
      insertComment={insertComment} 
      inputRef={inputRef} 
      />

     {!loading ?
      comments?.erp_Comments?.map( (comment) => <Comment 
        data={comment} 
        key={comment.CommentID}
        userID={user.UserID}
        deleteComment={deleteComment}
        updateComment={updateComment}
        nowEditing={nowEditing}
        setNowEditing={setNowEditing}
      />): (
        <Typography m="10px" variant='subtitle2'>загрузка..</Typography>
      )}
    </div>
  )
}

export default CommentsList