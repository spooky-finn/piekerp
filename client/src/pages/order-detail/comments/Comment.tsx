/** @jsxImportSource @emotion/react */
import moment from 'moment'
// import { TComment } from 'src/types/global'
import { useDeleteCommentMutation, useUpdateCommentMutation } from 'src/types/graphql-shema'
import sass from './index.module.sass'
import MyAvatar from 'src/components/Avatar'
import { Box, Button, Stack, css } from '@mui/material'

interface ICommentProps {
  data: any
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

  function actions() {
    if (userID === data.User.UserID)
      return (
        <Button
          color="secondary"
          onClick={handleDelete}
          className="comment-delete-btn"
          sx={{ opacity: 0, visibility: 'hidden' }}
        >
          Удалить
        </Button>
      )
  }

  function timestamp() {
    const date = moment(data.Timestamp)
    return date.format('DD.MM.YY') + '  ' + date.format('hh:mm')
  }

  function messageHeader() {
    return (
      <Stack gap={1} direction="row" px={2}>
        <b>{`${data.User.FirstName} ${data.User.LastName}`}</b>

        <div className={sass.time}> {timestamp()} </div>
        <Box ml="auto" className={sass.actions}>
          {actions()}
        </Box>
      </Stack>
    )
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
    <Stack
      my={2}
      direction="row"
      css={css({
        '&:hover': {
          '.comment-delete-btn': {
            opacity: 1,
            visibility: 'visible'
          }
        }
      })}
    >
      <MyAvatar name={data.User.FirstName + ' ' + data.User.LastName} />
      <Stack direction="column" display="flex" flexGrow={1}>
        {messageHeader()}
        {getCommentContent()}
      </Stack>
    </Stack>
  )
}
