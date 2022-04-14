import { useState, useEffect } from 'react';

//apollo
import { useMutation } from '@apollo/client';
import { DELETE_ORDER_FILE } from '../queries/MutationOrderDocs';

// import './docs.sass'

import DocumentUnit from './DocumentUnit';
import ConfirmDialog from './ConfirmDialog';
import S3Service from '../../../services/S3Service';

import { Button, Typography } from '@mui/material';
import sass from './docs.module.sass'

const Docs = props => {
    const { data, onUpload, editState, refetch } = props;
    
    const [open, setOpen] = useState(false);
    const [fileOnDelete, setFileOnDelete] = useState();
    const [isVisible, setisVisible] = useState(true)
    const [deleteFileMutation] = useMutation(DELETE_ORDER_FILE)

    const handleClickOpen = (file) => {
        setFileOnDelete(file)
        setOpen(true)
    }
    
    const handleClose = () => setOpen(false)

  
    useEffect(() => {
        setOpen(false)
    }, [editState]);

    const deleteFile = async () => {
        //close modal window
        handleClose();
        await S3Service.deleteFile(fileOnDelete.Key, deleteFileMutation)
        refetch()
    }
     
    function switchDocsVisibility(){
        setisVisible(!isVisible)
    }

   
    useEffect(() => {
        onUpload.map( file => ({ ...file, FileName: file.name}) )
    
      
    }, [onUpload])
    
    return (        
        <div className="Docs" >

            <div className={sass.sectionHead}>
                <Typography variant='subtitle1'>Документы [{data.Docs.length}]</Typography>

                <Button className={sass.expandBtn} onClick={switchDocsVisibility}>
                   { isVisible?  "Свернуть" : "Развернуть"}
                </Button>
            </div>

            
            <div className='filesContainer'>
                {isVisible && data.Docs.map(file => (
                    <DocumentUnit 
                        key = {file.Key}
                        file = {file} 
                        canDelete = {editState} 
                        deleteFileCb = {handleClickOpen}
                    />
                ))}
                
                {/* {onUploadFiles()} */}
                {!!onUpload.length && onUpload.map( file => (
                    <DocumentUnit 
                        file = {{...file, FileName: file.name }} 
                        key = {file.name}
                        canDelete = {editState} 
                        deleteFileCb = {handleClickOpen}
                        onUpload = {true}
                    />
                ))}

            </div>
          
            <ConfirmDialog 
                filename={fileOnDelete?.FileName} 
                open={open}  
                handleClose={handleClose}
                onConfirmF={deleteFile}/>

        </div>
    )
}

export default Docs