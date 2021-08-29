import { useMemo, useContext, useReducer } from 'react'
import { Context } from '../../index'
import { useHistory } from "react-router-dom";

//apollo
import { useSubscription, useQuery } from '@apollo/client'
import { GetOrdersSubscription, GET_USERS } from '../../hasura-queries/getOrders'

import Table, { columnsList } from './tableLogic'

//components
import PreOrders from '../PreOrders'
import BaseHeader from '../BaseHeader'
import ActionsHeader from '../BaseHeader/ActionsHeader'
import RecentlyLayout from '../RecentlyLayout';
import ManagerFilter, { managerFilterIndicator } from './ManagerFilter';
//UI
import './index.sass'
import { UilSearch } from '@iconscout/react-unicons'
import {Tabs, Tab, Box, Typography} from '@material-ui/core';

var incomingOrders = undefined;

function reducer(state, action) {
    switch (action.type) {
        case 'orders':
        case 'preOrders': 
        case 'priorityTab': 
        case 'searchKeyword': 
        case 'managerFilter': 
        case 'filtredOrders':
            return {...state, [action.type]: action.payload };

    }
}

function filteringAlg(keyword, ...rest){
    var finded = false
    rest.map( (arg) => {
        if (arg && arg.toLowerCase().includes(keyword.toLowerCase())) finded = true
    })
   
    if (finded) return true 
    else return false
}

function TabPanel(props) {
    const { children, value, index, ...other } = props;
  
    return (
      <div
        role="tabpanel"
        hidden={value !== index}
        id={`simple-tabpanel-${index}`}
        aria-labelledby={`simple-tab-${index}`}
        {...other}
      >
        {value === index && (
          <Box p={3}>
            <Typography component={'div'}>{children}</Typography>
          </Box>
        )}
      </div>
    );
  }

  function a11yProps(index) {
    return {
      id: `simple-tab-${index}`,
      'aria-controls': `simple-tabpanel-${index}`,
    };
  }
  


const PriorityLayout = () => {
    const { store } = useContext(Context);

    const [state, dispatch] = useReducer(reducer, {
        orders: [],
        preOrders: [],
        priorityTab : store.priorityTab,
        searchKeyword: '',
        managerFilter: 0,
        filtredOrders: [],
    });

    const {orders, preOrders, priorityTab} = state;

    const history = useHistory();

    const onSubscriptionData = (options) => {
        let orders = []; let preOrders = [];
        options.subscriptionData.data.erp_Orders.forEach( (order) => {
            if (order.OrderStatus.ID == 3) preOrders.push(order)
            else if (order.OrderStatus.ID == 1) orders.push(order)
        })
        incomingOrders = orders
        dispatch({ type: 'preOrders', payload: preOrders });
        dispatch({ type: 'orders', payload: orders })
    }

    const columns = useMemo(
        () => columnsList, []
    )
    
    const { data: users = []} = useQuery(GET_USERS);

    const tabHandler = (event, newValue) => {
        dispatch({ type: 'priorityTab', payload:newValue })
        store.setPriorutyTab(newValue)
      };

    const getFiltredData = () => {
        const sword = state.searchKeyword;
        var result = [];

        // применить поиск по ключевому слову
        if (sword !== '') {
            result = incomingOrders.filter( (order) => filteringAlg(sword, order.InvoiceNumber, order.Entity ))         
        }
        else result = incomingOrders
    

         //применить поиск по фильру
        if (state.managerFilter != 0){
            var newOrders = []
            result.map( (ord) => {
                if (ord.ManagerID == state.managerFilter) newOrders.push(ord)
            })
            return newOrders
        }
        else return result
        

    }


    const searchHandler = (e) => dispatch({ type: 'searchKeyword', payload: e.target.value.trim() }) 

    const { loading, error, data = [] } = useSubscription(GetOrdersSubscription, { onSubscriptionData, fetchPolicy: "cache-and-network", nextFetchPolicy: "cache-first" });

    return ( 
        <div>
            <BaseHeader pageParams = { store.getPageParams(window.location.pathname) }>
                <ActionsHeader createOrder={1} userID={store.user.UserID} history={history}/>
            </BaseHeader>
        
                    <PreOrders preOrders = { preOrders }/>

                    <div  className='priorityTabs'>
                        <Tabs value={priorityTab} onChange={tabHandler} aria-label="simple tabs example"  indicatorColor="primary">
                            <Tab label="Очередность" {...a11yProps(0)} />
                            <Tab label="Недавние" {...a11yProps(1)} />
                        </Tabs>
                    </div>
                    

                    <TabPanel value={priorityTab} index={0}>
                        <div className="tableWrap">

                            <div className="tableSearchInput">
                                <UilSearch className="action-icon"/>
                                <input type='text' placeholder="поиск (номер счета или организация)" onChange={searchHandler} autoFocus/>
                                <ManagerFilter dispatch={dispatch} state={state} users={users.erp_Users} incomingOrders={incomingOrders} />

                            </div>
                                {managerFilterIndicator(state.managerFilter)}

                            {incomingOrders && <Table columns = { columns } data = { getFiltredData() }/>}
                        </div>
                    </TabPanel>

                    <TabPanel value={priorityTab} index={1} className="recentlyLayout" >
                        <RecentlyLayout data={data} />
                    </TabPanel>
        </div>
    )
}
export default PriorityLayout;