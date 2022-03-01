
import {makeAutoObservable} from 'mobx';
import AuthService from '../services/AuthService';
import axios from 'axios';
import { API_URL } from '../http';
import { UilWrench, UilConstructor} from '@iconscout/react-unicons';

export default class Store {
    user = {};
    isLoading = false;
    UItheme = {
        state: null,
        dispatch: null
    };
    inMemoryToken = undefined;

    priorityTab = 1;
    cachedOrders = [];
    cachedPreOrders = [];
    
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

    setInMemoryToken(token){
        this.inMemoryToken = token
    }
    setPriorutyTab(number){
        this.priorityTab = number
    }

    setCachedOrders(array){
        this.cachedOrders = array
    }
    setCachedPreOrders(array){
        this.cachedPreOrders = array
    }
    setUItheme(state, dispatch){
        this.UItheme = { state, dispatch }
    }
    async login(email, password){
        try {
            const res = await AuthService.login(email, password)
            if (res.status === 200){
              this.setInMemoryToken(res.data.accessToken)
              this.setUser(res.data.user);
              return res
            }
            
        } catch (e) {
            console.log(e);
        }
    }

    async logout(){
        try {
            await AuthService.logout();
            this.setInMemoryToken(null)
            this.setUser({});
        } catch (e) {
            console.log(e.response?.data?.message);
            
        }
    }

    async getNewToken(){
        return await axios.get(`${API_URL}/refresh`, { withCredentials: true }).then(
            (r) => {
                if (r.status !== 200) new Error('Invalid response while trying to get new access token')
                this.setInMemoryToken(r.data.accessToken)
                return r.data.accessToken
            }
        );
    }

    
    async checkAuth() {
        this.setLoading(true);
        try {
            await axios.get(`${API_URL}/refresh`, {withCredentials: true}).then(
              (res) => {
                if (res.status === 200){
                  this.setUser(res.data.user);
                  this.setInMemoryToken(res.data.accessToken)      
                }
              }
            )
        } catch (e) {
            console.log(e)
        } finally {
            this.setLoading(false);
            return this.inMemoryToken
        }
    }


    pageParams = [
        {
            'url' : '/reclamation',
            'icon': <UilWrench/>,
            'title': 'Рекламация',
        },
        {
            'url' : '/attendance',
            'icon': <UilConstructor/>,
            'title': 'Рабочее время',
        },
    ];

    getPageParams(url){
        const page = this.pageParams.find((el) => el.url === url)
        return page
    }

}
