
const OrderComposition = (props) => {

    return(<>     
            {props.data.map( el => 

                <div key={el.OrderItemID} className="Unit">

                    <div className="Name"> {el.Name} </div>

                    <div  className="Quantity"> {el.Quantity}</div>
                    {/* <div>Сборщик</div>
                    <div>Сер номер</div> */}

                </div>
            )}
            
    </>)
}

export default OrderComposition