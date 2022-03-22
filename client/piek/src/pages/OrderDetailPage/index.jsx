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

    if (!data.erp_Orders) return <></>
    
    const childrens_props = { editState, store, refetch, orderID, 
        data: data.erp_Orders[0]
    }

    return(
    <div> 
        {isFileOnDropzone(isDragActive)}
        { data.erp_Orders && users.erp_Users ? (<>
        <section className='OrderLayout' {...getRootProps()} id='dropzone'>

            <div className='LeftSideContent'>

                <OrderHeader
                { ...childrens_props}
                setEditState = {setEditState}
                setOIDialog = {setOIDialog}
                />

                <Composition 
                { ...childrens_props}
                OIDialog    = {OIDialog}
                setOIDialog = {setOIDialog}
                 /> 

                <CommentsList 
                { ...childrens_props}
                user    = {store.user} 
                /> 

                <Docs 
                { ...childrens_props}
                onUpload  = {onUploadFiles} 
                />

            </div>

            <div className="Info">
                { editState? <EditRightInfoPanel 
                { ...childrens_props} 
                users     = {users.erp_Users} /> : (

                <RightInfoPanel 
                { ...childrens_props}
                />
                )}
            </div>
            
        </section> 
        </>): null }
    </div>
    )
}

export default OrderLayout