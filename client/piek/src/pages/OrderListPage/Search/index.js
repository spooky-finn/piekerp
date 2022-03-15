import sass from './search.module.sass'
import { FormControl, Select, MenuItem, Box } from '@mui/material';
import TableSearch from '../../..//components/TableSearch'

import { search_alg } from '../Search/filter';

const Search = ({ state, dispatch, users  }) => {
    const searchHandler = (e) => {

        var arr = [];
        var breifname;

        if (state.selectedTab === 0){
            arr = state.orders;
            breifname = 'orders'
        }
        else if (state.selectedTab === 1) {
            arr = state.preOrders;
            breifname = 'preOrders'
        }
       

        const adjacentSearch = search_alg(arr, e.target.value)
       
        dispatch({ 
            type: 'search.brief', payload: {
                ...state.search.breif,
                [breifname]: adjacentSearch.length
            }
        })

        dispatch({ type: 'searchKeyword', payload: e.target.value }) 
        dispatch({ type: 'search.keyword', payload: e.target.value }) 
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

    function briefOnClick(dispatch, brief){
        dispatch({
            type: 'selectedTab',
            payload: brief.showonTab,
        })
    }

    const briefSearch = () => ([
        {
            showonTab: 1,
            data: state.search.brief.orders,
            title: 'в очередности' ,
        },
        {
            showonTab: 0,
            data: state.search.brief.preOrders,
            title: 'в предзаказах' ,
        }
    ].map( el => {
        if (!state.search.keyword || !el.data) return null
        if (el.showonTab === state.selectedTab) return null;

        return ( <div 
            onClick={() => briefOnClick(dispatch, el) } 
            className={sass.adjacentSearchWrap }>
                {el.data} {el.title} 
            </div> )
        })
    )

    return (
        <>
        <Box sx={{ display: 'flex' }}>
            <TableSearch placeholder="Счет, контрагент" onChange={searchHandler} defaultValue={state.searchKeyword}/>
            {briefSearch()}

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