import { useContext, useReducer } from 'react'
import { useHistory } from "react-router-dom";

import { Context } from '../../index'
import { reducer, initialState } from './reducer';
import PropTypes from 'prop-types';
import { makeStyles, withStyles } from '@material-ui/core/styles';

// apollo
import { useSubscription, useQuery } from '@apollo/client'
import { GetOrdersSubscription, GET_USERS } from './queries/getOrders'

// ui 
import {Tabs, Tab, Box} from '@material-ui/core';

import PreOrders from './PreOrders';
import Priority from './Priority';
import Recently from './Recently/index.jsx';
import ActionsHeader from '../BaseHeader/ActionsHeader'

var incomingOrders = undefined;


const OrderListLayout = () => {
    const { store } = useContext(Context);
    const [state, dispatch] = useReducer(reducer, initialState(store.priorityTab));
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
    const { loading, error, data = [] } = useSubscription(GetOrdersSubscription, { onSubscriptionData, fetchPolicy: "cache-and-network", nextFetchPolicy: "cache-first" });
    const { data: users = []} = useQuery(GET_USERS);

    const tabHandler = (event, newValue) => {
        dispatch({ type: 'selectedTab', payload: newValue })
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
            borderBottom: '1px solid var(--borderLight)',
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
            minHeight: '50px'
        }
    }));

  const classes = useStyles();
    return(
        <div >
            
            <div className={classes.root}>
            <AntTabs value={state.selectedTab} onChange={tabHandler} aria-label="simple tabs example">
                <AntTab label="Очередость" {...a11yProps(0)} />
                <AntTab label="Недавние" {...a11yProps(1)} />

                <ActionsHeader createOrder={1} userID={store.user.UserID} history={history}/>

            </AntTabs>
            </div>


        <PreOrders preOrders = {state.preOrders} />

        <TabPanel value={state.selectedTab} index={0} >
            <Priority data={state.orders}
                    state={state}
                    dispatch={dispatch}
                    users={users.erp_Users}
                    incomingOrders={incomingOrders} />
        </TabPanel>

        <TabPanel value={state.selectedTab} index={1}>
            <Recently data={state.orders}
                    state={state}
                    dispatch={dispatch}
                    incomingOrders={incomingOrders} />
        </TabPanel>
      </div>
    )
}
export default OrderListLayout