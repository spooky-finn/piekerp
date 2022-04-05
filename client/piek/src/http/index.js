import axios from 'axios';
import { getInMemoryToken } from '..';

export const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:9000/api'
export const S3_URL = process.env.REACT_APP_API_URL + '/s3' || 'http://localhost:9000/api/s3'

const $api = axios.create({
    withCredentials: true,
    baseURL: API_URL
});

$api.interceptors.request.use( (config) => {
    config.headers.Authorization = `Bearer ${getInMemoryToken()}`
    return config;
})

export default $api;