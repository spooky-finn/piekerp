import { useContext } from 'react'
import { Context } from "../../../";
import CustomDrawer from '../../_core/mui/CustomDrawer'
import Box from '@mui/material/Box'
import { UilBell } from '@iconscout/react-unicons'

import { useSubscription } from '@apollo/client'
import { GET_NOTIFICATIONS } from './getNotifications'
import sass from './index.module.sass'
import moment from 'moment'
import { Typography } from '@mui/material'

const NotificationCenter = props => {
  const { store } = useContext(Context)
  const { data, loading } = useSubscription(GET_NOTIFICATIONS, { variables: {
    _eq: store.user.UserID,
    limit: 100
  }})
  // if (!loading && !data.erp_Notifications) return null

  return (
    <CustomDrawer icon={<UilBell/>} width={500}>
      <Box className={sass.wrapper}>
        {!loading && data?.erp_Notifications.map( e => (

          <Box 
          className={sass.notificationUnit}
          key={e.ID}>
            <div className={sass.notificationHeader}>
              <Typography className={sass.item1}>{e.Comment.User.FirstName} {e.Comment.User.LastName}</Typography>
              <Typography variant='subtitle2' className={sass.item2}>в {moment(e.Comment.Timestamp).format('DD.MM.YY H:mm')}</Typography>
              <Typography variant='subtitle2' className={sass.item3}>{e.Order.Entity}__{e.Order.City}</Typography>
            </div>
            <div 
            className={sass.commentContent}
            dangerouslySetInnerHTML={{ __html: e.Comment.Text }}
            >
            </div>
          </Box>

        ))}
      </Box>
    </CustomDrawer>
  )
}
export default NotificationCenter