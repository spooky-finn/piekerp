


export default function EditField ({editState, text, updateFunc})  {
    return(
    editState ? <input defaultValue = {text} ></input>  : <div>{text}</div>
    )
}