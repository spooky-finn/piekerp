import { useContext, useReducer } from 'react'
import { useHistory } from "react-router-dom";

import { Context } from '../../index'
import { reducer, initialState } from './reducer';
import PropTypes from 'prop-types';

// apollo
import { useSubscription, useQuery, useMutation } from '@apollo/client'
import { GetOrdersSubscription } from './queries/getOrders'
import { GET_USERS } from '../../hasura-queries/getUsers'
import { INSERT_ORDER } from './queries/MutationInsertOrder';

// ui 
import {Tabs, Tab, Box, Button} from '@mui/material';
import { styled } from '@mui/material/styles';
import { UilPlusCircle } from '@iconscout/react-unicons';

import PreOrders from './PreOrders';
import Priority from './Priority';
import Recently from './Recently/index.jsx';
import Archive from './Archive/';

const StyledTabs = styled((props) => <Tabs {...props} />)(
  ({ theme }) => ({
    background: 'var(--LI)',
    minHeight: '10px',
    '& .MuiTabs-indicator': {
      display: 'none'
    },
  }),
  );

const StyledTab = styled((props) => <Tab {...props} />)(
    ({ theme }) => ({
      textTransform: 'none',
      fontWeight: 500,
      fontSize: theme.typography.pxToRem(14),
      borderRight: '1px solid transparent',
      borderLeft: '1px solid transparent',
      minHeight: '10px',
      color: 'var(--lowContrast)',
      '&.Mui-selected': {
        boxShadow: '0 0 15px 0px var(--shadow-color)',
        opacity: 1,
        backgroundColor: 'var(--L0)',
        color: 'var(--accent) !important',
        borderRight: 'var(--border)',
        borderLeft: 'var(--border)',
      },
      '&:first-of-type':{
        borderLeft: 'none !important',
      },
      '&.Mui-selected:first-of-type': {
        borderLeft: 'none !important',
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
    
    const { error, loading } = useSubscription(GetOrdersSubscription, { onSubscriptionData });
    if (error) console.error(error)
    
    const { data: users = []} = useQuery(GET_USERS);

    const [ createNewOrder] = useMutation(INSERT_ORDER, {variables: {
      'managerID':     store.user.UserID,
      'orderStatusID': 1,
    }})

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
            <Box mb='30px'>{children}</Box>
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
  
    const createOrderHandler = () => {
        createNewOrder().then( (res) => {
            history.push(`/orders/${res.data.insert_erp_Orders.returning[0].OrderID}?edit=true`)
        })
    }
  
    const styles = {
      adddtn: {
        marginLeft: 'auto',
        marginRight: '10px',
        display: 'flex',
        alignSelf: 'center',
      }
    }
    return(
        <>
        <StyledTabs value={selectedTab} onChange={tabHandler} aria-label="simple tabs example">
            <StyledTab label="Предзаказы" {...a11yProps(0)} />
            <StyledTab label="Очередость" {...a11yProps(1)} />
            <StyledTab label="Недавние"   {...a11yProps(2)} />
            <StyledTab label='Архив'      {...a11yProps(3)} />

           <Box style={styles.adddtn}>
            <Button onClick={createOrderHandler} variant='iconic'><UilPlusCircle /></Button>
           </Box>
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

      </>
    )
}
export default OrderListLayout