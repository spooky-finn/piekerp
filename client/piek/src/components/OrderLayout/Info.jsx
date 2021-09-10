import { UilHistoryAlt, UilBox} from "@iconscout/react-unicons";
import  moment  from 'moment'
import "./sass/order-meta.sass";

import {FormControlLabel, Checkbox} from '@material-ui/core';
import { makeStyles, withStyles } from '@material-ui/core/styles';

import { useMutation } from "@apollo/client"
import { UPDATE_AWAITING_DISPATCH } from './queries/MutationOrderInfo'
import { GET_ORDER_BY_ID } from "./queries/GetOrderByID";

const useStyles = makeStyles({
    formControlLabel: {
        width: '100%',
        height: 35,
        '& > span': {
            fontSize: '.8rem',
            color: 'var(--text2)',
        }
    },
})

const CustomCheckbox = withStyles({
    root: {
      margin: '0 10px',
      color: 'var(--text2)',
      opacity: .2,
      transition: 'none !important',
      '&$checked': {
        color: 'var(--text2)',
        opacity: 1,
      }
    },
    checked: {},
  })((props) => 
    <Checkbox 
    color="default"
    size="small"
    {...props} />);


const OrderMeta = ({ data, orderID }) => {
    
    const [mutateAwaitingDispatch] = useMutation(UPDATE_AWAITING_DISPATCH);

    const classes = useStyles();
    const setPaidPercent = (total, paid) => {
        if (!total || !paid) return ''
        return ' - ' + ((paid/total) * 100).toFixed(0) + '%'
    }

  return (
    <div className="Meta">

        <div className="SignificantInfo">
                <div>
                    <pre>План. отгрузка</pre>
                    {moment(data.ShippingDate).format('DD.MM.YY')}
                </div>
                <div>
                    <pre>Счет / оплата</pre>
                    {"№ " +
                    data.InvoiceNumber +
                    setPaidPercent(data.TotalAmount, data.PaidAmount)}
                        <span className="PaymentHistory">
                            <UilHistoryAlt />
                        </span>
                </div>
        </div>

        <div className="MetaWrapper">
            <div className='Left'>
                    <div>
                        <pre>Номер заказа</pre>
                        {data.OrderNumber}
                    </div>
                    <div>
                        <pre>Создан</pre>
                        {data.ShippingDate}
                    </div>
                    <div>
                        <pre>Менеджер</pre>
                        {data.User?.FirstName} {data.User?.LastName || 'undefined'}
                    </div>
            </div>

            <div className='Right'>
                        <div>
                            <pre>Юр Лицо</pre>
                            {data.Entity}
                        </div>
                        <div>
                            <pre>Гор</pre>
                            {data.City}
                        </div>
                </div>
        </div>

        <div className="OrderComment">
                <pre>Комментарий</pre>
                {data.Comment}
        </div>

        <div className="actions">
            <FormControlLabel
            className={classes.formControlLabel}
            control={
                <CustomCheckbox 
                 checked={data.AwaitingDispatch}
                 onChange={ () => {
                    // const updateCache = (cache, {data}) => {
                    //     const existing = cache.readQuery({
                    //         query: GET_ORDER_BY_ID,
                    //         variables: {
                    //             OrderID: orderID
                    //         }
                    //     })
                    //     cache.writeQuery({
                    //         query: GET_ORDER_BY_ID,
                    //         variables: {
                    //             OrderID: orderID
                    //         },
                    //         data: { 
                    //             erp_Orders: [existing.erp_Orders[0]]
                                 
                    //         }
                    //     })
                    //     console.log(cache.data.data.ROOT_QUERY, 'cahce')
                    //     console.log(data, 'existing')

                    // }

                    mutateAwaitingDispatch({
                        variables: {orderID, awaitingDispatch: !data.AwaitingDispatch },
                        // update: updateCache,
                        optimisticResponse: {
                            erp_Orders: {
                              __typename: 'erp_Orders',
                              OrderID: orderID,
                              AwaitingDispatch: !data.AwaitingDispatch
                            }
                          }
                    })
                 }}
                /> }
            label="Собран и ожидает отгрузки"
            />
        </div>

    </div>
  )
}

export default OrderMeta
