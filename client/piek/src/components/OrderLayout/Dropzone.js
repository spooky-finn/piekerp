import { UilCloudUpload } from '@iconscout/react-unicons'
import { motion } from "framer-motion"

export const isFileOnDropzone = (isDragActive) => {
    var el = document.getElementById('dropzone')

    if (isDragActive){
        el.classList.add('isDragAccept')
        return (
            <motion.div 
            initial={{ y: "70vh"  }}
            animate={{ y: "50vh" }} >

             <UilCloudUpload className='inCloudconIcon'/>
         </motion.div>
        )
    } else el?.classList?.remove('isDragAccept')
}