import moment from 'moment';

export const getPreviousMonth = () => moment().subtract(1, 'months').month()

export const formatDate = (date) => {
    if (!date) return ''
    return moment(date).format('DD.MM.YY')
}