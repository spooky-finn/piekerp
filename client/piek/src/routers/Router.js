import {Router, Switch, Route} from "react-router-dom";
import { createBrowserHistory } from "history";

import LoginForm from '../components/LoginForm';
import PriorityLayout from "../components/PriorityLayout";

import PrivateRoute from "./PrivateRoute";

export const history = createBrowserHistory();




const AppRouter = (props) => {



    return(
    <Router history={history}>
        <Switch>
            <Route path="/login" component={LoginForm} />
            <PrivateRoute path='/' component={PriorityLayout} store={props.store}/>
            <PrivateRoute path='/priority' component={PriorityLayout} store={props.store}/>
            
            {/* <Route exact path='/recently' component={() => <PriorityLayout props={a} />} /> */}
        </Switch>
    </Router>
    )
    
};

export default AppRouter;