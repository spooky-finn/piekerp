import {makeAutoObservable} from 'mobx';
import {Pane, Spinner} from 'evergreen-ui';
import AuthService from '../services/AuthService';
import axios from 'axios';
import { API_URL } from '../http';

import { UilSortAmountDown, UilEnvelopeInfo, UilWrench} from '@iconscout/react-unicons';




export default class Store {
    user = {};
    isAuth = false;
    isLoading = false;

    constructor(){
        makeAutoObservable(this);
        
    }

    setAuth(bool){
        this.isAuth = bool;
    }

    setUser(user){
        this.user = user;
    }

    setLoading(bool){
        this.isLoading = bool;
    }


    async login(email, password){
        try {
            const response = await AuthService.login(email, password);
            localStorage.setItem('token', response.data.accessToken);
            this.setUser(response.data.user);
            this.setAuth(true);
            window.location.href='/';
        } catch (e) {
            console.log(e.response?.data?.message);
        }
    }

    async logout(){
        try {
            await AuthService.logout();
            localStorage.removeItem('token');
            this.setAuth(false);
            this.setUser({});
        } catch (e) {
            console.log(e.response?.data?.message);
            
        }
    }

    async checkAuth() {
        this.setLoading(true);
        try {
            const response = await axios.get(`${API_URL}/refresh`, {withCredentials: true});
            localStorage.setItem('token', response.data.accessToken);
            this.setUser(response.data.user);
            this.setAuth(true);

            return {
                'isLoaded': true,
                 'isAuth': this.isAuth
                }
        } catch (e) {
            console.log(e.response?.data?.message);
            return {
                'isLoaded': true,
                'isAuth': this.isAuth
            }

        } finally {
            this.setLoading(false);
        }
        
    }

    async uploadFile(formData){
        const response = await axios.post(`http://localhost:9000/api/s3-upload`, formData, {
            headers: {
              "Content-Type": "multipart/form-data",
            }
          });
        console.log(response)
    }


    pageParams = [
        {
            'url' : '/',
            'icon': <UilSortAmountDown/>,
            'title': 'Очередность выполнения',
        },
        {
            'url' : '/recently',
            'icon': <UilEnvelopeInfo/>,
            'title': 'Новые заказы',
        },
        {
            'url' : '/reclamation',
            'icon': <UilWrench/>,
            'title': 'Рекламация',
        },
    ];

    getPageParams(url){
        const page = this.pageParams.find((el) => el.url === url)
        return page
    }

    preloader = <Pane display="flex" alignItems="center" justifyContent="center" height='75vh'><Spinner /></Pane>
}
