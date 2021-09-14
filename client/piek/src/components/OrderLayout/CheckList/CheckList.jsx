import { useMutation } from "@apollo/client"
import { UPDATE_UNIT_STATE, INSERT_UNIT } from './mutations'
import { GET_ORDER_BY_ID } from "../queries/GetOrderByID";

import sass from './index.module.sass'
import { motion, AnimatePresence } from "framer-motion"



const CheckList = ({ data, OrderID }) => {
    const [insertUnitMutation] = useMutation(INSERT_UNIT, {
        update(cache, { data }){
            const existingUnits = cache.readQuery({ query: GET_ORDER_BY_ID, variables: { OrderID } })

            var newcache = JSON.parse(JSON.stringify(existingUnits))
            newcache.erp_Orders[0].CheckListUnits.push(data.insert_erp_CheckListUnits_one)
            console.log(newcache)

            cache.writeQuery({
                query: GET_ORDER_BY_ID,
                variables: { OrderID },
                data: newcache
            })

            console.log(data.insert_erp_CheckListUnits_one, 'update')
        }
      });
    const [updateUnitStateMutation] = useMutation(UPDATE_UNIT_STATE);

    function addUnit(e){
        if (e.keyCode !== 13 || !e.target.value) return null
        insertUnitMutation({ 
            variables: {
             OrderID,
             'Point': e.target.value },
            optimisticResponse: {
                insert_erp_CheckListUnits_one: {
                    __typename: "erp_CheckListUnits",
                    CheckListUnitID: 'temp-id',
                    Point: e.target.value,
                    IsComplited: false,
                    OrderID
                }
              }
        
        })
        e.target.value = '';
    } 


    const toggleCheckListUnit = (target, el) => {
        target.target.classList.toggle('complited')
        updateUnitStateMutation({ variables: { CheckListUnitID: el.CheckListUnitID, IsCompluted: !el.IsComplited } })
    }

    const units = data.map(el => 
        <motion.div
            initial={{ opacity: .3 }}
            animate={{ opacity: 1 }}
            transition={{ duration: .4}}
            key={el.CheckListUnitID} 
            className={ el.IsComplited ? "CheckListUnit complited" : "CheckListUnit"}
            onClick={ target => toggleCheckListUnit(target, el) }
            >
            {el.Point}
        </motion.div>
        )

   
   
    return(
        <div className="CheckList">
            <input className={sass.unitInput} type="text" placeholder='Опишите задачу и нажмите enter' onKeyUp={(e) => addUnit(e) }/>
            {units}
        </div>
    )
}


export default CheckList