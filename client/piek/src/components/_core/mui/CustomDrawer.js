import { useState } from "react"

import Drawer from '@mui/material/Drawer';
import Box from '@mui/material/Box';
import List from '@mui/material/List';



const CustomDrawer = props => {
  const { icon, children, width = 400 } = props
  const [state, setState] = useState(false)

  const toggleDrawer = (open) => (event) => {
    setState(open);
  };

  return(<>
    <div onClick={toggleDrawer(true)}>
      {icon}
    </div>

    <Drawer
    open={state}
    onClose={toggleDrawer(false)}
    >
      <Box
      sx={{ width: width }}
      role="presentation"
      onKeyDown={toggleDrawer(false)}
    >
      <List>
        {children}
      </List>
    </Box>
      
    </Drawer>
  </>)
}
export default CustomDrawer;