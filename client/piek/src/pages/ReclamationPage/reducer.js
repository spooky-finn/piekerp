const getItems = (count, offset = 0) =>
    Array.from({ length: count }, (v, k) => k).map(k => ({
        id: (k + offset).toString(),
        content: `item ${k + offset}`
    }));
    
export const initialState ={
  //Входящие
  inbox: [],
  // Принятие решения
  decision: [],
  //В производстве
  inproduction: []
}

export function reducer(state, action) {
  switch (action.type) {
      case 'inbox': 
      case 'decision': 
      case 'inproduction': 
          return {...state, [action.type]: action.payload };

      case 'reset': 
          return initialState
      default: 
          return {...state}
  }
}