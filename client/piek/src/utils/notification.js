import { store } from 'react-notifications-component';
import 'react-notifications-component/dist/theme.css'

export const notif = (type, title, message) =>  store.addNotification({
  title,
  message,
  type,
  insert: "bottom",
  container: "top-right",
  dismiss: {
    duration: 4000,
  }
});
