import { Button } from '@mui/material'
import Dialog from '@mui/material/Dialog'
import DialogActions from '@mui/material/DialogActions'
import DialogContent from '@mui/material/DialogContent'
import DialogContentText from '@mui/material/DialogContentText'
import DialogTitle from '@mui/material/DialogTitle'
import { ReactNode, useState } from 'react'
// extrnalСomponent is the whichever component which will be go out
// like as icon or textButton or something else
interface ConfirmDialogProps {
  title: string
  body: string
  confirmButtonLabel: string
  confirmButtonHandler(): void
  isDangerous?: boolean
  children?: ReactNode
}

export default function ConfirmDialog({
  confirmButtonLabel: confirmLabel,
  confirmButtonHandler: onCloseComplete,
  isDangerous,
  title,
  body,
  children
}: ConfirmDialogProps) {
  const [open, setOpen] = useState(false)

  const handleClickOpen = () => {
    setOpen(true)
  }

  const handleClose = () => {
    setOpen(false)
  }

  return (
    <>
      <div onClick={handleClickOpen}> {children} </div>

      <Dialog id={title} open={open} maxWidth="xs" onClose={handleClose}>
        <DialogTitle> {title} </DialogTitle>
        <DialogContent>
          <DialogContentText p={1}>{body}</DialogContentText>
        </DialogContent>
        <DialogActions>
          <Button color="info" key="dialog-close-btn" onClick={() => handleClose()}>
            Отмена
          </Button>
          <Button
            color={isDangerous ? 'secondary' : 'primary'}
            variant="contained"
            key="dialog-target-btn"
            onClick={() => {
              handleClose()
              onCloseComplete()
            }}
          >
            {confirmLabel}
          </Button>
        </DialogActions>
      </Dialog>
    </>
  )
}
