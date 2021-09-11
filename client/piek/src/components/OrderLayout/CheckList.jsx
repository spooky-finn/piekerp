import { useMutation } from "@apollo/client"
import { MUTATE_CHECKLIST_UNIT } from './queries/MutationCheckListUnit'

const CheckList = ({data}) => {

    const [updateCheckListUnit, { loading }] = useMutation(MUTATE_CHECKLIST_UNIT);

    let propsData = JSON.parse(JSON.stringify(data))

    propsData.sort((a, b) => b.Point < a.Point ? 1 : -1)

    const toggleCheckListUnit = (target, el) => {
        target.target.classList.toggle('complited')
        updateCheckListUnit({ variables: { CheckListUnitID: el.CheckListUnitID, IsCompluted: !el.IsComplited } })
    }

    const units = propsData.map(el => 
            <div className={ el.IsComplited ? "CheckListUnit complited" : "CheckListUnit"}  
                key={el.CheckListUnitID} 
                onClick={ target => toggleCheckListUnit(target, el) }>
                {el.Point}
            </div>
        )

   
    return(
        <div className="CheckList">

            <div className='sectionHeading'>Чеклист</div>

            {units}
        </div>
    )
}

export default CheckList