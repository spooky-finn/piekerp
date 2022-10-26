import { UilCloudUpload } from '@iconscout/react-unicons'

export const isFileOnDropzone = (isDragActive: boolean) => {
  const el = document.getElementById('dropzone')
  //   if (!el) throw Error('can not get dropzone Element')

  if (isDragActive) {
    el!.classList.add('isDragAccept')
    return (
      <div>
        <UilCloudUpload className="inCloudconIcon" />
      </div>
    )
  } else el?.classList?.remove('isDragAccept')
}
