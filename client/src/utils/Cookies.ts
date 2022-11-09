export function getCookie(name: string): string | undefined {
  const cookies = `; ${document.cookie}`
  const parts = cookies.split(`; ${name}=`)

  if (!parts) return undefined

  const value = parts.pop()!.split(';').shift()
  return value
}

export function setUnexpiredCookie(name: string, value: string | number | boolean) {
  var expires = new Date()
  expires.setFullYear(expires.getFullYear() + 10)
  document.cookie = `${name}=${value}; expires=${expires}; path=/`
}
