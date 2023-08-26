import { Box, Stack } from '@mui/system'
import { observer } from 'mobx-react-lite'
import React from 'react'
import { useRootStore } from 'src/store/storeProvider'

function ChatMessageInput() {
  const state = useRootStore().chat!

  function handleEnterPress(e: React.KeyboardEvent<HTMLDivElement>) {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault()
      state.handleInputSubmin()
      e.currentTarget.textContent = ''
    }
  }

  return (
    <Stack
      direction="row"
      sx={{
        background: 'var(--L2)',
        position: 'sticky',
        bottom: 0,
        left: 0,
        right: 0
      }}
    >
      <Box
        ref={r => {
          if (r) state.setInputRef(r as any)
        }}
        role="textbox"
        id="chat-message-input"
        aria-controls="Comments__commandMenu"
        aria-haspopup="true"
        contentEditable="true"
        sx={{
          minHeight: 22,
          padding: '10px 10px',
          flexGrow: 1,
          outline: 'none',
          'p, span, div': {
            margin: 0,
            background: 'inherit !important',
            color: 'inherit !important',
            fontFamily: 'inherit !important',
            fontSize: '1rem !important',
            whiteSpace: 'break-spaces'
          },
          '&:empty:before': {
            content: 'attr(data-ph)'
          }
        }}
        data-ph="Комментарий или ' / ' для команды"
        suppressContentEditableWarning={true}
        onKeyDown={handleEnterPress}
        onInput={() => {
          state.handleCommandtInput()
        }}
        data-testid="inputForm"
      ></Box>
    </Stack>
  )
}

export default observer(ChatMessageInput)
