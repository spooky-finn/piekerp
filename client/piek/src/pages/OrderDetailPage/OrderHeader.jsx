import { useState, useRef } from "react";
import { Typography, Button, Box } from '@mui/material'
import { UilPlus, UilLock, UilUnlock, UilEllipsisH } from '@iconscout/react-unicons';

import OS from "../../utils/OrderStatus";
import US from "../../utils/UserStatus";


import OrderActionsMenu from "./OrderActions/OrderActionsMenu";

function orderStatus(data){
  // add a note to the title if this is a pre-order
  if (data.OrderStatusID === OS.ordRegistration) return ' Предзаказ';
  if (data.OrderStatusID === OS.ordArchived) return ' В архиве';
  if ([ OS.reclInbox, OS.reclDecision , OS.reclProduction, OS.reclArchived ].includes(data.OrderStatusID)) return ' Рекламация';
}

const OrderHeader = (props) => {
  const { data, editState, setEditState, setOIDialog, store, refetch } = props;
    
    //OrderActions Dropdown menu
    const [OAMenu, setOAMenu] = useState(false);
    const OAMenuRef = useRef(null);
      
  return(
    <div className="page-header">
        <Typography sx={{ fontWeight: 600, fontSize: '1rem'}}>
            {data.Entity} __ {data.City} 

            { orderStatus(data) ? <span className="preorderTitle">{orderStatus(data)}</span> : null}
        </Typography>

        {/* Показывать Кнопки редактирования заказа только для определенных групп юзеров */}
        <Box ml='auto' className='orderActions_box noprint'>
          {editState && 
          <Button 
          variant = "iconic" 
          onClick = {() => setOIDialog(true)}>
            <UilPlus/>
          </Button>
          }

        {/* Hamburger menu. Didnt shown when order into archive */}
        {![OS.ordArchived].includes(data.OrderStatusID)  &&
          <Button 
          aria-haspopup = "true" 
          ref           = {OAMenuRef} 
          variant       = "iconic" 
          onClick       = {() => setOAMenu(true)}>
              <UilEllipsisH/>
          </Button>
          }

        </Box>
        {/* locker */}
        <Box ml='10px' className='orderActions_box noprint' >
          {[ US.general, US.management , US.bookkeeping ].includes(store.user.AccessLevelID) && 
            <Button 
            variant = "iconic" 
            onClick = {() => setEditState(!editState)}>
                {editState ? <UilUnlock/> : <UilLock/> }
            </Button>
            }
        </Box>

        <OrderActionsMenu
          refetch   = {refetch}
          order     = {data}
          OAMenu    = {OAMenu} 
          setOAMenu = {setOAMenu}
          OAMenuRef = {OAMenuRef}
          />

  </div>

  
  )
}

export default OrderHeader;