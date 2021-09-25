function filteringAlg(keyword, ...rest){
    var finded = false
    rest.map( (arg) => {
        if (arg && arg.toLowerCase().includes(keyword.toLowerCase())) finded = true
    })
   
    if (finded) return true 
    else return false
}

export const filter = (array, keyword, managerFilter = 0) => {
    var result = [];

    // применить поиск по ключевому слову
    if (keyword !== '') {
        result = array.filter( (order) => filteringAlg(keyword, order.InvoiceNumber, order.Entity ))         
    }
    else result = array

     //применить поиск по фильру
    if (managerFilter !== 0){
        var newOrders = []
        result.map( (ord) => {
            if (ord.ManagerID === managerFilter) newOrders.push(ord)
        })
        return newOrders
    }
    else return result
}