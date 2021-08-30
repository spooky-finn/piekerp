
const OrderComposition = (props) => {

    return(<>     
            {props.data.map( el => 

                <div key={el.OrderItemID} className="Unit">


                    <div className='firstRow'>

                        <div className="name"> {el.Name} </div>
                        <span  className="quantity"> {el.Quantity}</span>

                    </div>
                    
                    <div  className="fullName"> { el.FullName }</div>

                </div>


            )}
            
    </>)
}

export default OrderComposition