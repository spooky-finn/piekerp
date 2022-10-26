export default function orderKeywordComparator(keyword: string, ...context: string[]) {
  var finded = false

  context.map(arg => {
    if (arg && arg.toLowerCase().includes(keyword?.toLowerCase())) finded = true
  })

  return finded
}
