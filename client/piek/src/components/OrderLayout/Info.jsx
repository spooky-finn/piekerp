import { setPaidPercent } from "../PriorityLayout/tableLogic";
import { UilHistoryAlt } from "@iconscout/react-unicons";
import "./sass/order-meta.sass";

const OrderMeta = (props) => {

  return (
    <div className="Meta">

      <div className="SignificantInfo">
            <div>
                <pre>План. отгрузка</pre>
                {props.data.ShippingDate}

                {/* {getShippingDate(props.data.ShippingDate)} */}
            </div>
            <div>
                <pre>Счет / оплата</pre>
                {"№ " +
                props.data.InvoiceNumber +
                setPaidPercent(props.data.TotalAmount, props.data.PaidAmount)}
                    <span className="PaymentHistory">
                        <UilHistoryAlt />
                    </span>
            </div>
      </div>

      <div className="MetaWrapper">
           <div className='Left'>
                <div>
                    <pre>Номер заказа</pre>
                    {props.data.OrderNumber}
                </div>
                <div>
                    <pre>Создан</pre>
                    {props.data.ShippingDate}
                </div>
                <div>
                    <pre>Менеджер</pre>
                    {props.data.User.FirstName} {props.data.User.LastName}
                </div>
           </div>

           <div className='Right'>
                    <div>
                        <pre>Юр Лицо</pre>
                        {props.data.Entity}
                    </div>
                    <div>
                        <pre>Гор</pre>
                        {props.data.City}
                    </div>
            </div>
      </div>

      <div className="OrderComment">
            <pre>Комментарий</pre>
            {props.data.Comment}
      </div>
    </div>

  )
}

export default OrderMeta
