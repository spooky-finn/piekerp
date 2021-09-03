import { UilCloudUpload } from '@iconscout/react-unicons'
import { motion } from "framer-motion"

export const isFileOnDropzone = (isDragActive) => {
    var el = document.getElementById('dropzone')

    if (isDragActive){
        el.classList.add('isDragAccept')
        return (
            <motion.div 
            initial={{ y: "80vh"  }}
            animate={{ y: "40vh" }} >

             <UilCloudUpload className='inCloudconIcon'/>
         </motion.div>
        )
    } else el?.classList?.remove('isDragAccept')
}