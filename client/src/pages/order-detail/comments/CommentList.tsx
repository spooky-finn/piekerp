import { useEffect, useRef } from 'react'
import { useOrderDetailStore } from 'src/hooks/useOrderDetailStore'
import { TUser } from 'src/types/global'
import { useInsertCommentMutation, useInsertNotificationMutation } from 'src/types/graphql-shema'
import InputForm from './InputForm'
import sass from './index.module.sass'

interface ICommentsListProps {
  user: TUser
}

export default function CommentList({ user }: ICommentsListProps) {
  const { orderId } = useOrderDetailStore()

  if (!orderId) throw Error('Null OrderId at the local store')

  const [insertOrderCommentMutation] = useInsertCommentMutation()
  const [insertNotificationMutation] = useInsertNotificationMutation()

  const inputRef = useRef<HTMLInputElement>(null)

  // const { data, loading } = useCommentsSubscription({
  //   variables: { OrderID: orderId }
  // })

  function insertComment(): void {
    const text = inputRef.current?.innerHTML
    if (!text) return
    if (!orderId) throw Error('Null OrderId at the local store')

    const root = document.getElementById('Comments_InputForm')
    const mentioned = root?.querySelectorAll<HTMLSpanElement>('span[data-mentioned-user]')

    insertOrderCommentMutation({
      variables: {
        OrderID: orderId,
        UserID: user.UserID,
        Text: text
      }
    }).then(res => {
      if (res.errors || !res.data?.insert_erp_Comments_one) {
        throw Error(res.errors?.toString() ?? 'broken responce')
      }
      const { CommentID, OrderID } = res.data?.insert_erp_Comments_one

      mentioned &&
        mentioned.forEach(el => {
          const mentionedUser = el.dataset.mentionedUser
          if (!mentionedUser) throw Error()

          insertNotificationMutation({
            variables: {
              CommentID,
              OrderID,
              MentionedUser: parseInt(mentionedUser)
            }
          })
        })
    })
    if (inputRef.current) inputRef.current.innerText = ''
  }

  function switchTodo(this: HTMLDivElement, ev: MouseEvent) {
    ;(ev.target as HTMLDivElement).classList.toggle(sass.checklistUnit_complited)
  }

  useEffect(() => {
    const inCommentTodos = document.querySelectorAll<HTMLDivElement>(
      `div.${sass.commentUnit} div.${sass.checklistUnit}`
    )

    inCommentTodos.forEach(
      each => {
        each.addEventListener('click', switchTodo, false)
      },
      { once: true }
    )
    return () => {
      inCommentTodos.forEach(each => {
        each.removeEventListener('click', switchTodo, false)
      })
    }
  }, [])

  return (
    <div>
      {/* {!loading &&
        data?.erp_Comments?.map(comment => (
          <Comment data={comment} key={comment.CommentID} userID={user.UserID} />
        ))} */}

      <InputForm insertComment={insertComment} inputRef={inputRef} />
    </div>
  )
}
