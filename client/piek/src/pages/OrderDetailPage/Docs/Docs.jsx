import { useState, useEffect } from 'react';

//apollo
import { useMutation } from '@apollo/client';
import { DELETE_ORDER_FILE } from '../queries/MutationOrderDocs';

import './docs.sass'

import ConfirmDialog from './ConfirmDialog';
import S3Service from '../../../services/S3Service';

const Docs = props => {
    const { data, onUpload, editState, refetch } = props;
    
    const [open, setOpen] = useState(false);
    const [fileOnDelete, setFileOnDelete] = useState();
    const [deleteFileMutation] = useMutation(DELETE_ORDER_FILE)

    const handleClickOpen = (file) => {
        setFileOnDelete(file)
        setOpen(true)
    }
    
    const handleClose = () => setOpen(false)

    const onUploadFiles = () => {
        if (onUpload.length === 0) return null
        const files = onUpload.map(file => <div key={file.path}>{file.path}</div> )

        return <div className="onUploadIcon">{files}</div>
    } 
    useEffect(() => {
        setOpen(false)
    }, [editState]);

    const deleteFile = async () => {
        //close modal window
        handleClose();
        await S3Service.deleteFile(fileOnDelete.Key, deleteFileMutation)
        refetch()
    }

    const attachedFiles = data.Docs.map(
        file => {
            // delite file
            if (editState) return(
                <div key={file.Key}>
                    <div onClick={ () => handleClickOpen(file)} 
                        className='file-name delete-file'> {file.FileName} </div>
                </div>
            )
             // opne file
            else return (
                <a href={`${process.env.REACT_APP_API_URL}/s3/${file.Key}`}
                    key={file.Key}
                    target='_blank'
                    rel="noreferrer"
                    className='file-name'> {file.FileName} </a>
            )
        })
     
    return (        
        <div className="Docs" >
            <div className='filesContainer'>
                {attachedFiles}
                
                {onUploadFiles()}
            </div>
          

            <div>

                <ConfirmDialog 
                filename={fileOnDelete?.FileName} 
                open={open}  
                handleClose={handleClose}
                onConfirmF={deleteFile}/>
            </div>

        </div>
    )
}

export default Docs