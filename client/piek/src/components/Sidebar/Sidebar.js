// import { observer } from 'mobx-react-lite';
import { useContext } from 'react';
import { NavLink } from 'react-router-dom';
import { Context } from '../../index';

import { Pane } from 'evergreen-ui';
import './Sidebar.sass';
import { UilSortAmountDown, UilEnvelopeInfo, UilWrench, UilUserCircle, UilSignInAlt, UilConstructor} from '@iconscout/react-unicons';
import { DarkToggle } from './DarkToggle';

const Sidebar = () => {
    const {store} = useContext(Context);

    return(
        <>
        <Pane className='Sidebar'>

            <NavLink  exact  to='/' activeClassName='sidebar-active' className="action-icon"><UilSortAmountDown/></NavLink>
            <NavLink  to='/recently' activeClassName='sidebar-active' className="action-icon"><UilEnvelopeInfo/></NavLink>
            <NavLink  to='/reclamation' activeClassName='sidebar-active' className="action-icon"><UilWrench/></NavLink>
            <NavLink  to='/attendance' activeClassName='sidebar-active' className="action-icon"><UilConstructor/></NavLink>


           <a className="action-icon" ><DarkToggle/></a> 
            <NavLink  className="action-icon" to='/account'><UilUserCircle/></NavLink>
            <NavLink  className="action-icon" to='/login' onClick={() => store.logout()}><UilSignInAlt/></NavLink>



        </Pane>
        </>
    );
}

export default Sidebar;