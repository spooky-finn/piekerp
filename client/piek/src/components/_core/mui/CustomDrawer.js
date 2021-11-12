import Drawer from '@mui/material/Drawer';
import Box from '@mui/material/Box';

const CustomDrawer = props => {
  const { icon, children, width = 400, state, toggleDrawer } = props
 
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
        {children}
      </Box>
    </Drawer>
  </>)
}

export default CustomDrawer;