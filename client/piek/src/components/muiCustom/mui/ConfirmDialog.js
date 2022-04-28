import { useState } from 'react';
import Dialog from '@mui/material/Dialog';
import DialogActions from '@mui/material/DialogActions';
import DialogContent from '@mui/material/DialogContent';
import DialogContentText from '@mui/material/DialogContentText';
import DialogTitle from '@mui/material/DialogTitle';
import { Button } from '@mui/material';
 // extrnalСomponent is the whichever component which will be go out 
// like as icon or textButton or something else 
export default function ConfirmDialog(props) {   
    const { confirmLabel, onCloseComplete, isDangerous, title, body, children } = props

    const [open, setOpen] = useState(false);

    const handleClickOpen = () => {
        setOpen(true);
    };

    const handleClose = () => {
        setOpen(false);
    };

    return (<>
    <div onClick={handleClickOpen}> {children} </div>

    <Dialog
      id={title}
      open={open}
      maxWidth='xs'
      onClose={handleClose}
    >
        <DialogTitle> {title} </DialogTitle>
        <DialogContent>
            <DialogContentText p={1}>
                {body}
            </DialogContentText>
        </DialogContent>
        <DialogActions>
            <Button color='info' key="dialog-close-btn" onClick={()=> handleClose()}>Отмена</Button>
            <Button color={isDangerous? 'secondary': 'primary'} key="dialog-target-btn" onClick={() => { handleClose(); onCloseComplete()}} >{confirmLabel}</Button>
        </DialogActions>
    </Dialog>
  </>);
}