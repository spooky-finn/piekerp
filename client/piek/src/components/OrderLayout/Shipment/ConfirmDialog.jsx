import * as React from 'react';
import Button from '@mui/material/Button';
import Dialog from '@mui/material/Dialog';
import DialogActions from '@mui/material/DialogActions';
import DialogContent from '@mui/material/DialogContent';
import DialogContentText from '@mui/material/DialogContentText';
import DialogTitle from '@mui/material/DialogTitle';

export default function ConfirmDialog(props) {
  const [open, setOpen] = React.useState(false);

  const handleClickOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };

  return (
    <div>
      <Button variant='outlined' onClick={handleClickOpen} sx={{ fontSize: '.8rem !important'}}>
        Отгружен
      </Button>
      <Dialog
        open={open}
        maxWidth='xs'
        onClose={handleClose}
        aria-labelledby="alert-dialog-title"
        aria-describedby="alert-dialog-description"
      >
        <DialogTitle id="alert-dialog-title">
          Перенести в архив?
        </DialogTitle>
        <DialogContent>
          <DialogContentText id="alert-dialog-description">
            Заказ удалится из очередности, но его в любое время можно будет найти в архиве по номеру счета, юрлицу, маркировке привода.
          </DialogContentText>
        </DialogContent>
        <DialogActions>
          <Button color='info' onClick={handleClose}>Отменить</Button>
          <Button color='secondary' onClick={()=> {
            handleClose()
            props.onConfirmF()
          }}>
            Перенести 
          </Button>
        </DialogActions>
      </Dialog>
    </div>
  );
}