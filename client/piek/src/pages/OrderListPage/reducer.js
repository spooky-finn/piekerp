import OS from "../../utils/OrderStatus";

export const initialState = (store) => ({
    requiredManagerFilterID: 0,

    archive_requiredOrderStatus: OS.ordArchived,
    search_keyword: '',

    search : {
        // search in adjacent groups as an additional information
        // поиск в смежных разделах для вывода, как справочной информации
        // keyword: store.orderListLastSearckKeyword,
        brief: {
            orders : 0,
            preOrders: 0,
            reclamations: 0,
            archived: 0,
        }
    }
})

export function reducer(state, action){
    switch (action.type) {
      case action.type:
        return {...state, [action.type]: action.payload };

      default:
        throw new Error(`Unknown action type: ${action.type}`);
    }
};