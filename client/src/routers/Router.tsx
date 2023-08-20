import { Navigate, Route, Routes } from 'react-router-dom'
import RequireAuth from './PrivateRoute'
import Attendance from 'src/pages/attendance/Attendance'
import LoginForm from 'src/pages/login/LoginForm'
import OrderDetail from 'src/pages/order-detail/OrderDetail'
import Archive from 'src/pages/orders/archive/Archive'
import Production from 'src/pages/orders/production/Production'
import Recently from 'src/pages/orders/recently/Recently'
import Registration from 'src/pages/orders/registration/Registration'
import ReclamationContainer from 'src/pages/reclamation/ReclamationContainer'
import Settings from 'src/pages/settings/Settings'
import Report from 'src/pages/orders/report/Report'

export enum AppRoutes {
  orders_production = '/orders/production',
  orders_registration = '/orders/registration',
  orders_recently = '/orders/recently',
  orders_archive = '/orders/archive',
  orders_report = '/orders/report',

  order_detail = '/orders/',
  settings = '/settings',
  reclamation = '/reclamation',
  attendance = '/attendance'
}

export default function AppRouter() {
  return (
    <Routes>
      <Route path="/login" element={<LoginForm />} />

      <Route path="/" element={<Navigate to={AppRoutes.orders_production} />} />

      <Route
        path={AppRoutes.attendance}
        element={
          <RequireAuth>
            <Attendance />
          </RequireAuth>
        }
      />

      <Route
        path={AppRoutes.reclamation}
        element={
          <RequireAuth>
            <ReclamationContainer />
          </RequireAuth>
        }
      />
      <Route
        path={AppRoutes.settings}
        element={
          <RequireAuth>
            <Settings />
          </RequireAuth>
        }
      />

      <Route
        path={AppRoutes.orders_registration}
        element={
          <RequireAuth>
            <Registration />
          </RequireAuth>
        }
      />
      <Route
        path={AppRoutes.orders_production}
        element={
          <RequireAuth>
            <Production />
          </RequireAuth>
        }
      />
      <Route
        path={AppRoutes.orders_recently}
        element={
          <RequireAuth>
            <Recently />
          </RequireAuth>
        }
      />
      <Route
        path={AppRoutes.orders_archive}
        element={
          <RequireAuth>
            <Archive />
          </RequireAuth>
        }
      />
      <Route
        path={AppRoutes.orders_report}
        element={
          <RequireAuth>
            <Report />
          </RequireAuth>
        }
      />

      <Route
        path={`${AppRoutes.order_detail}:id`}
        element={
          <RequireAuth>
            <OrderDetail />
          </RequireAuth>
        }
      />
    </Routes>
  )
}
