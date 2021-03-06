import  moment  from 'moment'
import "./rightPanel.sass";
import { Typography, Box } from '@mui/material/';

import { styled } from '@mui/material/styles';

const OrderInfoCard = (props) => {
  const { heading, secondaryHeading } = props;
  return (
    <Box className="OrderInfoCard" sx={{ color: 'text.primary' }}>
    <div className='row'>
      <Typography variant='subtitle2'>{heading}</Typography>
      <Typography variant='subtitle3' className='noprint secondaryHeadingAnimation'>{secondaryHeading}</Typography>
    </div>

    <div className='body'>
      {props.children}
    </div>
  </Box>
  )
}
const Pre = styled((props) => <Typography {...props} />)(
  ({ theme }) => ({
    color: theme.palette.text.secondary,
    fontSize: '.7rem'
  }),
  );

const OrderMeta = (props) => {
   const { data } = props;
    
    const setPaidPercent = (total, paid) => {
        if (!total || !paid) return ' '
        return ' - ' + ((paid/total) * 100).toFixed(0) + '%'
    }
   
    const paidVisualization = () => {
      if (data.PaymentHistories.length === 0 || !data.PaidAmount || !data.TotalAmount) return null

      return (
        <OrderInfoCard className='noprint' heading="Платежи" secondaryHeading={`${data.TotalAmount} ₽`}>
           <table className='paidVisualization'>
           <tbody>
            {data.PaymentHistories.map(e => (
                <tr key={e.Date}>
                  <td>{(e.PaidAmount / data.TotalAmount * 100).toFixed(0)} % </td>
                  <td>{moment(e.Date).format('DD.MM.YY')}</td>
              </tr>
            ))}
          </tbody>
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
        }, 
        {
          'heading': 'Проблемки с',
          'data': moment(data.NeedAttention?.split(',')[1] || null).format('DD.MM.YY hh:mm')
        }
      ]
      return (
        <OrderInfoCard heading="О заказе">
          <table><tbody>
             {columns.map(el => {
                if (!el.data || el.data === 'Invalid date') return null
                return <tr key={`${el.heading} ${el.data}`}>
                  <td>{el.heading}</td>
                  <td>{el.data}</td>
                </tr>
                }
              )}
          </tbody></table>
        </OrderInfoCard>
      )
    }
  return (<>
      <div className="wrap">

          <Box className='significantInfo' sx={{ color: 'text.primary' }}>
            <div className='bold'>
              <Pre>План. отгрузка</Pre>
              {data.ShippingDate &&  moment(data.ShippingDate).format('DD.MM.YY')}
            </div>
            <div className='bold'>
              <Pre>Номер заказа</Pre>
              {data.OrderNumber}
            </div>
            <div className='bold'>
              <Pre>Счет / оплата</Pre>
              {"№ "+ (data.InvoiceNumber || '')+setPaidPercent(data.TotalAmount, data.PaidAmount)}
            </div>
          </Box>

          <Box className='OrderComment'>
              <Pre>Комментарий</Pre>
              {data.Comment}
          </Box>

        {aboutOrder()}
        {paidVisualization()}
      </div>
  </>)
}

export default OrderMeta
