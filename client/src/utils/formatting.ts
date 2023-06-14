export function money(value: number) {
  if (!value) return 0
  return value.toLocaleString('en-US', {
    style: 'currency',
    currency: 'RUB',
    maximumFractionDigits: 0,
    minimumFractionDigits: 0
  })
}

export function percentage(value: number, whole: number) {
  if (!value || !whole) return ''
  return ((value / whole) * 100).toFixed(0) + '%'
}
