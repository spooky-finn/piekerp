import sass from './index.module.sass'
import moment from 'moment'

const Comment = (props) => {
  const { data, userID, updateComment, deleteComment, nowEditing, setNowEditing } = props

  function sender(){
    if (userID === data.User.UserID) return 'Вы'
    else return `${data.User.FirstName} ${data.User.LastName}`
  }
  function actions(){
    if (userID === data.User.UserID && nowEditing?.CommentID !== data.CommentID ) return (
        <div onClick={()=> deleteComment(data.CommentID)}>Удалить</div>
    )
  }
  function timestamp(){
    const date = moment(data.Timestamp)
    return date.format('MMM D') +' at '+ date.format('hh:mm')
  }

  function getCommentContent(){
    if (userID === data.User.UserID) return <div contentEditable="true"
    key={data.CommentID}
    className={sass.commentContent}
    suppressContentEditableWarning="true"
    onBlur={async (e) => {
      await updateComment(data.CommentID, e.target.innerHTML)
    }}
    onMouseLeave={async (e) => {
      await updateComment(data.CommentID, e.target.innerHTML)
      setNowEditing(null)
    }}
    dangerouslySetInnerHTML={{ __html: data.Text}}></div>

    else return <div className={sass.commentContent}>{data.Text}</div>

  }

  return (
    <div className={sass.commentUnit}>

      <div className={sass.commentHeader}>
        <div className={sass.sender}> {sender()} </div>
        <div className={sass.actions}>{actions()}</div>
        <div className={sass.time}> {timestamp()} </div>
      </div>
      {getCommentContent()}

    </div>
  )
}
export default Comment 