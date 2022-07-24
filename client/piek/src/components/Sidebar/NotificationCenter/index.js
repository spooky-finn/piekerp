import { useContext, useState } from 'react'
import { Context } from "../../../";
import { Link } from 'react-router-dom'

import CustomDrawer from '../../../components/muiCustom/mui/CustomDrawer'
import Box from '@mui/material/Box'
import Badge from '@mui/material/Badge'


import { UilBell } from '@iconscout/react-unicons'

import { useMutation, useSubscription } from '@apollo/client'
import { GET_NOTIFICATIONS, UPDATE_VIEWED } from './getNotifications'
import sass from './index.module.sass'
import { Typography } from '@mui/material'
import NotificationUnit from './NotificationUnit';

const NotificationCenter = props => {
    const { store } = useContext(Context)
    const [notifications, setNotifications] = useState();

    const [updateViewedMutration] = useMutation(UPDATE_VIEWED)
    function onSubscriptionData(options) {
        const data = options.subscriptionData.data.erp_Notifications
        setNotifications({
            unviewed: data.filter(e => !e.Viewed),
            viewed: data.filter(e => e.Viewed)
        })
    }
    const { data, loading } = useSubscription(GET_NOTIFICATIONS, {
        onSubscriptionData, variables: {
            _eq: store.user.UserID,
            limit: 100
        }
    })
    const [state, setState] = useState(false)

    const toggleDrawer = (open) => (event) => {
        setState(open)
    }

    function closeNotificationCenter() {
        setState(false)
    }

    function jumpToOrderHandler(ID) {
        setState(false);
        updateViewedMutration({ variables: { ID, Viewed: true } })
    }

    const unviewedCounter = () => {
        var a = 0;
        data?.erp_Notifications?.forEach(e => {
            if (!e.Viewed) a += 1
        });
        return a
    }


    return (
        <CustomDrawer icon={
            <Badge badgeContent={unviewedCounter()} color="secondary">
                <UilBell />
            </Badge>
        } width={500} state={state} toggleDrawer={toggleDrawer}>
            <Box className={sass.wrapper}>
                <Typography variant='subtitle3'>Уведомления</Typography>

                {/* unreaderd notifs */}
                {notifications?.unviewed.length ?
                    <Box className={sass.unreadedWrapper}>
                        <Typography variant='subtitle3'>Непросмотренные </Typography>
                        {!loading && notifications?.unviewed.map((e, index) => <NotificationUnit key={index} closeNotificationCenter={closeNotificationCenter} data={e} />)}
                    </Box>
                    : null}

                {!loading && notifications?.viewed.map((e, index) => <NotificationUnit key={index} closeNotificationCenter={closeNotificationCenter} data={e} />)}

            </Box>
        </CustomDrawer>
    )
}
export default NotificationCenter