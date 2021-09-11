import { UilSearch } from '@iconscout/react-unicons'
import sass from './search.module.sass'

import { FormControl, Select, MenuItem } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';


const useStyles = makeStyles((theme) => ({
    formControl: {
      minWidth: 70,
      borderRadius: 'var(--br10)',
      border: '1px solid var(--border)',
      padding: '0 10px',
    },
    select: {
        fontSize: '.8rem',
        color: 'var(--highContrast)',
    },
    menuItem: {
        fontSize: '.8rem',
        color: 'var(--lowContrast)',
        fontSize: '.8rem',
    },
  }));

const Search = ({state, dispatch, users }) => {
    const classes = useStyles();

    const searchHandler = (e) => {
        dispatch({ type: 'searchKeyword', payload: e.target.value }) 
    }

    const managerHandler = (e) => {
        dispatch({ type: 'managerFilter', payload: e.target.value })
    }

    const managerFilterIndicator = () => {
        if (state.managerFilter != 0) return (
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
            <input type='text' placeholder="Номер счета или организация" onChange={searchHandler} autoFocus defaultValue={state.searchKeyword}/>

            {/* filter data by manager */}
            { users && (<div className={sass.filter}>
            <span className={sass.filterPlaceholder}>manager</span>

                <FormControl className={classes.formControl}>
                <Select
                    name="managerFilter"
                    value={state.managerFilter}
                    onChange={managerHandler}
                    className={classes.select}
                    disableUnderline={true}
                >
                    <MenuItem value={0} className={classes.menuItem} >Все</MenuItem>
                    { users.map( (user) => 
                    <MenuItem  className={classes.menuItem} value={ user.UserID } key={user.UserID} > {`${user.FirstName} ${user.LastName}`} </MenuItem>
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