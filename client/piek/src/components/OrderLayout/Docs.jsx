import { useState, useContext } from 'react';
import { Context } from '../../index'




const Docs = (props) => {
    const {store} = useContext(Context)
    const [file, setFile] = useState(' ');
    
    const submit = async (e) => {
        e.preventDefault()
        const formData = new FormData()
        formData.append('file', file)
        store.uploadFile(formData)

    }

    const fileSelected = (e) => {
        const file = e.target.files[0]
        setFile(file)
        console.log('sets file', file)
    }

    return (
        <>
        <div>
            <form onSubmit={submit} method="post" encType="multipart/form-data">
                <input  onChange={fileSelected} type="file" name='file'/>
                <button type='submit'>Submit</button>
            </form>
            
        </div>
        </>
    )

}

export default Docs