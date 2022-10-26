import { useCallback, useEffect, useLayoutEffect, useState } from 'react'
import { useDropzone } from 'react-dropzone'
import { useLocation, useParams } from 'react-router-dom'
import ReactTooltip from 'react-tooltip'
import PaperL1 from 'src/components/wrappers/PaperL1'
import useAppContext from 'src/hooks/useAppContext'
import { useOrderDetailStore } from 'src/hooks/useOrderDetailStore'
import { useGetManagersQuery, useGetOrderByPkQuery } from 'src/types/graphql-shema'
import FileService from '../../services/FileService'
import CommentsList from './comments/CommentsList'
import Docs from './docs/Docs'
import { isFileOnDropzone } from './Dropzone'
import OrderItemList from './order-items/OrderItemList'
import OrderHeader from './OrderHeader'
import RightInfoPanel from './RightInfoPanel'
import EditRightInfoPanel from './RightInfoPanel/EditRightInfoPanel'
import './sass/index.sass'

export default function OrderDetail(props) {
  const { store } = useAppContext()

  // files that now in uploading
  const [onUploadFiles, setOnUploadFiles] = useState([])

  const defaultEditMode = new URLSearchParams(useLocation().search).get('edit') ? true : false

  const orderId = parseInt(useParams<{ id: string }>().id)
  const { editMode, initialize } = useOrderDetailStore()

  useEffect(() => {
    ReactTooltip.rebuild()
  }, [])

  useLayoutEffect(() => {
    initialize(orderId, defaultEditMode)
  }, [])

  const handleFileOnDrop = useCallback(async acceptedFiles => {
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

  const { getRootProps, isDragActive } = useDropzone({ onDrop: handleFileOnDrop })

  if (!data?.erp_Orders) return <></>
  return (
    <PaperL1>
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
                  orderID={orderId}
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
