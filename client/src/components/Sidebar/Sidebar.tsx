/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { UilConstructor, UilSetting, UilSortAmountDown, UilWrench } from '@iconscout/react-unicons'
import { NavLink } from 'react-router-dom'
import { AppRoutes } from 'src/routers/Router'
import NotificationsContainer from '../NotificationCenter/NotificationsContainer'

export default function Sidebar() {
  const styles = css`
    display: flex;
    flex-direction: column;
    padding: 10px 0;
    width: 50px;
    border-right: var(--border);

    @media print {
      width: 0 !important;
      opacity: 0;
    }

    .link {
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 0px auto;
      color: var(--lowContrast);
      width: 100%;
      height: 50px;
    }

    .active {
      box-shadow: inset 3px 0px 0px var(--accent) !important ;
      color: var(--accent);
    }
    .marginTopAuto {
      margin-top: auto;
    }
  `

  return (
    <div css={styles}>
      <NavLink
        to={AppRoutes.orders_production}
        className={({ isActive }) => 'link' + (isActive ? ' active' : '')}
      >
        <UilSortAmountDown />
      </NavLink>

      <NavLink
        to={AppRoutes.reclamation}
        className={({ isActive }) => 'link' + (isActive ? ' active' : '')}
      >
        <UilWrench />
      </NavLink>

      <NavLink
        to={AppRoutes.attendance}
        className={({ isActive }) => 'link' + (isActive ? ' active' : '')}
      >
        <UilConstructor />
      </NavLink>

      <div className="link marginTopAuto">{<NotificationsContainer />}</div>

      <NavLink
        to={AppRoutes.settings}
        className={({ isActive }) => 'link' + (isActive ? ' active' : '')}
      >
        <UilSetting />
      </NavLink>
    </div>
  )
}
