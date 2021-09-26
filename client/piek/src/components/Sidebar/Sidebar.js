// import { observer } from 'mobx-react-lite';
import { useContext } from 'react';
import { NavLink, useHistory } from 'react-router-dom';
import { Context } from '../../index';

import { Pane } from 'evergreen-ui';
import './index.sass';
import sass from './index.module.sass'

import { UilSortAmountDown, UilWrench, UilUserCircle, UilSignInAlt, UilConstructor, UilSetting} from '@iconscout/react-unicons';

import { Popover, Position, Menu, CircleArrowRightIcon, EditIcon, Button } from 'evergreen-ui'

import { SystemPreferTheme } from '../core/SystemPreferTheme';

const Sidebar = () => {
    const {store} = useContext(Context);
    const [isDark, setIsDark] = SystemPreferTheme();
    const history = useHistory()

    async function logout(){
        await store.logout(); 
        history.push('/login')
    }

    return(
        <>
        <Pane className='Sidebar'>

            <NavLink  exact  to='/' activeClassName='sidebar-active' className="action-icon"><UilSortAmountDown/></NavLink>
            <NavLink  to='/reclamation' activeClassName='sidebar-active' className="action-icon"><UilWrench/></NavLink>
            <NavLink  to='/attendance' activeClassName='sidebar-active' className="action-icon"><UilConstructor/></NavLink>
                
            <Popover
            content={
                <Menu>
                <Menu.Group>
                    <Menu.Item onClick={() => setIsDark(!isDark)}>Переключить тему</Menu.Item>
                </Menu.Group>
                <Menu.Divider />

                <Menu.Group>
                    <Menu.Item disabled>{store.user.FirstName}  {store.user.LastName}</Menu.Item>
                    <Menu.Item className={sass.logoutButton} onClick={logout} >Выйти</Menu.Item>
                </Menu.Group>

                </Menu>
                }
                >
                <div appearance="minimal" className="action-icon settings"><UilSetting/></div>
            </Popover>   

        </Pane>
        </>
    );
}

export default Sidebar;