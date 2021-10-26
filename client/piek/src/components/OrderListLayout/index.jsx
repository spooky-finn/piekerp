import { useContext, useReducer } from 'react'
import { useHistory } from "react-router-dom";

import { Context } from '../../index'
import { reducer, initialState } from './reducer';
import PropTypes from 'prop-types';

// apollo
import { useSubscription, useQuery } from '@apollo/client'
import { GetOrdersSubscription } from './queries/getOrders'
import { GET_USERS } from '../../hasura-queries/getUsers'

// ui 
import {Tabs, Tab, Box} from '@mui/material';
import { styled } from '@mui/material/styles';

import mainsass from './main.module.sass'

import PreOrders from './PreOrders';
import Priority from './Priority';
import Recently from './Recently/index.jsx';
import ActionsHeader from '../BaseHeader/ActionsHeader'
import Archive from './Archive/';

const StyledTabs = styled((props) => <Tabs {...props} />)(
  ({ theme }) => ({
    margin: '0 0 1rem',
    '& .MuiTabs-indicator': {
      display: 'none'
    },
  }),
  );

const StyledTab = styled((props) => <Tab {...props} />)(
    ({ theme }) => ({
      textTransform: 'none',
      fontWeight: 400,
      color: theme.palette.text.secondary,
      fontSize: theme.typography.pxToRem(15),
      marginRight: theme.spacing(1),
      borderBottomRightRadius: '8px',
      borderBottomLeftRadius: '8px',
      border: '1px solid transparent',
      '&.Mui-selected': {
        backgroundColor: 'var(--L1)',
        color: theme.palette.primary,
        border: '1px solid var(--borderLight)'
      }
    }),
  );


const OrderListLayout = (props) => {
    const { store } = useContext(Context);
    const [state, dispatch] = useReducer(reducer, initialState( store.priorityTab, store.cachedOrders, store.cachedPreOrders ));
    const { selectedTab } = state; 

    const history = useHistory();

    const onSubscriptionData = (options) => {
  
        options.subscriptionData.data.erp_Orders.sort(function(a,b){
            // Turn your strings into dates, and then subtract them
            // to get a value that is either negative, positive, or zero.
            return new Date(a.ShippingDate) - new Date(b.ShippingDate);
          });

        let orders = []; let preOrders = [];
        options.subscriptionData.data.erp_Orders.forEach( (order) => {
            if (order.OrderStatus.ID === 1) preOrders.push(order)
            else if (order.OrderStatus.ID === 2) orders.push(order)
        })
        store.setCachedOrders(orders)
        store.setCachedPreOrders(preOrders)

        dispatch({ type: 'preOrders', payload: preOrders });
        dispatch({ type: 'orders', payload: orders })
    }
    
    useSubscription(GetOrdersSubscription, { onSubscriptionData,  fetchPolicy: "cache-first", nextFetchPolicy: "cache-first" });
    const { data: users = []} = useQuery(GET_USERS);

    const tabHandler = (event, newValue) => {
        dispatch({ type: 'selectedTab', payload: newValue })
        dispatch({ type: 'resetFilters'})
        store.setPriorutyTab(newValue)
    };

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
            <Box>{children}</Box>
            )}
        </div>
        );
    }
    
    TabPanel.propTypes = {
        children: PropTypes.node,
        index: PropTypes.any.isRequired,
        value: PropTypes.any.isRequired,
    };
  
    function a11yProps(index) {
        return {
        id: `simple-tab-${index}`,
        'aria-controls': `simple-tabpanel-${index}`,
        };
    }
    
    return(
        <div className={mainsass.OrderListLayout}>
        <StyledTabs value={selectedTab} onChange={tabHandler} aria-label="simple tabs example" className='orderListLayoutTabs'>
            <StyledTab label="Предзаказы" {...a11yProps(0)} />
            <StyledTab label="Очередость" {...a11yProps(1)} />
            <StyledTab label="Недавние"   {...a11yProps(2)} />
            <StyledTab label='Архив'      {...a11yProps(3)} />
            <ActionsHeader createOrder={1} userID={store.user.UserID} history={history}/>
        </StyledTabs>


        <TabPanel value={selectedTab} index={0}>
            <PreOrders state={state} dispatch={dispatch}/>
        </TabPanel>

        <TabPanel value={selectedTab} index={1} >
            <Priority state={state} dispatch={dispatch} users={users.erp_Users} />
        </TabPanel>

        <TabPanel value={selectedTab} index={2}>
            <Recently state={state} dispatch={dispatch} />
        </TabPanel>

        <TabPanel value={selectedTab} index={3}>
            <Archive state={state} dispatch={dispatch} />
        </TabPanel>

      </div>
    )
}
export default OrderListLayout