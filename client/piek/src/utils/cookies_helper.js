export function getCookie(title){
    const cookies = `; ${document.cookie}`;
    const parts = cookies.split(`; ${title}=`);
    const value = parts.pop().split(';').shift();
    return value
}

export function setUnexpiredCookie(title, value){
    var expires = new Date()
    expires.setFullYear(expires.getFullYear()+10)
    document.cookie = `${title}=${value}; expires=${expires}; path=/`
}