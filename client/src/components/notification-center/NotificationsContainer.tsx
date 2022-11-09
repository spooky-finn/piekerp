import { UilBell } from '@iconscout/react-unicons'
import { Drawer, Typography } from '@mui/material'
import Badge from '@mui/material/Badge'
import Box from '@mui/material/Box'
import { useContext, useState } from 'react'
import { TNotification } from 'src/types/global'
import { useGetNotificationsSubscription } from 'src/types/graphql-shema'
import { Context } from '../..'

import Notification from './Notification'

export default function NotificationsContainer() {
  const { store }: any = useContext(Context)
  const [notifications, setNotifications] = useState<{
    unviewed: TNotification[]
    viewed: TNotification[]
  }>({ unviewed: [], viewed: [] })
  const [state, setState] = useState(false)

  const { data, loading } = useGetNotificationsSubscription({
    onData(options) {
      if (!options.data.data) throw Error(options.data.error?.stack)

      const data = options.data.data.erp_Notifications

      setNotifications({
        unviewed: data.filter(e => !e.Viewed),
        viewed: data.filter(e => e.Viewed)
      })
    },
    variables: {
      _eq: store.user.UserID,
      limit: 100
    }
  })

  const toggleDrawer = (open: boolean) => {
    setState(open)
  }

  function closeNotificationCenter() {
    setState(false)
  }

  const unviewedCounter = data?.erp_Notifications.reduce(
    (acc, cur) => (cur.Viewed ? acc : (acc += 1)),
    0
  )

  return (
    <>
      <div onClick={() => toggleDrawer(true)}>
        <Badge badgeContent={unviewedCounter} color="secondary">
          <UilBell />
        </Badge>
      </div>

      <Drawer
        PaperProps={{
          sx: {
            backgroundColor: 'var(--L0)'
          }
        }}
        open={state}
        onClose={toggleDrawer.bind(null, false)}
      >
        <Box width={500}>
          {/* unreaderd notifs */}
          {notifications.unviewed.length ? (
            <Box sx={{ background: 'var(--L2)' }}>
              <Typography variant="subtitle2" p={'10px'}>
                Непросмотренные{' '}
              </Typography>
              {!loading &&
                notifications?.unviewed.map((e, index) => (
                  <Notification
                    key={index}
                    closeNotificationCenter={closeNotificationCenter}
                    data={e}
                  />
                ))}
            </Box>
          ) : null}

          {!loading &&
            notifications?.viewed.map((e, index) => (
              <Notification
                closeNotificationCenter={closeNotificationCenter}
                data={e}
                key={index}
              />
            ))}
        </Box>
      </Drawer>
    </>
  )
}
