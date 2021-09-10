import { useContext, useReducer } from 'react'
import { useHistory } from "react-router-dom";

import { Context } from '../../index'
import { reducer, initialState } from './reducer';
import PropTypes from 'prop-types';
import { makeStyles, withStyles } from '@material-ui/core/styles';

// apollo
import { useSubscription, useQuery } from '@apollo/client'
import { GetOrdersSubscription } from './queries/getOrders'
import { GET_USERS } from '../../hasura-queries/getUsers'

// ui 
import {Tabs, Tab, Box} from '@material-ui/core';

import PreOrders from './PreOrders';
import Priority from './Priority';
import Recently from './Recently/index.jsx';
import ActionsHeader from '../BaseHeader/ActionsHeader'

const OrderListLayout = (props) => {
    const { store } = useContext(Context);
    const [state, dispatch] = useReducer(reducer, initialState(store.priorityTab));
    const { selectedTab } = state; 

    const history = useHistory();

    const onSubscriptionData = (options) => {
        let orders = []; let preOrders = [];
        options.subscriptionData.data.erp_Orders.forEach( (order) => {
            if (order.OrderStatus.ID == 1) preOrders.push(order)
            else if (order.OrderStatus.ID == 2) orders.push(order)
        })
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
    const tabHeight = '45px'
    const AntTabs = withStyles({
        root: {
            borderBottom: '1px solid var(--border)',
            minHeight: tabHeight,
            height: tabHeight,
        },
        indicator: {  
            borderTopLeftRadius: '20px',
            borderTopRightRadius: '20px',
            backgroundColor: 'var(--accent)',
        },
      })(Tabs);
      
      const AntTab = withStyles((theme) => ({
        root: {
          textTransform: 'none',
          minWidth: '10%',
          fontSize: '.9rem',
          color: 'var(--text1)',
          padding: 0,
          opacity: .5,
          minHeight: tabHeight,
          height: tabHeight,
          transition: 'opacity .3s ease',
          '&:hover': {
            opacity: 1,
          },
          '&$selected': {
                color: 'var(--accent)',
                backgroundColor: 'var(--accentLight)'
          }
        },
        selected: {},
      }))((props) => <Tab disableRipple {...props} />);

    const useStyles = makeStyles((theme) => ({
        root: {
            flexGrow: 1,
            minHeight: '50px',
            marginBottom: '1.5em',
        }
    }));

  const classes = useStyles();
    return(
        <div >
            
            <div className={classes.root}>
            <AntTabs value={selectedTab} onChange={tabHandler} aria-label="simple tabs example">
                <AntTab label="Предзаказы" {...a11yProps(0)} />
                <AntTab label="Очередость" {...a11yProps(1)} />
                <AntTab label="Недавние" {...a11yProps(2)} />

                <ActionsHeader createOrder={1} userID={store.user.UserID} history={history}/>
            </AntTabs>
            </div>



        <TabPanel value={selectedTab} index={0}>
            <PreOrders state={state} dispatch={dispatch}/>
        </TabPanel>

        <TabPanel value={selectedTab} index={1} >
            <Priority state={state} dispatch={dispatch} users={users.erp_Users} />
        </TabPanel>

        <TabPanel value={selectedTab} index={2}>
            <Recently state={state} dispatch={dispatch} />
        </TabPanel>
      </div>
    )
}
export default OrderListLayout