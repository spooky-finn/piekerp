export default function orderKeywordComparator(keyword, ...rest){
    var finded = false
    rest.map( (arg) => {
    
        if (arg && arg.toLowerCase().includes(keyword?.toLowerCase() )) finded = true
    })
   
    if (finded) return true 
    else return false
}

