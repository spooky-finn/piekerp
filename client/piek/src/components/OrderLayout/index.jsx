import { useContext, useCallback, useState } from "react";
import { Context } from "../..";
import {useDropzone} from 'react-dropzone'
import { useParams, useLocation } from "react-router-dom"

//apollo
import { GET_ORDER_BY_ID } from './queries/GetOrderByID'
import { PUSH_DOCS_ARRAY } from './queries/MutationOrderDocs'
import { useMutation, useQuery } from "@apollo/client";

//components
import ActionsHeader from "../BaseHeader/ActionsHeader";
import Composition from "./Composition";
import Info from "./Info";
import EditableInfo from "./EditableComponents/EditableInfo";
import CheckList from './CheckList';
import Docs from './Docs';
import Comments from "./Comments";
import { isFileOnDropzone } from "./Dropzone";

//ui
import { Heading } from 'evergreen-ui';
import './sass/index.sass';

import { motion } from "framer-motion"




const OrderLayout = (props) => {
    const {store} = useContext(Context);
    const [onUploadFiles, setOnUploadFiles] = useState([])

    const editStateQueryArg = new URLSearchParams(useLocation().search).get('edit')
    const [editState, setEditState] = useState(editStateQueryArg)
    const [pushDocs] = useMutation(PUSH_DOCS_ARRAY);
    const orderID = useParams().id

    const S3Upload = useCallback(acceptedFiles => {
        setOnUploadFiles(acceptedFiles)

        store.uploadFile(acceptedFiles).then(
            (res) => {
                if (res.status != 200) console.log('S3 file upload error')
                else{
                    let m = []
                    for (var i=0;  i<res.data.length; i=i+2 ){
                        m.push({
                            'Key': res.data[i].key,
                            'OrderID': orderID,
                            'FileName': res.data[i].originalname,
                        })
                    }
                    pushDocs({ variables: {'objects': m} })
                } 
                setOnUploadFiles([])
                refetch();
                }
            
        )
      }, [])

    const {loading, error, data = [], refetch } = useQuery(GET_ORDER_BY_ID, { variables: { OrderID: orderID}});

    const {getRootProps, isDragActive} = useDropzone({className: 'dropzone', onDrop: S3Upload });
  
    return(
    <motion.div
    initial={{ scale: .85 }} 
    animate={{ scale: 1 }}
    transition={{ duration: 0.2 }}
    > 


    
            {isFileOnDropzone(isDragActive)}

        {!loading ? (<>

        <div className="page-header">
            <Heading>{data.erp_Orders[0].Entity} __  {data.erp_Orders[0].City}</Heading>

            <ActionsHeader 
            accessLevel = {2} 
            setEditState = {setEditState} 
            editState = {editState} />
            
        </div>

        <section className='OrderLayout' {...getRootProps()} id='dropzone'>

                    <div className="Main">

                    <div className="Composition">  
                        <Composition 
                            data={data.erp_Orders[0].OrderItems} 
                            editState={editState}
                            refetch={refetch}
                            orderID= {orderID} /> 

                    </div>
                    
                        <div className="WrapperTwoCol">
                            <CheckList data={data.erp_Orders[0].CheckListUnits}/>
                            <Docs data={data.erp_Orders[0].Docs} 
                                onUpload={onUploadFiles} 
                                editState = {editState} 
                                refetch={refetch} />
                        </div>
                        <Comments/>
                    </div>
                    
                    { editState ? <EditableInfo data={data.erp_Orders[0]} orderID={orderID} refetch={refetch}/> : (
                                  <Info data={data.erp_Orders[0]} editState = {editState} orderID={orderID}/> )}
                   

       

        </section> 

        </>): null }

    </motion.div>
    )
}

export default OrderLayout