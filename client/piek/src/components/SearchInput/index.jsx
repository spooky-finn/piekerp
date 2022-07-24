/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react'

import { UilSearch } from '@iconscout/react-unicons'
import PropTypes from 'prop-types';

const SearchInput = (props) => {
  const { placeholder, onChange, value, disableAutoFocus } = props

  return (
    <div css={css`
            display: flex;
            width: 100%;
            align-items: center;
            gap: 10px;
            svg {
                width: 18px;
                color: var(--highContrast);
                opacity: .3;
                transition: opacity .2s ease;
            }
            input {
                border: none;
                flex-grow: 1;
                height: 100%;
                background: transparent;
                color: var(--highContrast);
                font-size: .9rem;
                font-weight: 600;
            }
        `}>
      <UilSearch />

      <input
        type='text'
        placeholder={placeholder}

        onChange={onChange}
        autoFocus={disableAutoFocus ? false : true}
        value={value}
      />
    </div>
  )
}

SearchInput.propTypes = {
  placeholder: PropTypes.string,
  onChange: PropTypes.func,
  defaultValue: PropTypes.string,
  disableAutoFocus: PropTypes.bool,
}

export default SearchInput