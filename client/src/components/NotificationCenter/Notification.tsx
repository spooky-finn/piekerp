/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import styled from '@emotion/styled'
import { UilArrowRight } from '@iconscout/react-unicons'
import { Button } from '@mui/material'
import moment from 'moment'
import { useNavigate } from 'react-router-dom'

import { AppRoutes } from 'src/routers/Router'
import { useUpdateViewedMutation } from 'src/types/graphql-shema'

interface INotificationProps {
  closeNotificationCenter: () => void
  data: any
}

export default function Notification({ data, closeNotificationCenter }: INotificationProps) {
  const navigate = useNavigate()
  const [updateViewedMutration] = useUpdateViewedMutation()

  const Wrap = styled.div`
    display: flex;
    flex-direction: column;
    gap: 15px;
    border-bottom: 1px solid var(--lowContrast);
    overflow: hidden;
  `
  const Head = styled.div`
    display: grid;
    gap: 5px;
    padding: 15px;
  `

  const Body = styled.div`
    padding: 0 15px;
    a,
    p,
    div,
    span {
      font-size: 1rem !important;
      color: var(--highContrast) !important;
    }
  `

  const Actions = styled.div`
    display: inline-flex;
    padding: 0 15px 10px;
  `

  function toOrderDetailPageHandler() {
    closeNotificationCenter()
    navigate(AppRoutes.order_detail + data.Order.OrderID)
    updateViewedMutration({ variables: { ID: data.ID, Viewed: true } })
  }

  return (
    <Wrap>
      <Head>
        <div>
          <span
            css={css`
              font-weight: 500;
              padding-right: 10px;
              color: var(--accent);
            `}
          >
            {data.Comment.User.FirstName} {data.Comment.User.LastName}
          </span>
          <span>упомянул вас</span>
        </div>

        <div
          css={css`
            display: flex;
            justify-content: space-between;
          `}
        >
          <span>
            {data.Order.Entity}__{data.Order.City}
          </span>
          <span
            css={css`
              font-size: 0.9rem;
            `}
          >
            {moment(data.Comment.Timestamp).format('DD MMM H:mm')}{' '}
          </span>
        </div>
      </Head>

      <Body dangerouslySetInnerHTML={{ __html: data.Comment.Text }}></Body>
      <Actions>
        <Button onClick={toOrderDetailPageHandler}>
          К заказу <UilArrowRight />
        </Button>
      </Actions>
    </Wrap>
  )
}
