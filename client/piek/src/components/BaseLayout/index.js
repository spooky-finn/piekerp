import './index.sass'


const BaseLayout = (props) => {


    return(
        <>
        <div className="BaseLayout">
            ПРИВЕТ!!!
        </div>

        {props.children}
        </>
    )
}

export default BaseLayout