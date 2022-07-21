import sass from './index.module.sass'
import moment from 'moment'

const Comment = (props) => {
    const { data, userID, updateComment, deleteComment, nowEditing, setNowEditing } = props

    function sender(){
        return `${data.User.FirstName} ${data.User.LastName}`
    }
    
    function actions(){
        if (userID === data.User.UserID && nowEditing?.CommentID !== data.CommentID ) return (
            <div onClick={()=> deleteComment(data.CommentID)}>Удалить</div>
        )
    }
    function timestamp(){
        const date = moment(data.Timestamp)
        return date.format('MMM D') +' at '+ date.format('hh:mm')
    }

    function changeInCommentTodo(e){
        // если комментарий содержит чек-лист выполняем мутацию на обновление состояния
        if (e.currentTarget.innerHTML.toString().includes(sass.checklistUnit, 0)){
            updateComment(data.CommentID, e.currentTarget.innerHTML)
        }

    }
    
    function getCommentContent(){
        const isYourComment = (userID === data.User.UserID)
        if (isYourComment) return (
            <div 
                contentEditable = "true"
                key             = {data.CommentID}
                className       = {sass.commentContent}
                suppressContentEditableWarning = "true"
                onBlur={async (e) => {
                await updateComment(data.CommentID, e.target.innerHTML)
                }}
                onMouseLeave={async (e) => {
                await updateComment(data.CommentID, e.target.innerHTML)
                setNowEditing(null)
                }}
                onMouseDown = {((e) => {
                    // execute content selecting only on doubleclick or over
                        if (e.detail < 2) e.preventDefault();                       
                    })}
                dangerouslySetInnerHTML={{ __html: data.Text}}>
            </div>)

        else return (
            <div 
                onClick={changeInCommentTodo}
                dangerouslySetInnerHTML={{ __html: data.Text }} 
                className={sass.commentContent}>
            </div>
        )

    }

    return (
        <div className={sass.commentUnit}>

        <div className={sass.commentHeader}>
            <div className={sass.sender}> {sender()} </div>
            <div className={sass.actions}>{actions()}</div>
            <div className={sass.time}> {timestamp()} </div>
        </div>
        {getCommentContent()}

        </div>
    )
}
export default Comment 