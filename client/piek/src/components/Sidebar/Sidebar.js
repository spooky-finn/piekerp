// import { observer } from 'mobx-react-lite';
import { useContext } from 'react';
import { NavLink} from 'react-router-dom';
import { Context } from '../../index';
import './index.sass';

import { UilSortAmountDown, UilWrench, UilConstructor} from '@iconscout/react-unicons';
import SettingsDrawer from './SettingsDrawer/SettingsDrawer';

const Sidebar = () => {
    const {store} = useContext(Context);
    return(
        <div className='Sidebar'>

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