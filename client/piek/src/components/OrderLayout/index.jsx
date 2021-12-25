import { useContext, useCallback, useState, useRef } from "react";
import { Context } from "../..";
import {useDropzone} from 'react-dropzone'
import { useParams, useLocation } from "react-router-dom"

//apollo
import { GET_USERS }             from '../../hasura-queries/getUsers';
import { GET_ORDER_BY_ID }       from './queries/GetOrderByID'
import { PUSH_DOCS_ARRAY }       from './queries/MutationOrderDocs'
import { useMutation, useQuery } from "@apollo/client";

//components
import Composition      from "./Composition";
import RightInfoPanel             from "./RightInfoPanel/";
import EditRightInfoPanel     from "./RightInfoPanel/EditRightInfoPanel";
import Docs             from './Docs/Docs';
import CommentsList     from "./Comments/CommentsList";
import OrderHeader      from "./OrderHeader"

import { isFileOnDropzone } from "./Dropzone";

//ui
import './sass/index.sass';

import US from "../_core/UserStatus";



const OrderLayout = (props) => {
    const {store} = useContext(Context);
    const [onUploadFiles, setOnUploadFiles] = useState([])

    const editStateQueryArg = new URLSearchParams(useLocation().search).get('edit')
    const [editState, setEditState] = useState(editStateQueryArg)
    // Add new Order Item Dialog
    const [OIDialog, setOIDialog] = useState(false)


    const [pushDocs] = useMutation(PUSH_DOCS_ARRAY);
    const orderID = useParams().id

    const S3Upload = useCallback(acceptedFiles => {
        setOnUploadFiles(acceptedFiles)

        store.uploadFile(acceptedFiles).then(
            (res) => {
                if (res.status !== 200) console.log('S3 file upload error')
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

    var { data = [], refetch } = useQuery(GET_ORDER_BY_ID, { variables: { OrderID: orderID} });
    const { data: users = []} = useQuery(GET_USERS);
    const {getRootProps, isDragActive} = useDropzone({className: 'dropzone', onDrop: S3Upload });
    
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

              <div className="Composition">  
                <Composition 
                  data        = {data.erp_Orders[0].OrderItems} 
                  editState   = {editState}
                  refetch     = {refetch}
                  OIDialog    = {OIDialog}
                  setOIDialog = {setOIDialog}
                  orderID     = {orderID} /> 
              </div>

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
            orderID   = {orderID} 
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