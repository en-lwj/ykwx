'use strict'
const praiseModel = require("../model/praiseModel")
class praiseController {
    // 获取赞列表
    getPraise(req,res){
        let async = async ()=>{
            try{
                if(!req.session.user){
                    return res.json(retMsg.success([]))
                }
                let user_id = req.session.user.id
                let type_id = req.params.id
                let type = req.query.type || 0
                let result = await praiseModel.getPraiseByTypeIdAndUserId(type, type_id, user_id)
                res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 点赞
    addPraise(req,res){
        let async = async ()=>{
            try{
                let user_id = req.session.user.id
                let type = req.body.type || 0
                let type_id = req.body.type_id
                let comment_id = req.params.id
                let result = await praiseModel.addPraise(type, type_id, comment_id , user_id)
                res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    
}

module.exports = new praiseController()