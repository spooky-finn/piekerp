import AppRouter from '../../routers/Router';

const BaseLayout = (props) => {
    return(
        <div className="base-container">
                <AppRouter/> 
                {props.children}
        </div>
    )
}   

export default BaseLayout;