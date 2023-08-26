/** @jsxImportSource @emotion/react */
import { Box, Stack, css } from '@mui/material'
import { observer } from 'mobx-react-lite'
import MyAvatar from 'src/components/Avatar'
import { useRootStore } from 'src/store/storeProvider'
import { ChatMessage, ChatMessageGroup } from './chatEntity'
import ChatMyMessageActions from './chatMyMessageActions'

export interface IChatMessageProps {
  messageGroup: ChatMessageGroup
}

function MesageMetainfo(props: { message: ChatMessage }) {
  return (
    <Stack gap={1} direction="row" alignItems="center">
      <b>{props.message.sender.name}</b>
      <div
        css={css({
          fontSize: '0.8rem'
        })}
      >
        {props.message.formatTimestamp()}
      </div>
    </Stack>
  )
}

function MessageContent(props: { message: ChatMessage }) {
  const app = useRootStore().app

  return (
    <Box
      p={0.3}
      position="relative"
      css={css({
        '.chat-message-my-actions': {
          opacity: 0,
          visibility: 'hidden'
        },
        '&:hover': {
          backgroundColor: 'var(--L2)',
          '.chat-message-my-actions': {
            opacity: 1,
            visibility: 'visible'
          }
        }
      })}
    >
      <div
        dangerouslySetInnerHTML={{ __html: props.message.message }}
        css={css({
          'p, span, div': {
            margin: 0,
            background: 'inherit !important',
            color: 'inherit !important',
            fontFamily: 'inherit !important',
            fontSize: '1rem !important',
            whiteSpace: 'break-spaces'
          }
        })}
      />
      {props.message.isMine(app.me?.UserID ?? 0) && (
        <ChatMyMessageActions message={props.message} />
      )}
    </Box>
  )
}

function ChatMessageView(props: IChatMessageProps) {
  const m = props.messageGroup.messages[0]
  return (
    <Stack
      gap={1}
      py={0.5}
      px={1}
      my={1}
      direction="row"
      css={css({
        position: 'relative'
      })}
    >
      <MyAvatar name={m.sender.name} />
      <Stack direction="column" display="flex" flexGrow={1} gap={1}>
        <MesageMetainfo message={m} />
        <MessageContent message={m} />

        {props.messageGroup.messages.slice(1).map((m, i) => (
          <MessageContent message={m} key={i} />
        ))}
      </Stack>
    </Stack>
  )
}

export default observer(ChatMessageView)
