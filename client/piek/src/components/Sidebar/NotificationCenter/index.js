import { useContext, useState } from 'react'
import { Context } from "../../../";
import { Link } from 'react-router-dom'

import CustomDrawer from '../../_core/mui/CustomDrawer'
import Box from '@mui/material/Box'
import Badge from '@mui/material/Badge'


import { UilBell } from '@iconscout/react-unicons'

import { useMutation, useSubscription } from '@apollo/client'
import { GET_NOTIFICATIONS, UPDATE_VIEWED } from './getNotifications'
import sass from './index.module.sass'
import moment from 'moment'
import { Typography } from '@mui/material'

const NotificationCenter = props => {
  const { store } = useContext(Context)
  const [notifications, setNotifications] = useState();

  const [ updateViewedMutration ] = useMutation(UPDATE_VIEWED)
  function onSubscriptionData(options){
    const data = options.subscriptionData.data.erp_Notifications
    setNotifications({
      unviewed: data.filter(e => !e.Viewed),
      viewed: data.filter(e => e.Viewed)
    })
  }
  const { data, loading } = useSubscription(GET_NOTIFICATIONS, { onSubscriptionData, variables: {
    _eq: store.user.UserID,
    limit: 100
  }})
  const [state, setState] = useState(false)

  const toggleDrawer = (open) => (event) => {
    setState(open)
  }

  function jumpToOrderHandler(ID){
    setState(false);
    updateViewedMutration({ variables: { ID, Viewed: true } })
  }
 
  const unviewedCounter = () => {
    var a=0;
    data?.erp_Notifications?.forEach(e => {
      if (!e.Viewed) a+=1
    });
    return a
  }
  
  const notificationUnit = (e) => (
    <Box
    className={sass.notificationUnit}
    key={e.ID}>
      <div className={sass.notificationHeader}>
        <Typography className={sass.item1}>{e.Comment.User.FirstName} {e.Comment.User.LastName} <span className={sass.normal}>упомянул вас</span></Typography>
        <Typography variant='subtitle2' className={sass.item2}>{moment(e.Comment.Timestamp).format('DD MMM H:mm')}</Typography>


          <Link 
        to={`/orders/${e.Order.OrderID}`} 
        onClick={() => jumpToOrderHandler(e.ID)}
        className={sass.item3}
        >
           <Typography variant='subtitle2'>{e.Order.Entity}__{e.Order.City}</Typography>
        </Link>
      </div>

        <div 
          className={sass.commentContent}
          dangerouslySetInnerHTML={{ __html: e.Comment.Text }}
        >
        </div>
    </Box>
  )

  return (
    <CustomDrawer icon={ 
      <Badge badgeContent={unviewedCounter()} color="secondary">
        <UilBell/>
      </Badge>
    } width={500} state={state} toggleDrawer={toggleDrawer}>
      <Box className={sass.wrapper}>
        <Typography variant='subtitle3'>Уведомления</Typography>
        
         {/* unreaderd notifs */}
        { notifications?.unviewed.length ?
          <Box className={sass.unreadedWrapper}> 
            <Typography variant='subtitle3'>Непросмотренные </Typography>
            {!loading && notifications?.unviewed.map(e => notificationUnit(e) )}
          </Box>
        : null}

        {!loading && notifications?.viewed.map( e => notificationUnit(e) )}

      </Box>
    </CustomDrawer>
  )
}
export default NotificationCenter