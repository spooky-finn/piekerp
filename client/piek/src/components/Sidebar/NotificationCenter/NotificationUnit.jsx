/** @jsxImportSource @emotion/react */

import styled from "@emotion/styled"
import { css } from '@emotion/react'
import { Button } from "@mui/material"
import { UilArrowRight } from '@iconscout/react-unicons'
import { useHistory } from "react-router-dom"
import moment from "moment"

export default function NotificationUnit({ data, closeNotificationCenter }) {

    const history = useHistory();

    const Wrap = styled.div`
        display: flex;
        flex-direction: column;
        gap: 15px;
        font-size: .9rem;
        margin: 20px 0;
        background: var(--L1);
        border-radius: var(--br);
        overflow: hidden;
        
    `
    const Head = styled.div`
        display: grid;
        gap: 5px;
        padding: 15px;
    `

    const Body = styled.div`
    padding: 0 15px;
    `

    const Actions = styled.div`
        display: inline-flex;
        padding: 0 15px 10px;
    `

    function toOrderDetailPageHandler() {
        closeNotificationCenter();
        history.push(`/orders/${data.Order.OrderID}`)
    }

    return (
        <Wrap>
            <Head>
                <div>
                    <span css={css`
                        font-weight: 500;
                        padding-right: 10px;
                    `}>{data.Comment.User.FirstName} {data.Comment.User.LastName}</span>
                    <span>упомянул вас</span>
                </div>

                <div css={css`
                    display: flex;
                    justify-content: space-between;
                `}>
                    <span> {data.Order.Entity}__{data.Order.City} </span>
                    <span css={css`
                        font-size: .8rem;
                    `}> {moment(data.Comment.Timestamp).format('DD MMM H:mm')} </span>
                </div>
            </Head>

            <Body dangerouslySetInnerHTML={{ __html: data.Comment.Text }}></Body>
            <Actions>
                {/* <Button fullWidth>Понятно</Button> */}
                <Button
                    onClick={toOrderDetailPageHandler}
                    css={css`
                    color: var(--lowContrast);
                    background: var(--L2);
                `}
                >К заказу  <UilArrowRight /></Button>


            </Actions>

        </Wrap>
    )
}