/* eslint-disable react-hooks/exhaustive-deps */
import { useCallback, useEffect, useLayoutEffect, useState } from 'react'
import { useDropzone } from 'react-dropzone'
import { useLocation, useParams } from 'react-router-dom'
import ReactTooltip from 'react-tooltip'

import { Box, Stack } from '@mui/system'
import { apolloClient } from 'src/api'
import Chat from 'src/features/chat/chat'
import { ChatMessage, ChatUser } from 'src/features/chat/chatEntity'
import { useAppContext } from 'src/hooks'
import { useOrderDetailStore } from 'src/hooks/useOrderDetailStore'
import { useRootStore } from 'src/store/storeProvider'
import {
  DeleteCommentDocument,
  DeleteCommentMutation,
  DeleteCommentMutationVariables,
  GetAllUsersDocument,
  GetAllUsersQuery,
  InsertCommentDocument,
  InsertCommentMutation,
  InsertCommentMutationVariables,
  UpdateCommentDocument,
  UpdateCommentMutation,
  UpdateCommentMutationVariables,
  useCommentsSubscription,
  useGetManagersQuery,
  useGetOrderByPkQuery
} from 'src/types/graphql-shema'
import FileService from '../../services/FileService'
import OrderHeader from './OrderHeader'
import RightInfoPanel from './RightInfoPanel'
import EditRightInfoPanel from './RightInfoPanel/EditRightInfoPanel'
import DialogAddEditOrderItem from './dialogs/AddEditOrderItemDialog'
import Docs from './docs/Docs'
import OrderItemList from './order-items/OrderItemList'
import './sass/index.sass'
import { isFileOnDropzone } from './utils.dropzone'

export default function OrderDetail() {
  const { store } = useAppContext()
  // files that now in uploading
  const [onUploadFiles, setOnUploadFiles] = useState<File[]>([])

  const defaultEditMode = new URLSearchParams(useLocation().search).get('edit') ? true : false
  const queryParams = useParams<{ id: string }>()
  const orderId = parseInt(queryParams.id || '')
  const chatState = useRootStore().chat
  if (!orderId) throw Error('Null OrderId at the local store')

  const { editMode, initialize } = useOrderDetailStore()

  useEffect(() => {
    ReactTooltip.rebuild()
  }, [editMode])

  useLayoutEffect(() => {
    initialize(orderId, defaultEditMode)
  }, [orderId])

  const handleFileOnDrop = useCallback(async (acceptedFiles: File[]) => {
    setOnUploadFiles(acceptedFiles)
    const res = await FileService.uploadFile(acceptedFiles, orderId)
    if (res.status === 200) {
      refetch()
    } else {
      console.log('S3 file upload error', res)
      refetch()
    }
    setOnUploadFiles([])
  }, [])

  const { data, refetch } = useGetOrderByPkQuery({
    variables: {
      OrderID: orderId
    }
  })

  const { data: users } = useGetManagersQuery()

  const { getRootProps, isDragActive } = useDropzone({
    onDrop: handleFileOnDrop,
    noKeyboard: true,
    noClick: true
  })

  useEffect(() => {
    // const res = apolloClient.subscribe<CommentsSubscriptionResult, CommentsSubscriptionVariables>({
    //   query: CommentsDocument,
    //   variables: {
    //     OrderID: orderId
    //   }
    // })
    // const appUsers = await apolloClient.query<GetAllUsersQuery>({
    //   query: GetAllUsersDocument
    // })

    chatState.init({
      deleteMessage: async message => {
        apolloClient.mutate<DeleteCommentMutation, DeleteCommentMutationVariables>({
          mutation: DeleteCommentDocument,
          variables: {
            CommentID: message.id
          },
          optimisticResponse: {
            delete_erp_Comments_by_pk: {
              __typename: 'erp_Comments',
              CommentID: message.id
            }
          }
        })
      },
      updateMessage: async message => {
        apolloClient.mutate<UpdateCommentMutation, UpdateCommentMutationVariables>({
          mutation: UpdateCommentDocument,
          variables: {
            CommentID: message.id,
            Text: message.message
          }
        })
      },
      insertMessage: async message => {
        apolloClient.mutate<InsertCommentMutation, InsertCommentMutationVariables>({
          mutation: InsertCommentDocument,
          variables: {
            OrderID: orderId,
            Text: message,
            UserID: store.user?.UserID ?? 0
          },
          optimisticResponse: {
            insert_erp_Comments_one: {
              __typename: 'erp_Comments',
              CommentID: 0,
              Text: message,
              Timestamp: new Date().toISOString(),
              UserID: store.user?.UserID ?? 0,
              OrderID: orderId
            }
          }
        })
      }
    })
  }, [])

  useCommentsSubscription({
    variables: { OrderID: orderId },
    onData(options) {
      const data = options.data.data?.erp_Comments

      if (!data) return

      const messages = data.map((comment): ChatMessage => {
        const senser = new ChatUser(
          comment.User.UserID,
          comment.User.FirstName + ' ' + comment.User.LastName
        )
        return new ChatMessage(comment.CommentID, comment.Text, senser, comment.Timestamp)
      })

      chatState.addMessages(messages)
    }
  })

  if (!data?.erp_Orders || !store.user?.UserID) return null

  return (
    <>
      <DialogAddEditOrderItem refetch={refetch} />

      {isFileOnDropzone(isDragActive)}
      {data.erp_Orders && users?.erp_Users ? (
        <>
          <Stack {...getRootProps()} id="dropzone" direction="row" height="100%">
            <Stack direction="column" flexGrow={1}>
              <OrderHeader order={data.erp_Orders[0]} />
              <OrderItemList data={data.erp_Orders[0].OrderItems} refetch={refetch} />
              <Docs data={data.erp_Orders[0].Docs} onUpload={onUploadFiles} refetch={refetch} />
            </Stack>

            <Box display="flex" flexGrow={1} width="40%">
              {editMode ? (
                <EditRightInfoPanel
                  data={data.erp_Orders[0]}
                  refetch={refetch}
                  users={users.erp_Users}
                />
              ) : (
                <RightInfoPanel data={data.erp_Orders[0]} />
              )}
            </Box>

            <Box flexShrink={0} width="40%" borderLeft="var(--border)">
              <Chat />
            </Box>
          </Stack>
        </>
      ) : null}
    </>
  )
}
