import {Switch, Route, Redirect} from "react-router-dom";
import PrivateRoute from "./PrivateRoute";

import LoginForm from '../components/LoginForm';
import OrderListLayout from "../components/OrderListLayout";
import OrderLayout from "../components/OrderLayout";
import Attendance from '../components/AttendanceLayout'
import Reclamation from "../components/ReclamationLayout";

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
            {/* <PrivateRoute path='/recently' component={() => <PriorityLayout props={isRecently}/>} store={props.store}/> */}
        </Switch>
    )
};

export default AppRouter;