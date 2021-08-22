import { useContext, useState, useRef } from 'react';
import { Context } from '../../index'

//apollo
import { useMutation } from '@apollo/client';
import { DELETE_ORDER_FILE } from './queries/MutationOrderDocs';

import { Dialog, Button, TextField, DialogActions, DialogContent, DialogContentText } from '@material-ui/core';

const Docs = ({ data, onUpload, editState, refetch }) => {
    const { store } = useContext(Context)

    const [open, setOpen] = useState(false);
    const [fileOnDelete, setFileOnDelete] = useState();
    const [deleteFileMutation] = useMutation(DELETE_ORDER_FILE)

    const onFileDeleteInput = useRef()

    const handleClickOpen = (file) => {
        setFileOnDelete(file)
        setOpen(true)
    }
    
    const handleClose = () => setOpen(false)

    const onUploadFiles = () => {
        if (onUpload.length == 0) return null
        const files = onUpload.map(file => <div key={file.path}>{file.path}</div> )

        return <div className="onUploadIcon">{files}</div>
    } 

    const deleteFile = async () => {
        //close modal window
        handleClose();
        
        if (onFileDeleteInput.current.value == 'Да'){
            await store.deleteFile(fileOnDelete.Key, deleteFileMutation)
            refetch()
        }        
    }

    const attachedFiles = data.map(
        file => {
            if (editState) return(
                <div key={file.Key}>
                    <div onClick={ () => handleClickOpen(file)} 
                        className='file-name delete-file'> {file.FileName} </div>
                </div>
            )
            else return (
                <div onClick={ () => store.downloadFile(file)} 
                    key={file.Key}
                    className='file-name'> {file.FileName} </div>
            )
        })
     
    return (        
        <div className="Docs" >
            {attachedFiles}

            {onUploadFiles()}

            <div>
                <Dialog open={open} onClose={handleClose} aria-labelledby="form-dialog-title" maxWidth='xs'>
                    <DialogContent>
                        <DialogContentText>
                            Вы действительно хотите удалить <span>{fileOnDelete?.FileName}</span> ? <br/>
                            Это действие необратимо.
                            Пожалуйста, введите "Да" для подтверждения.
                        </DialogContentText>
                        <TextField
                            autoFocus
                            margin="dense"
                            fullWidth
                            autoComplete='off'
                            inputRef={onFileDeleteInput}
                        />
                    </DialogContent>
                    <DialogActions>
                        <Button onClick={deleteFile} className='dialog-danger-btn'>
                            Я понимаю последствия, удалить этот файл
                        </Button>
                    </DialogActions>
                </Dialog>
            </div>

        </div>
    )
}

export default Docs