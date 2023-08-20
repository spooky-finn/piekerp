import { Box } from '@mui/material'
import ChatBox from './chatBox'

export default function Chat() {
  return (
    <Box
      sx={{
        background: 'var(--L0)',
        display: 'flex',
        flexDirection: 'column',
        width: '100%',
        height: '100%',
        overflowY: 'scroll',
        position: 'relative'
      }}
    >
      <ChatBox />
    </Box>
  )
}
