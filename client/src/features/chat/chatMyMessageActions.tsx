import BorderColorRoundedIcon from '@mui/icons-material/BorderColorOutlined'
import DeleteRoundedIcon from '@mui/icons-material/DeleteOutlined'
import { IconButton, Stack } from '@mui/material'
import { useRootStore } from 'src/store/storeProvider'
import { ChatMessage } from './chatEntity'

export default function ChatMyMessageActions(props: { message: ChatMessage }) {
  const state = useRootStore().chat!

  return (
    <Stack
      direction="row"
      className="chat-message-my-actions"
      borderRadius={1}
      bgcolor={'var(--L0)'}
      sx={{ position: 'absolute', top: '-15px', right: 20 }}
    >
      <IconButton
        size="small"
        onClick={() => {
          state.handleEditMessage(props.message)
        }}
      >
        <BorderColorRoundedIcon />
      </IconButton>
      <IconButton
        size="small"
        onClick={() => {
          state.handleDeleteMessage(props.message)
        }}
      >
        <DeleteRoundedIcon />
      </IconButton>
    </Stack>
  )
}
