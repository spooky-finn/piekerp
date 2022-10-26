/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'
import { ReactNode } from 'react'

export default function PaperL1({ children }: { children: ReactNode }) {
  return (
    <div
      css={css`
        padding: 15px 0;
        background: var(--L1);
        margin: 15px;
        border-radius: var(--br);
      `}
    >
      {children}
    </div>
  )
}
