import { UilImage, UilFile, UilFileAlt } from '@iconscout/react-unicons'

// converts file size from bytes to human-readable string
export function formatBytes(bytes: number): string {
  if (!bytes) return '0 Bytes'
  var k = 1024,
    dm = 1,
    sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
    i = Math.floor(Math.log(bytes) / Math.log(k))
  return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i]
}

export function formatAssociatedIcon(filename: string) {
  const fileExtension = filename.split('.')[filename.split('.').length - 1]

  if (['png', 'jpg', 'jpeg'].includes(fileExtension)) return <UilImage />
  if (['pdf', 'doc', 'docx'].includes(fileExtension)) return <UilFileAlt />
  else return <UilFile />
}
