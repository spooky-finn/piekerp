import { useContext } from 'react';
import { Context } from '../../index'


const Docs = ({data, onUpload}) => {
    const {store} = useContext(Context)

    const onUploadFiles = () => {
        if (onUpload.length == 0) return null
        const files = onUpload.map(file => <div key={file.path}>{file.path}</div> )

        return <div className="onUploadFiles">{files}</div>
    } 

    const attachedFiles = data.map(
        file => <div onClick={ () => store.downloadFile(file)} 
                    key={file.Key}> {file.FileName} </div>)

    return (
        <div className="Docs">
            {attachedFiles}

            {onUploadFiles()}
        </div>
    )

}

export default Docs