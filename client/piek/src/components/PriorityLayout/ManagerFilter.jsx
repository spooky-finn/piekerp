import { FormControl, Select, MenuItem } from '@material-ui/core';

export  const managerFilterIndicator = (managerFilter) => {
    if (managerFilter != 0) return (
        <div className='managerFilter-indicator'>
            <div className="circle"></div>
            <p>Выдача ограничена фильтром</p>
        </div>
    ) 
}


const ManagerFilter = ({ dispatch, state, users }) => {

    var val = state.managerFilter
    
    const handler = (e) => dispatch({ type: 'managerFilter', payload: e.target.value })

      if (!users) return null

      return (
        <div className='managerFilter-form'>
        <span className='filterPlaceholder'>manager</span>
        <FormControl>
          <Select
            name="managerFilter"
            value={val}
            onChange={handler}
            disableUnderline={true}
            inputProps={{ 'className': 'managerFilter-input' }}
          >
            <MenuItem value={0} >Все</MenuItem>
            { users.map( (user) => 
            <MenuItem  value={ user.UserID } key={user.UserID} > {`${user.FirstName} ${user.LastName}`} </MenuItem>
            )}
        
        </Select>
        </FormControl>
      </div>
      )
}

export default ManagerFilter