import { useContext, useCallback, useState } from "react";
import { Context } from "../..";
import {useDropzone} from 'react-dropzone'
import { useParams, useLocation } from "react-router-dom"

//apollo
import { GET_USERS } from '../../hasura-queries/getUsers';
import { GET_ORDER_BY_ID } from './queries/GetOrderByID'
import { PUSH_DOCS_ARRAY } from './queries/MutationOrderDocs'
import { useMutation, useQuery } from "@apollo/client";

//components
import ActionsHeader from "../BaseHeader/ActionsHeader";
import Composition from "./Composition";
import Info from "./Info";
import EditableInfo from "./EditableComponents/EditableInfo";
import CheckList from './CheckList/CheckList';
import Docs from './Docs/Docs';
import CommentsList from "./Comments/CommentsList";
import { isFileOnDropzone } from "./Dropzone";

//ui
import { Heading } from 'evergreen-ui';
import './sass/index.sass';

function orderStatus(data){
    // add a note to the title if this is a pre-order
    if (data.OrderStatusID === 1) return ' | Предзаказ';
    if (data.OrderStatusID === 3) return ' | В архиве';
}

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

    const { data = [], refetch } = useQuery(GET_ORDER_BY_ID, { variables: { OrderID: orderID} });
    const { data: users = []} = useQuery(GET_USERS);
    const {getRootProps, isDragActive} = useDropzone({className: 'dropzone', onDrop: S3Upload });
      
    return(
    <div> 
        {isFileOnDropzone(isDragActive)}
        { data.erp_Orders ? (<>
        <section className='OrderLayout' {...getRootProps()} id='dropzone'>

                <div className='LeftSideContent'>

                    <div className="page-header">
                        <Heading>
                            {data.erp_Orders[0].Entity} __ {data.erp_Orders[0].City} 
                            <span className="preorderTitle">{orderStatus(data.erp_Orders[0])}</span>
                        </Heading>

                        <ActionsHeader 
                        accessLevel = {2} 
                        setEditState = {setEditState} 
                        editState = {editState} />
                        
                    </div>

                    <div className="Composition">  
                      <Composition 
                          data={data.erp_Orders[0].OrderItems} 
                          editState={editState}
                          refetch={refetch}
                          orderID= {orderID} /> 
                    </div>

                    <CommentsList 
                    orderID={orderID} 
                    user={store.user} 
                    data={data.erp_Orders[0].Comments}/> 

                    <Docs data={data.erp_Orders[0].Docs} 
                    onUpload={onUploadFiles} 
                    editState = {editState} 
                    refetch={refetch} />

                    <CheckList data={data.erp_Orders[0].CheckListUnits} OrderID={orderID} />
                     
                </div>
                <div className="Info">
                  {editState? <EditableInfo data={data.erp_Orders[0]} orderID={orderID} refetch={refetch} users={users.erp_Users} /> : (
                              <Info data={data.erp_Orders[0]} editState = {editState} orderID={orderID} />)}
                </div>
        </section> 

        </>): null }

    </div>
    )
}

export default OrderLayout