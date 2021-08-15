import { UilCloudUpload } from '@iconscout/react-unicons'

export const isFileOnDropzone = (isDragActive) => {
    var el = document.getElementById('dropzone')

    if (isDragActive){
        el.classList.add('isDragAccept')
        return <UilCloudUpload className='inCloudconIcon'/>
    } else el?.classList?.remove('isDragAccept')
}