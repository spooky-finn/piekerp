import Avatar from '@mui/material/Avatar'
import { useAppContext } from 'src/hooks'
import { AppColorMode } from 'src/types/global'

function stringToHslColor(str: string, s: number, l: number) {
  var hash = 0
  for (var i = 0; i < str.length; i++) {
    hash = str.charCodeAt(i) + ((hash << 5) - hash)
  }

  var h = hash % 360
  return 'hsl(' + h + ', ' + s + '%, ' + l + '%)'
}

function stringAvatar(name: string, colorMode: AppColorMode) {
  const sutaration = colorMode === 'light' ? 80 : 40
  const textColor = colorMode === 'light' ? 'black' : 'white'

  return {
    sx: {
      bgcolor: stringToHslColor(name, sutaration, 30),
      width: 32,
      height: 32,
      fontSize: 16,
      padding: '1px',
      color: textColor
    },
    children: `${name.split(' ')[0][0]}${name.split(' ')[1][0]}`
  }
}

export default function MyAvatar({ firstname, lastname }: { firstname: string; lastname: string }) {
  const { store } = useAppContext()

  if (!store.colorMode) {
    throw new Error('store.colorMode is undefined')
  }

  return <Avatar {...stringAvatar(`${firstname} ${lastname}`, store.colorMode)} />
}
