import sass from './search.module.sass'
import { FormControl, Select, MenuItem, Box } from '@mui/material';
import TableSearch from '../../_core/mui/TableSearch'

const Search = ({ state, dispatch, users  }) => {
    const searchHandler = (e) => {
        dispatch({ type: 'searchKeyword', payload: e.target.value }) 
    }

    const managerHandler = (e) => {
        dispatch({ type: 'managerFilter', payload: e.target.value })
    }

    const managerFilterIndicator = () => {
        if (state.managerFilter !== 0) return (
            <div className={sass.filterIndicator}>
                <div className={sass.circle}></div>
                <p>Выдача ограничена фильтром</p>
            </div>
        ) 
    }

    return (
        <>
        <Box sx={{ display: 'flex' }}>
            <TableSearch placeholder="Счет, юрлицо" onChange={searchHandler} defaultValue={state.searchKeyword}/>

            {/* filter data by manager */}
            { users && (<div className={sass.filter}>
            <span className={sass.filterPlaceholder}>manager</span>

                <FormControl>
                  <Select
                  name    = "managerFilter"
                  value    = {state.managerFilter}
                  onChange = {managerHandler}
                  >
                      <MenuItem value={0}>Все</MenuItem>
                      { users.map( (user) => 
                      <MenuItem value={ user.UserID } key={user.UserID} > {`${user.FirstName} ${user.LastName}`} </MenuItem>
                      )}
                  </Select>
                </FormControl>
            </div>)}
        </Box>

     {/* filter indicator */}
    {managerFilterIndicator(state.managerFilter)}
    </>
    )
}
export default Search