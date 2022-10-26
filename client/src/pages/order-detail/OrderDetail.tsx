import { useCallback, useEffect, useLayoutEffect, useState } from 'react'
import { useDropzone } from 'react-dropzone'
import { useLocation, useParams } from 'react-router-dom'
import ReactTooltip from 'react-tooltip'
import PaperL1 from 'src/components/wrappers/PaperL1'
import { useOrderDetailStore } from 'src/hooks/useOrderDetailStore'
import { useGetManagersQuery, useGetOrderByPkQuery } from 'src/types/graphql-shema'
import FileService from '../../services/FileService'
import CommentsList from './comments/CommentsList'
import DialogAddEditOrderItem from './dialogs/DialogAddEditOrderItem'
import Docs from './docs/Docs'
import { isFileOnDropzone } from './utils.dropzone'
import OrderItemList from './order-items/OrderItemList'
import OrderHeader from './OrderHeader'
import RightInfoPanel from './RightInfoPanel'
import EditRightInfoPanel from './RightInfoPanel/EditRightInfoPanel'
import './sass/index.sass'
import { useAppContext } from 'src/hooks'

export default function OrderDetail() {
  const { store } = useAppContext()
  // files that now in uploading
  const [onUploadFiles, setOnUploadFiles] = useState<File[]>([])

  const defaultEditMode = new URLSearchParams(useLocation().search).get('edit') ? true : false
  const queryParams = useParams<{ id: string }>()
  const orderId = parseInt(queryParams.id || '')

  const { editMode, initialize } = useOrderDetailStore()

  useEffect(() => {
    ReactTooltip.rebuild()
  }, [editMode])

  useLayoutEffect(() => {
    initialize(orderId, defaultEditMode)
  }, [])

  const handleFileOnDrop = useCallback(async (acceptedFiles: File[]) => {
    setOnUploadFiles(acceptedFiles)
    const res = await FileService.uploadFile(acceptedFiles, orderId)
    if (res.status === 200) {
      refetch()
    } else {
      console.log('S3 file upload error', res)
      refetch()
    }
    setOnUploadFiles([])
  }, [])

  const { data, refetch } = useGetOrderByPkQuery({
    variables: {
      OrderID: orderId
    }
  })

  const { data: users } = useGetManagersQuery()

  const { getRootProps, isDragActive } = useDropzone({
    onDrop: handleFileOnDrop,
    noKeyboard: true,
    noClick: true
  })

  if (!data?.erp_Orders || !store.user?.UserID) return null

  return (
    <PaperL1>
      <DialogAddEditOrderItem refetch={refetch} />

      {isFileOnDropzone(isDragActive)}
      {data.erp_Orders && users?.erp_Users ? (
        <>
          <section className="OrderLayout" {...getRootProps()} id="dropzone">
            <div className="LeftSideContent">
              <OrderHeader order={data.erp_Orders[0]} />
              <OrderItemList data={data.erp_Orders[0].OrderItems} refetch={refetch} />
              <CommentsList user={store.user} />
              <Docs data={data.erp_Orders[0].Docs} onUpload={onUploadFiles} refetch={refetch} />
            </div>

            <div className="Info">
              {editMode ? (
                <EditRightInfoPanel
                  data={data.erp_Orders[0]}
                  refetch={refetch}
                  users={users.erp_Users}
                />
              ) : (
                <RightInfoPanel data={data.erp_Orders[0]} />
              )}
            </div>
          </section>
        </>
      ) : null}
    </PaperL1>
  )
}
