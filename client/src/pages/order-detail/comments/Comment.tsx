import moment from 'moment'
import { TComment } from 'src/types/global'
import { useDeleteCommentMutation, useUpdateCommentMutation } from 'src/types/graphql-shema'
import sass from './index.module.sass'

interface ICommentProps {
  data: TComment
  userID: number
}

export default function Comment({ data, userID }: ICommentProps) {
  const [deleteMutation] = useDeleteCommentMutation()
  const [updateMutation] = useUpdateCommentMutation()

  function updateComment(id: number, newText: string) {
    updateMutation({
      variables: {
        CommentID: id,
        Text: newText.trim()
      }
    })
  }

  function handleDelete() {
    deleteMutation({ variables: { CommentID: data.CommentID } })
  }

  const handleChangeTodo: React.MouseEventHandler<HTMLDivElement> = e => {
    // если комментарий содержит чек-лист выполняем мутацию на обновление состояния
    if (e.currentTarget.innerHTML.toString().includes(sass.checklistUnit, 0)) {
      updateComment(data.CommentID, e.currentTarget.innerHTML)
    }
  }

  function sender() {
    return `${data.User.FirstName} ${data.User.LastName}`
  }

  function actions() {
    if (userID === data.User.UserID) return <div onClick={handleDelete}>Удалить</div>
  }

  function timestamp() {
    const date = moment(data.Timestamp)
    return date.format('MMM D') + ' at ' + date.format('hh:mm')
  }

  function getCommentContent() {
    const isYourComment = userID === data.User.UserID
    return isYourComment ? (
      <div
        contentEditable="true"
        key={data.CommentID}
        className={sass.commentContent}
        suppressContentEditableWarning={true}
        onBlur={async e => {
          await updateComment(data.CommentID, e.target.innerHTML)
        }}
        onMouseLeave={async e => {
          await updateComment(data.CommentID, e.currentTarget.innerHTML)
          // setNowEditing(null)
        }}
        dangerouslySetInnerHTML={{ __html: data.Text }}
      />
    ) : (
      <div
        onClick={handleChangeTodo}
        dangerouslySetInnerHTML={{ __html: data.Text }}
        className={sass.commentContent}
      />
    )
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
