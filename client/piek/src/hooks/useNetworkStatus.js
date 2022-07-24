/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { useEffect } from "react"
import { motion } from "framer-motion"
import styled from '@emotion/styled'
import { useState } from 'react'

export default function useNetworkStatus() {
    const [isNetworkAvailable, setIsNetworkAvailable] = useState(true);


    function _onLine() {
        setIsNetworkAvailable(true)
    }

    function _offLine() {
        setIsNetworkAvailable(false)
    }


    useEffect(() => {
        window.addEventListener('online', _onLine);
        window.addEventListener('offline', _offLine);

        return () => {
            window.addEventListener('online', _onLine);
            window.addEventListener('offline', _offLine);
        }
    }, [])

    const Wrap = styled.div`
     display: flex;
    align-items: center;
    transform: translateX(-50%);
    min-height: 48px;
    width: 100%;
    background-color: var(--danger);
    color: rgba(255, 255, 255, 0.95);
    align-items: center;
    box-sizing: border-box;
    padding: 8px 24px;
    z-index: 20;
    transition: opacity 200ms, transform 300ms ease-out;
    cursor: default;
    border-radius: var(--br);
    pointer-events: all;
    `

    const NotificationProvider = () => {
        if (isNetworkAvailable) return <></>
        return (<motion.div
            css={css`
            position: absolute;
            bottom: 24px;
            left: 50%;
            max-width: 344px;
            `}
            initial={{ opacity: 0, translateY: '100px' }}
            animate={{ opacity: 1, translateY: '0px' }}
            transition={{ duration: 0.5 }}
        >
            <Wrap>You are offline</Wrap>
        </motion.div>)
    }

    return NotificationProvider

}