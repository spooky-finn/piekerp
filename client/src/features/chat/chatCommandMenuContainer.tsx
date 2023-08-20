import { MenuItem as MuiMenuItem, MenuList as MuiMenuList, Popper, Typography } from '@mui/material'
import { observer } from 'mobx-react-lite'
import { useRootStore } from 'src/store/storeProvider'
import { ChatCommand } from './chatEntity'

function ChatCommandMenuContainer() {
  const state = useRootStore().chat!

  return (
    <Popper
      open={state.commandMenuOpen}
      anchorEl={state.inputRef}
      onClick={() => {}}
      placement="bottom-start"
      sx={{
        width: '-webkit-fill-available',
        background: 'var(--L0)'
      }}
      modifiers={[
        {
          name: 'flip',
          enabled: true,
          options: {
            altBoundary: true,
            rootBoundary: 'document'
          }
        },
        {
          name: 'preventOverflow',
          enabled: true,
          options: {
            altAxis: true,
            altBoundary: true,
            tether: true,
            rootBoundary: 'document'
          }
        }
      ]}
    >
      <MenuItemList commands={state.commands} />
    </Popper>
  )
}

function MenuItem(props: { command: ChatCommand; id: number }) {
  return (
    <MuiMenuItem
      onClick={() => {
        props.command.onClick(props.command)
      }}
      sx={{
        display: 'flex',
        gap: 2
      }}
      autoFocus={props.id === 0}
    >
      {props.command.icon && <props.command.icon />}
      <Typography fontWeight={500}>{props.command.name}</Typography>
    </MuiMenuItem>
  )
}

function MenuItemList(props: { commands: ChatCommand[] }) {
  return (
    <MuiMenuList autoFocusItem>
      {props.commands.map((command, idx) => (
        <MenuItem key={command.name} command={command} id={idx} />
      ))}
    </MuiMenuList>
  )
}

export default observer(ChatCommandMenuContainer)
