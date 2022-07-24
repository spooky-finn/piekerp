import Button from '@mui/material/Button';
import Dialog from '@mui/material/Dialog';
import DialogActions from '@mui/material/DialogActions';
import DialogContent from '@mui/material/DialogContent';
import DialogContentText from '@mui/material/DialogContentText';

export default function ConfirmDialog(props) {
  const { filename, open, handleClose } = props
  return (
    <div>
      <Dialog
        open={open}
        minWidth='xs'

        onClose={handleClose}
        aria-labelledby="alert-dialog-title"
        aria-describedby="alert-dialog-description"
      >
        <DialogContent>
          <DialogContentText id="alert-dialog-description" sx={{
            color: 'var(--lowContrast) !important',
            'span': {
              color: 'var(--highContrast) !important'
            }
          }}>
            Удалить <span>{filename}</span> ?
          </DialogContentText>
        </DialogContent>
        <DialogActions>
          <Button color='info' onClick={handleClose}>Отменить</Button>
          <Button color='secondary' onClick={() => {
            handleClose()
            props.onConfirmF()
          }}>
            Удалить
          </Button>
        </DialogActions>
      </Dialog>
    </div>
  );
}