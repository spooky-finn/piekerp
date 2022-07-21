import { UilSearch } from '@iconscout/react-unicons'
import styled from '@emotion/styled'


const SearchInputWithFilters = ({ value, onChange, children }) => {

    const Wrap = styled.div`
        display: flex;
        justify-content: space-between;
        padding: 8px 15px;
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
    `

    return (
        <Wrap>

            <InputWrap>
                <UilSearch />
                <input
                    type='text'
                    placeholder={"Счет, контрагент"}
                    onChange={onChange}
                    autoFocus
                    value={value}
                />
            </InputWrap>

            <div className='filterWrappers'>
                {children}
            </div>
        </Wrap>
    )
}
export default SearchInputWithFilters