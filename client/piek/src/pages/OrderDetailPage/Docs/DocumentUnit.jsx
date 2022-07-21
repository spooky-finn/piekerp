import moment from 'moment'
import sass from './docs.module.sass'

import { UilImage, UilFile, UilFileAlt, UilTimes } from '@iconscout/react-unicons'
import { Button } from '@mui/material'

const DocumentUnit = props => {
    const { file, canDelete, deleteFileCb } = props

    function humanReadableSize(size) {
        if (!size) return ''
        var i = Math.floor(Math.log(size) / Math.log(1024));
        return (size / Math.pow(1024, i)).toFixed(1) * 1 + ' ' + ['B', 'kB', 'MB', 'GB', 'TB'][i];
    };

    function getIcon(filename) {
        const fileExtension = filename.split('.')[filename.split('.').length - 1]

        if (['png', 'jpg', 'jpeg'].includes(fileExtension)) return <UilImage className={sass.svg} />
        if (['pdf', 'doc', 'docx'].includes(fileExtension)) return <UilFileAlt className={sass.svg} />
        else return <UilFile className={sass.svg} />
    }

    function isFileOnUpload() {
        if (props.onUpload) return true
        else return false
    }

    return <div className={`${sass.docsItem} ${isFileOnUpload() && sass.docsItemOnUpload}`}>

        <a href={`${process.env.REACT_APP_API_URL}/s3/${file.Key}`}
            target='_blank' rel="noreferrer"
        >

            {getIcon(file.FileName)}
            <div className={sass.name} >{file.FileName}</div>
            <div className={sass.date}> {humanReadableSize(file.Size)} | {moment(file.UploadingDate).format('D MMMM')}</div>
        </a>

        {canDelete && <Button variant='iconic' className={sass.deleteBtn} onClick={() => deleteFileCb(file)}> <UilTimes /> </Button>}
    </div>
}

export default DocumentUnit