import { getShippingDate, setPaidPercent } from "../PriorityLayout/tableLogic";
import { UilHistoryAlt } from "@iconscout/react-unicons";
import EditField from "../editField";
import "./order-meta.sass";

const OrderMeta = (props) => {

  const FormatShippingDate =
    props.data.ShippingDate.split("-")[2] +
    "." +
    props.data.ShippingDate.split("-")[1] +
    "." +
    props.data.ShippingDate.split("-")[0].slice(2);

  return (
    <div className="Meta">

      <div className="SignificantInfo">
            <div>
                <pre>План. отгрузка</pre>
                <EditField editState = {props.editState} text = {getShippingDate(props.data.ShippingDate)} />

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
