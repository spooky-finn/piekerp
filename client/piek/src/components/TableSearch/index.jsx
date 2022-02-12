import { UilSearch } from '@iconscout/react-unicons'
import PropTypes from 'prop-types';
import sass from './table_search.module.sass'


const TableSearch = (props) => {
  const {placeholder, onChange, defaultValue, disableAutoFocus} = props
   return (
    <div className={sass.table_search_wrapper}>
      <UilSearch/>
      
      <input 
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