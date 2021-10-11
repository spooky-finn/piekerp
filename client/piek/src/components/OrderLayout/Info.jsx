import  moment  from 'moment'
import { Card, Pane} from "evergreen-ui";
import "./sass/order-meta.sass";

import Shipment from "./Shipment/Shipment";

const OrderInfoCard = (props) => {
  const { heading, secondaryHeading } = props;
  return (
    <Card className="OrderInfoCard">
    <div className='row'>
      <div className='heading'>
        {heading}
      </div>
      <div className='secondaryHeading'>
        {secondaryHeading}
      </div>
    </div>

    <div className='body'>
      {props.children}
    </div>
  </Card>
  )
}

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
              </div>,
        'className': 'bold',
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
        'heading': "",
        'data': data.Comment,
        'className': 'OrderComment',
      },      
    ]

    const orderInfo = cells.map( (el) =>  
      <div key={el.heading} className={el.className}>
        <pre>{el.heading}</pre>
        {el.data}
      </div>
    )
   
    const paidVisualization = () => {
      if (data.PaymentHistories.length == 0) return null

      return (
        <OrderInfoCard className='noprint' heading="Платежи" secondaryHeading={`${data.TotalAmount} ₽`}>
           <table className='paidVisualization'>
            {data.PaymentHistories.map(e => (
              <tr>
                <td>{(e.PaidAmount / data.TotalAmount * 100).toFixed(0)} % </td>
                <td>{moment(e.Date).format('DD.MM.YY')}</td>
              </tr>
            ))}
          </table>
        </OrderInfoCard>
      )
    }
    
    const aboutOrder = () => {
      const columns = [
        {
          'heading': "Менеджер",
          'data': `${data.User?.FirstName} ${data.User?.LastName || 'undefined'}`, 
        },
        {
          'heading': "Создан",
          'data': moment(data.CreatingDate).format('DD.MM.YY'),
        },
        {
          'heading': "В очередности",
          'data': moment(data.AcceptanceDate).format('DD.MM.YY'), 
        },
        {
          'heading': "Факт. отгрузка",
          'data': moment(data.ActualShippingDate).format('DD.MM.YY'), 
        }
      ]

      return (
        <OrderInfoCard heading="О заказе">
          <table>
             {columns.map(el => {
                if (!el.data || el.data === 'Invalid date') return null
                return <tr>
                  <td>{el.heading}</td>
                  <td>{el.data}</td>
                </tr>
                }
              )}
          </table>
        </OrderInfoCard>
      )
    }

  return (<>
      <div className="wrap">

          <div className='significantInfo'>
            <div className='bold'>
              <pre>План. отгузка</pre>
              {data.ShippingDate &&  moment(data.ShippingDate).format('DD.MM.YY')}
            </div>
            <div className='bold'>
              <pre>Номер заказа</pre>
              {data.OrderNumber}
            </div>
            <div className='bold'>
              <pre>Счет / оплата</pre>
              {"№ "+ data.InvoiceNumber+setPaidPercent(data.TotalAmount, data.PaidAmount)}
            </div>
          </div>

          <div className='OrderComment'>
              <pre>Комментарий</pre>
              {data.Comment}
          </div>

        {aboutOrder()}
        {paidVisualization()}
      </div>
      <div className="actions noprint">
        <Shipment {...props} />
      </div>
  </>)
}

export default OrderMeta
