import Registration from './Registration';
import Production from './Production';
import Recently from './Recently/index.jsx';
import Archive from './Archive/';
import Report from './Report/index'

import useOrderListPage from './useOrderListPage';
import useOrderListPageStore from './hooks/useOrderListPageStore';
import CustomTabs from '../../components/muiCustom/mui/CustomTabs';

import { Button } from '@mui/material';
import CreateRecordButton from '../../components/CreateRecordButton';


const OrderListPage = (props) => {
    const { data, insertOrderHandler } = useOrderListPage();
    const store = useOrderListPageStore()

    const tabs = [
        {
            title: 'Предзаказы',
            component: <Registration data={data} />
        },
        {
            title: 'Очередность',
            component: <Production data={data} />
        },
        {
            title: 'Недавние',
            component: <Recently data={data} />
        },
        {
            title: 'Архив',
            component: <Archive data={data} />
        },
        {
            title: 'Отчет',
            component: <Report data={data} />
        }
    ]

    return (
        <CustomTabs value={store.homePageTab} onChange={store.setHomePageTab} tabs={tabs}>

            <Button variant='iconic'> </Button>
            <CreateRecordButton onClick={insertOrderHandler} />
        </CustomTabs>
    )
}
export default OrderListPage


