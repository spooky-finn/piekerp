export function getInitialState(defaultDate){
    return {
        intervals: [],
        timeDeduction: null,
        selectedMonth: [defaultDate.getMonth(), defaultDate.getFullYear()],
        s_keyword: ''
    }
}

export function reducer(state, action) {
    switch (action.type) {

      case 'intervals':
        return {...state, [action.type]: action.payload,};

      case 'selectedMonth':
        return {...state, [action.type]: action.payload,};

      case 'timeDeduction':
        return {...state, [action.type]: action.payload };

      case 's_keyword': 
        return { ...state, [action.type]: action.payload};

      default:
        throw new Error();
    }
  }