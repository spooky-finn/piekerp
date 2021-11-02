import { UilSearch } from '@iconscout/react-unicons'
import sass from './search.module.sass'
import { FormControl, Select, MenuItem } from '@mui/material';

const Search = ({state, dispatch, users }) => {
    // const classes = useStyles();

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
        <div className={sass.tableSearchInput}>
            <UilSearch/>
            <input type='text' placeholder="Счет или юрлицо" onChange={searchHandler} autoFocus defaultValue={state.searchKeyword}/>

            {/* filter data by manager */}
            { users && (<div className={sass.filter}>
            <span className={sass.filterPlaceholder}>manager</span>

                <FormControl>
                <Select
                    name="managerFilter"
                    value={state.managerFilter}
                    onChange={managerHandler}
                >
                    <MenuItem value={0}>Все</MenuItem>
                    { users.map( (user) => 
                    <MenuItem value={ user.UserID } key={user.UserID} > {`${user.FirstName} ${user.LastName}`} </MenuItem>
                    )}
                
                </Select>
                </FormControl>
            </div>)}
        </div>

     {/* filter indicator */}
    {managerFilterIndicator(state.managerFilter)}
    </>
    )
}
export default Search