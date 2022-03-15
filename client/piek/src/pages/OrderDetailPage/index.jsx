import { useContext, useCallback, useState } from "react";
import { Context } from "../..";
import {useDropzone} from 'react-dropzone'
import { useParams, useLocation } from "react-router-dom"

//apollo
import { GET_USERS } from '../../hasura-queries/getUsers';
import { GET_ORDER_BY_ID } from './queries/GetOrderByID'
import { useQuery } from "@apollo/client";

//components
import Composition from "./Composition";
import RightInfoPanel from "./RightInfoPanel/";
import EditRightInfoPanel from "./RightInfoPanel/EditRightInfoPanel";
import Docs from './Docs/Docs';
import CommentsList from "./Comments/CommentsList";
import OrderHeader from "./OrderHeader"

import { isFileOnDropzone } from "./Dropzone";

//ui
import './sass/index.sass';

import S3Service from "../../services/S3Service";

const OrderLayout = (props) => {
    const {store} = useContext(Context);
    const [onUploadFiles, setOnUploadFiles] = useState([])

    const editStateQueryArg = new URLSearchParams(useLocation().search).get('edit')
    const [editState, setEditState] = useState(editStateQueryArg)
    // Add new Order Item Dialog
    const [OIDialog, setOIDialog] = useState(false)


    const orderID = useParams().id

    const fileUploader = useCallback(async acceptedFiles => {
        setOnUploadFiles(acceptedFiles)

        const res = await S3Service.uploadFile(acceptedFiles, orderID);

        if (res.status === 200){
            refetch();
        }
        else {
            console.log('S3 file upload error', res)
            refetch();
        };

        setOnUploadFiles([])
      }, [])

    var { data = [], refetch } = useQuery(GET_ORDER_BY_ID, { variables: { OrderID: orderID} });
    const { data: users = []} = useQuery(GET_USERS);
    
    const { getRootProps, isDragActive } = useDropzone({className: 'dropzone', onDrop: fileUploader });
    
    return(
    <div> 
        {isFileOnDropzone(isDragActive)}
        { data.erp_Orders && users.erp_Users ? (<>
        <section className='OrderLayout' {...getRootProps()} id='dropzone'>

            <div className='LeftSideContent'>

                <OrderHeader
                data = {data.erp_Orders[0]}
                editState = {editState}
                setEditState = {setEditState}
                setOIDialog = {setOIDialog}
                store = {store}
                refetch = {refetch}
                />

                <Composition 
                data        = {data.erp_Orders[0].OrderItems} 
                editState   = {editState}
                refetch     = {refetch}
                OIDialog    = {OIDialog}
                setOIDialog = {setOIDialog}
                orderID     = {orderID} /> 

                <CommentsList 
                orderID = {orderID} 
                user    = {store.user} 
                data    = {data.erp_Orders[0].Comments}/> 

                <Docs 
                data      = {data.erp_Orders[0].Docs} 
                onUpload  = {onUploadFiles} 
                editState = {editState} 
                refetch   = {refetch} />

            </div>

            <div className="Info">
                { editState? <EditRightInfoPanel 
                data      = {data.erp_Orders[0]} 
                OrderID   = {orderID} 
                refetch   = {refetch} 
                users     = {users.erp_Users} /> : (

                <RightInfoPanel 
                data      = {data.erp_Orders[0]} 
                editState = {editState} 
                orderID   = {orderID} 
                />
                )}
            </div>
            
        </section> 
        </>): null }
    </div>
    )
}

export default OrderLayout