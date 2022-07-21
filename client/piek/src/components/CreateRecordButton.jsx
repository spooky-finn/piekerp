/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { Button } from '@mui/material'

export default function CreateRecordButton({ onClick }) {
    return <Button
        css={css`
        margin: 6px 0 ;
        `}
        variant='contained'
        onClick={onClick}>
        + Запись
    </Button>
}