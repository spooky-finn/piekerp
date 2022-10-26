import { UilSearch } from '@iconscout/react-unicons'
import styled from '@emotion/styled'
import React, { ReactNode } from 'react'

interface ISearchInputWithFiltersProps {
  value: string
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void
  children: ReactNode
}

export default function SearchInputWithFilters({
  value,
  onChange,
  children
}: ISearchInputWithFiltersProps) {
  const Wrap = styled.div`
    display: flex;
    justify-content: space-between;
    padding: 0 15px;
    background: var(--L1);
    margin: 20px 15px;
    border-radius: var(--br);

    .filterWrappers {
      display: inline-flex;
      gap: 10px;
    }
  `
  const InputWrap = styled.div`
    display: flex;
    width: 100%;
    align-items: center;
    gap: 10px;

    svg {
      width: 18px;
      opacity: 0.3;
      transition: opacity 0.2s ease;
    }
    input {
      border: none;
      flex-grow: 1;
      height: 100%;
      background: transparent;
      font-size: 1.1rem;
    }
  `

  return (
    <Wrap>
      <InputWrap>
        <UilSearch />
        <input
          type="text"
          placeholder={'Счет, контрагент'}
          onChange={onChange}
          autoFocus
          value={value}
        />
      </InputWrap>

      <div className="filterWrappers">{children}</div>
    </Wrap>
  )
}
