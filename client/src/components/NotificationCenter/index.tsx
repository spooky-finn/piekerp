import { UilBell } from '@iconscout/react-unicons'
import { Typography } from '@mui/material'
import Badge from '@mui/material/Badge'
import Box from '@mui/material/Box'
import { useContext, useState } from 'react'
import { useGetNotificationsSubscription, useUpdateViewedMutation } from 'src/types/graphql-shema'
import { Context } from '../..'
import CustomDrawer from '../muiCustom/mui/CustomDrawer'
import Notification from './Notification'

const NotificationCenter = props => {
  const { store }: any = useContext(Context)
  const [notifications, setNotifications] = useState<{ unviewed: any; viewed: any }>()

  const [updateViewedMutration] = useUpdateViewedMutation()

  const { data, loading } = useGetNotificationsSubscription({
    onData(options) {
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

  const [state, setState] = useState(false)

  const toggleDrawer = open => event => {
    setState(open)
  }

  function closeNotificationCenter() {
    setState(false)
  }

  function jumpToOrderHandler(ID) {
    setState(false)
    updateViewedMutration({ variables: { ID, Viewed: true } })
  }

  const unviewedCounter = () => {
    var a = 0
    data?.erp_Notifications?.forEach(e => {
      if (!e.Viewed) a += 1
    })
    return a
  }

  return (
    <CustomDrawer
      icon={
        <Badge badgeContent={unviewedCounter()} color="secondary">
          <UilBell />
        </Badge>
      }
      width={500}
      state={state}
      toggleDrawer={toggleDrawer}
    >
      <Box>
        {/* unreaderd notifs */}
        {notifications?.unviewed.length ? (
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
            <Notification closeNotificationCenter={closeNotificationCenter} data={e} />
          ))}
      </Box>
    </CustomDrawer>
  )
}
export default NotificationCenter
