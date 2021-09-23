import { UilCloudUpload } from '@iconscout/react-unicons'
import { motion } from "framer-motion"

export const isFileOnDropzone = (isDragActive) => {
    var el = document.getElementById('dropzone')

    if (isDragActive){
        el.classList.add('isDragAccept')
        return (
            <div >
             <UilCloudUpload className='inCloudconIcon'/>
         </div>
        )
    } else el?.classList?.remove('isDragAccept')
}