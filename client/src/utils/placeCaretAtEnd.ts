export default function placeCaretAtEnd(el: HTMLElement) {
  el.focus()

  if (typeof window.getSelection != 'undefined' && typeof document.createRange != 'undefined') {
    var range = document.createRange()
    range.selectNodeContents(el)
    range.collapse(false)

    var sel = window.getSelection()
    if (!sel) {
      throw Error()
    }
    sel.removeAllRanges()
    sel.addRange(range)
  }
}
