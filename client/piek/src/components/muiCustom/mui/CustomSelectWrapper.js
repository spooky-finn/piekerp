/** @jsxImportSource @emotion/react */
import styled from "@emotion/styled"
import FormControl from "@mui/material/FormControl"
import FormHelperText from '@mui/material/FormHelperText';
import { css } from '@emotion/react'

export default function CustomSelectWrapper({ children, helpText, isActive }){

    const Wrap = styled.div`
    display: flex;
    align-items: center;
    border: var(--border);
    padding: 5px 12px;
    border-radius: 20px;
    min-width: 100px;
    color: var(--lowContrast);
    position: relative;
    margin: 0;

    span {
        color: var(--lowContrast);
        opacity: .7;
    }
    transition: background .3s ease;
    &:hover{
        background: var(--L1);
    }
    &.active {
        background: var(--accent);
        border-color: transparent;
        div, svg {
            color: var(--textInvert) !important;
        }       
        }
    `

    return (
        <div css={css`
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 10px;
        `}>
      
            <FormHelperText css={css`
                margin-left: 15px;
                margin-top: 0;
            `}>{helpText}</FormHelperText>

            <Wrap className={isActive ? 'active' : null} >
                <FormControl fullWidth>
                {children}
                </FormControl>
            </Wrap>
     </div>
    )
}