import { Stack } from '@mui/material'
import * as React from 'react'
import { useRootStore } from 'src/store/storeProvider'
import ChatCommandMenuContainer from './chatCommandMenuContainer'

import ChatMessageInput from './chatMessageInput'
import { ChatMessage, ChatMessageGroup } from './chatEntity'
import ChatMessageView from './chatMessage'
import { observer } from 'mobx-react-lite'

function MessageList(props: { messages: ChatMessage[] }) {
  const messageGroups: ChatMessageGroup[] = []

  for (let i = 0; i < props.messages.length; i++) {
    const message = props.messages[i]
    const prevMessage = props.messages[i - 1]

    if (prevMessage && prevMessage.sender.id === message.sender.id) {
      messageGroups[messageGroups.length - 1].messages.push(message)
    } else {
      messageGroups.push(new ChatMessageGroup([message]))
    }
  }

  return (
    <Stack direction="column" flexGrow={2} pt={2} justifyContent="flex-end">
      {messageGroups.map((each, id) => (
        <ChatMessageView key={id} messageGroup={each} />
      ))}
    </Stack>
  )
}

function ChatMessageInpuContainer() {
  return (
    <div>
      <ChatMessageInput />
    </div>
  )
}

function ChatBox() {
  const state = useRootStore().chat!

  return (
    <Stack direction="column" gap={2} flexGrow={1} position="relative">
      {state.inputRef && <ChatCommandMenuContainer />}

      <MessageList messages={state.messages} />
      <ChatMessageInpuContainer />
    </Stack>
  )
}

export default observer(ChatBox)
