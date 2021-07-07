import {BrowserRouter, Switch, Route} from "react-router-dom";

import LoginForm from '../components/LoginForm';
import PriorityLayout from "../components/PriorityLayout";
import RecentlyLayout from "../components/RecentlyLayout"

import PrivateRoute from "./PrivateRoute";



const AppRouter = (props) => {

    return(
        <Switch>
            <Route path="/login" component={LoginForm}/>
            <PrivateRoute exact path='/' component={PriorityLayout} store={props.store}/>
            <PrivateRoute path='/recently' component={RecentlyLayout} store={props.store}/>

            {/* <PrivateRoute path='/recently' component={() => <PriorityLayout props={isRecently}/>} store={props.store}/> */}

            
        </Switch>
    )
    
};

export default AppRouter;