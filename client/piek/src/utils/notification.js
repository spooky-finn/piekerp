import { Store } from 'react-notifications-component'
import 'react-notifications-component/dist/theme.css'

export const notif = (type, title, message = '', duration = 2000 ) =>  Store.addNotification({
  title,
  message,
  type,
  insert: "bottom",
  container: "top-right",
  dismiss: {
    duration,
  },
  slidingExit: {
    duration: 50, 
  }
});
