export const percentage = (value: number, whole: number) => {
  if (!value || !whole) return ''
  return ((whole / value) * 100).toFixed(0) + '%'
}
