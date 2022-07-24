/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'

export default function PaperL1({ children }) {
    return (
        <div css={css`
            padding: 15px 0;
            background: var(--L1);
            margin: 15px;
            border-radius: var(--br);
        `}>
            {children}
        </div>
    )
}