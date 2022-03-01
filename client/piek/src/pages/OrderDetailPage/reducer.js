export const initialState = {
  onEditingItem: null,
}

export function reducer(state, action){
  switch(action.type){
    case 'onEditingItem': 
      return {...state, [action.type]: action.payload };

    case 'reset':
      return initialState
      
    default:
      return initialState
  }
 
}