import { UilHistoryAlt} from "@iconscout/react-unicons";
import  moment  from 'moment'
import "./sass/order-meta.sass";

import Shipment from "./Shipment/Shipment";

const OrderMeta = (props) => {
   const { data } = props;
    
    const setPaidPercent = (total, paid) => {
        if (!total || !paid) return ''
        return ' - ' + ((paid/total) * 100).toFixed(0) + '%'
    }
    const cells = [
      {
        'heading': "План. отгрузка",
        'data': data.ShippingDate &&  moment(data.ShippingDate).format('DD.MM.YY'),
        'className': 'bold',
      },
      {
        'heading': "Счет / оплата",
        'data': <div> {"№ "+ data.InvoiceNumber+setPaidPercent(data.TotalAmount, data.PaidAmount)}
                  <span className="PaymentHistory">
                    <UilHistoryAlt />
                  </span> 
              </div>,
        'className': 'bold',
      },
      {
        'heading': "Номер заказа",
        'data': data.OrderNumber,
      },
      {
        'heading': "Менеджер",
        'data': `${data.User?.FirstName} ${data.User?.LastName || 'undefined'}`,
      },
      {
        'heading': "Юр Лицо",
        'data': data.Entity,
      },
      {
        'heading': "Город",
        'data': data.City,
      },
      {
        'heading': "Создан",
        'data': data.CreatingDate.split('T')[0],
        'className': 'date',
      },
      {
        'heading': "Производится с",
        'data': data.AcceptanceDate?.split('T')[0],
        'className': 'date',
      },

      {
        'heading': "",
        'data': data.Comment,
        'className': 'OrderComment',
      },      
    ]

    const orderInfo = cells.map( (el) =>  
      <div className={el.className}>
        <pre>{el.heading}</pre>
        {el.data}
      </div>
    )
   

  return (
    <div className='posRel'>
      <div className="wrap">
        {orderInfo}
      </div>
      <div className="actions">
        <Shipment {...props} />
      </div>
    </div>  
  )
}

export default OrderMeta
