import { useState } from 'react';
import { useMutation, useSubscription } from '@apollo/client';
import { INSERT_ORDER_COMMENT, UPDATE_ORDER_COMMENT, DELETE_ORDER_COMMENT } from '../queries/MutationOrderCommnets'
import { SUBSCRIBTION_ORDER_COMMENT } from '../queries/SubscriptionComments'
import sass from './index.module.sass'

import { TextField } from '@mui/material/';
import Comment from './Comment'
const CommentsList = (props) => {
  const { orderID, user } = props
  const [ insertOrderCommentMutation ] = useMutation(INSERT_ORDER_COMMENT);
  const [ updateOrderCommentMutation ] = useMutation(UPDATE_ORDER_COMMENT);
  const [ deleteOrderCommentMutation ] = useMutation(DELETE_ORDER_COMMENT);
  const [state, setState]           = useState('');
  const [nowEditing, setNowEditing] = useState();
  const { data = [], loading } = useSubscription(SUBSCRIBTION_ORDER_COMMENT, { variables: { OrderID: orderID }});

  function insertComment(){
    if (!state) return null
    insertOrderCommentMutation({ variables: {
      OrderID: orderID,
      UserID: user.UserID,
      Text: state
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
  
  return(
    <div className={sass.commentsListWrapper}>
     <div className={sass.commentInputForm}>
     <TextField
        variant='standard'
        placeholder='Введите комментарий' 
        className={sass.commentInput}
        multiline
        fullWidth
        size='small'
        autoComplete="off"
        InputProps={{ disableUnderline: true }}
        value={state}
        onChange={(e) => setState(e.target.value) }
        />
      {state &&
      <div 
      onClick={insertComment} 
      className={sass.saveButton}>
        Сохранить
      </div>
      }
    </div>

     {!loading && data.erp_Comments.map( (data) => <Comment 
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