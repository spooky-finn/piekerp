export default function keywordComparator(keyword: string, ...context: string[]) {
  return context.some(arg => arg && arg.toLowerCase().includes(keyword?.toLowerCase()))
}
