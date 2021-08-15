import { useContext, useCallback, useState } from "react";
import { Context } from "../..";
import {useDropzone} from 'react-dropzone'
import { useParams } from "react-router-dom"

//apollo
import { GET_ORDER_BY_ID } from '../../hasura-queries/getOrderByID'
import { PUSH_DOCS_ARRAY } from '../../hasura-queries/docs'
import { useMutation, useQuery } from "@apollo/client";

//components
import ActionsHeader from "../BaseHeader/ActionsHeader";
import OrderComposition from "./OrderComposition";
import OrderMeta from "./OrderMeta";
import CheckList from './CheckList';
import Docs from './Docs';
import Comments from "./Comments";
import { isFileOnDropzone } from "./Dropzone";

//ui
import { Heading } from 'evergreen-ui';
import './index.sass'





const OrderLayout = (props) => {
    const {store} = useContext(Context);
    const [onUploadFiles, setOnUploadFiles] = useState([])

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
                refetch()
                }
            
        )
      }, [])

      const {loading, error, data = [], refetch } = useQuery(GET_ORDER_BY_ID, {  fetchPolicy: "no-cache", variables: { OrderID: orderID}});

      const {getRootProps, isDragActive} = useDropzone({className: 'dropzone', onDrop: S3Upload });
  


    return(
    <>
        {isFileOnDropzone(isDragActive)}
         <ActionsHeader/>

        {!loading ? (<>

        <div className="page-header">
            <Heading>{data.erp_Orders[0].Entity} __  {data.erp_Orders[0].City}</Heading>
        </div>

        <section className="OrderLayout"  {...getRootProps()} id='dropzone'>

                    <div className="Main">

                        <OrderComposition data={data.erp_Orders[0].OrderItems}/> 
                        <div className="WrapperTwoCol">
                            <CheckList data={data.erp_Orders[0].CheckListUnits}/>
                            <Docs data={data.erp_Orders[0].Docs} onUpload={onUploadFiles} />
                        </div>
                        <Comments/>
                    </div>
                    
                    <OrderMeta data={data.erp_Orders[0]}/>
                   

       

        </section> 

        </>): store.preloader}

           
    </>
    )
}

export default OrderLayout