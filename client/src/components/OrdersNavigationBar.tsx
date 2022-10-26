/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { ReactNode } from 'react'
import { NavLink } from 'react-router-dom'
import { AppRoutes } from 'src/routers/Router'
export interface IOrdersNavigationBarProps {
  children?: ReactNode
}

export default function OrdersNavigationBar(props: IOrdersNavigationBarProps) {
  const styles = css`
    display: flex;
    align-items: center;
    gap: 20px;
    height: 40px;
    align-items: stretch;
    padding: 0 20px;

    a {
      display: flex;
      align-items: center;
      color: var(--highContrast);
      text-decoration: none;
      padding: 0px 10px;
      font-weight: 500;
      border-radius: var(--br);
      margin-top: 5px;
    }
    .active {
      background: var(--lowContrast);
      color: var(--textInvert);
    }
    .children {
      margin-left: auto;
    }
  `
  return (
    <div css={styles}>
      <NavLink
        to={AppRoutes.orders_registration}
        className={({ isActive }) => (isActive ? 'active' : '')}
      >
        Предзаказы
      </NavLink>
      <NavLink
        to={AppRoutes.orders_production}
        className={({ isActive }) => (isActive ? 'active' : '')}
      >
        Очередность
      </NavLink>
      <NavLink
        to={AppRoutes.orders_recently}
        className={({ isActive }) => (isActive ? 'active' : '')}
      >
        Недавние
      </NavLink>
      <NavLink
        to={AppRoutes.orders_archive}
        className={({ isActive }) => (isActive ? 'active' : '')}
      >
        Архив
      </NavLink>
      <NavLink
        to={AppRoutes.orders_report}
        className={({ isActive }) => (isActive ? 'active' : '')}
      >
        Отчет
      </NavLink>

      <div className="children">{props.children}</div>
    </div>
  )
}
