import { UilSearch } from '@iconscout/react-unicons'
import PropTypes from 'prop-types';

const styles = {
  wrapper: {
    display: 'flex',
    height: '50px',
    alignItems: 'center',
  },
  svg : {
    padding: '0 12px',
    width: '18px',
    color: 'var(--highContrast)',
    opacity: .3,
  },
  input : {
    border: 'none',
    flexGrow: '1',
    background: 'transparent',
    color: 'var(--highContrast)',
    fontSize: '.9rem',
    fontWeight: 600
  }
}  

const TableSearch = (props) => {
  const {placeholder, onChange, defaultValue, disableAutoFocus} = props
   return (
    <div style={styles.wrapper}>
      <UilSearch style={styles.svg}/>
      
      <input 
      style={styles.input} 
      type='text' 
      placeholder={placeholder} 
      onChange={onChange} 
      autoFocus={disableAutoFocus? false : true} 
      defaultValue={defaultValue}
      />
    </div>
   )
}

TableSearch.propTypes = { 
  placeholder: PropTypes.string,
  onChange:    PropTypes.func,
  defaultValue:  PropTypes.string, 
  disableAutoFocus: PropTypes.bool,
}

export default TableSearch