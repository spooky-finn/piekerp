import {Switch, Route, Redirect} from "react-router-dom";
import PrivateRoute from "./PrivateRoute";

import LoginForm from '../pages/LoginPage';
import OrderListLayout from "../pages/OrderListPage";
import OrderLayout from "../pages/OrderDetailPage";
import Attendance from '../pages/AttendancePage'
import Reclamation from "../pages/ReclamationPage";

const AppRouter = () => {
    return(
        <Switch>
            <Route        path="/login" component={LoginForm}/>
            <PrivateRoute exact path='/' component={OrderListLayout}/>
            <PrivateRoute path='/attendance' component={Attendance}/>
            <PrivateRoute path='/reclamation' component={Reclamation}/>
            <PrivateRoute path='/orders/:id' component={OrderLayout}/>

            #if required route was not found
            <Redirect     to="/" />
        </Switch>
    )
};

export default AppRouter;