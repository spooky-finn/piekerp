// import { observer } from 'mobx-react-lite';
import { NavLink} from 'react-router-dom';
import './index.sass';

import { UilSortAmountDown, UilWrench, UilConstructor} from '@iconscout/react-unicons';
import SettingsDrawer from './SettingsDrawer/SettingsDrawer';

const Sidebar = () => {
    return(
        <div className='Sidebar noprint'>

            <NavLink  exact  to='/' activeClassName='sidebar-active' className="action-icon"><UilSortAmountDown/></NavLink>
            <NavLink  to='/reclamation' activeClassName='sidebar-active' className="action-icon"><UilWrench/></NavLink>
            <NavLink  to='/attendance' activeClassName='sidebar-active' className="action-icon"><UilConstructor/></NavLink>
                
            <div className="action-icon settings">
                <SettingsDrawer/>
            </div>

        </div>
    );
}

export default Sidebar;