const fetch = require("node-fetch");

function gettime(){
    const endpoint = "http://worldtimeapi.org/api/timezone/Europe/Moscow";
    // const res =  fetch(endpoint);
    // console.log(res)
    return new Promise( function(resolve, reject) {
        return fetch(endpoint)
    })
}

// fetch("http://worldtimeapi.org/api/timezone/Europe/Moscow")
// .then( function fulfilled(res){
//     return res.json()
// }, function rejected(err){

//     console.log('err', err)
// }).then(
//     function fulfilled(responce){
//         console.log('res: ', responce)
//     },
//     function rejected(err){
//         console.log(err)
//     }
// )

// const a = Promise.resolve(new Promise(function(resolve, reject){
//     setTimeout(() => {
//         resolve(45)
//     }, 100);
    
// }))

const b = new Promise((resolve, reject) => {
    setTimeout( () => {
        resolve(50)
    }, 3000)
})

// const c = Promise.all([a,b]).then( promises => [
//     console.log(promises[1])
// ])

function timeoutPromise(delay){
    return new Promise( function (resolve, reject){
        setTimeout(() => {
            reject(new Error('Timeout reject'))
        }, delay);
    })
}

Promise.race([b, timeoutPromise(4100)]).then(
    function (res) {
        console.log('res ', res)
    },
    function (err){
        console.log( err )
    }
)

if (!Promise.wrap) {
    Promise.wrap = function(fn) {
        return function() {
            var args = [].slice.call( arguments );
            return new Promise( function(resolve,reject){
                fn.apply(
                    null,
                    args.concat( function(err,v){
                        if (err) {
                            reject( err );
                        }
                        else {
                            resolve( v );
                        }
                        }) );
            } ); };
    }; 
};