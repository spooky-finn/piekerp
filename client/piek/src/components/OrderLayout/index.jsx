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
import OrderActionsMenu from "./OrderActions/OrderActionsMenu";

import { isFileOnDropzone } from "./Dropzone";

//ui
import './sass/index.sass';
import { Typography, Button, Box } from '@mui/material'
import { UilPlus, UilLock, UilUnlock, UilEllipsisH } from '@iconscout/react-unicons';
import OS from "../_core/OrderStatus";
import US from "../_core/UserStatus";

function orderStatus(data){
    // add a note to the title if this is a pre-order
    if (data.OrderStatusID === OS.ordRegistration) return ' | Предзаказ';
    if (data.OrderStatusID === OS.ordArchived) return ' | В архиве';
    if ([ OS.reclInbox, OS.reclDecision , OS.reclProduction ].includes(data.OrderStatusID)) return ' | Рекламация';
}

const OrderLayout = (props) => {
    const {store} = useContext(Context);
    const [onUploadFiles, setOnUploadFiles] = useState([])

    const editStateQueryArg = new URLSearchParams(useLocation().search).get('edit')
    const [editState, setEditState] = useState(editStateQueryArg)
    // Add new Order Item Dialog
    const [OIDialog, setOIDialog] = useState(false)

    //OrderActions Dropdown menu
    const [OAMenu, setOAMenu] = useState(false);
    const OAMenuRef = useRef(null);

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
    
    function showOrderActions(){
        if ([ US.general, US.management , US.bookkeeping ].includes(store.user.AccessLevelID)) return true
    }

    return(
    <div> 
        {isFileOnDropzone(isDragActive)}
        { data.erp_Orders && users.erp_Users ? (<>
        <section className='OrderLayout' {...getRootProps()} id='dropzone'>

          <div className='LeftSideContent'>

              <div className="page-header">
                <Typography sx={{ fontWeight: 600, fontSize: '1rem'}}>
                    {data.erp_Orders[0].Entity} __ {data.erp_Orders[0].City} 
                    <span className="preorderTitle">{orderStatus(data.erp_Orders[0])}</span>
                </Typography>

                {/* Показывать Кнопки редактирования заказа только для определенных групп юзеров */}
                { <Box className='orderActions_box noprint'>
                  {editState && 
                  <Button 
                  variant = "iconic" 
                  onClick = {() => setOIDialog(true)}>
                    <UilPlus/>
                  </Button>
                  }
                  
                 {[ US.general, US.management , US.bookkeeping ].includes(store.user.AccessLevelID) && 
                  <Button 
                  variant = "iconic" 
                  onClick = {() => setEditState(!editState)}>
                      {editState ? <UilUnlock/> : <UilLock/> }
                  </Button>
                }

                {/* Hamburger menu. Didnt shown when order into archive */}
                {[OS.ordRegistration, OS.ordProduction].includes(data.erp_Orders[0].OrderStatusID)  &&
                  <Button 
                  aria-haspopup = "true" 
                  ref           = {OAMenuRef} 
                  variant       = "iconic" 
                  onClick       = {() => setOAMenu(true)}>
                      <UilEllipsisH/>
                  </Button>
                  }

                </Box>
                }
              </div>

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

          <OrderActionsMenu
          refetch   = {refetch}
          order     = {data.erp_Orders[0]}
          OAMenu    = {OAMenu} 
          setOAMenu = {setOAMenu}
          OAMenuRef = {OAMenuRef}
          />

        </section> 
        </>): null }
    </div>
    )
}

export default OrderLayout