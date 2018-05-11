'use strict'
const articleClickModel = require("../model/articleClickModel")
const userActionModel = require("../model/userActionModel")
class activityController {
    setDayClick(){
        let async = async ()=>{ 
            try{
                let result = await articleClickModel.setDayClick() 
                await console.log("执行统计点击"+(new Date()).toLocaleString()) 
            } catch (err){
                retMsg.error()
            }
        }
        async()
    }

}

module.exports = new activityController()