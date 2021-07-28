import { useContext } from "react";
import { Context } from "../..";
import {useParams } from "react-router-dom"
import { useQuery } from '@apollo/client'
import { GET_ORDER_BY_ID } from '../../hasura-queries/getOrderByID'
import ActionsHeader from "../BaseHeader/ActionsHeader";
import './index.sass'

import OrderComposition from "./OrderComposition";
import OrderMeta from "./OrderMeta";
import CheckList from './CheckList';
import Docs from './Docs';
import Comments from "./Comments";
import { Heading } from 'evergreen-ui';


const OrderLayout = (props) => {
    const {store} = useContext(Context);

    const {loading, error, data = [] } = useQuery(GET_ORDER_BY_ID, {  fetchPolicy: "no-cache", variables: { OrderID: useParams().id }});
    console.log('запрос ')


    return(
    <>
         <ActionsHeader/>

         {data.erp_Orders ? (<>

        <div className="page-header"><Heading>{data.erp_Orders[0].Entity} __  {data.erp_Orders[0].City}</Heading></div>

        <section className="OrderLayout">
                    <div className="Main">
                        <OrderComposition data={data.erp_Orders[0].OrderItems}/> 
                        <div className="WrapperTwoCol">

                            <div className="CheckList">
                                <CheckList data={data.erp_Orders[0].CheckListUnits}/>
                            </div>

                            <div className="Docs">
                                <Docs data={data.erp_Orders[0].Docs} />
                            </div>
                           
                        </div>
                       
                        {/* <Comments/> */}
                    </div>
                    <div className="Meta">
                         <OrderMeta data={data.erp_Orders[0]}/>
                    </div>
                   


        </section> 
              </>): store.preloader}

           
    </>
    )
}

export default OrderLayout