'use strict'
const commentModel = require("../model/commentModel")
const userModel = require("../model/userModel")
const articleModel = require("../model/articleModel")
class commentController {
    // 增加评论
    addComment(req,res){
        let async = async ()=>{
            try{
                let result = await commentModel.addComment(req.body.type, req.body.type_id, req.body.content, req.session.user.id)
                if(result.insertId){
                    res.json(retMsg.success('','评论成功'))
                } else {
                    return res.status(400).json(retMsg.error('评论失败'))                   
                }  
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 回复评论
    addCommentReply(req,res){
        let async = async ()=>{
            try{
                let table_name = ''
                let type = req.body.type
                if(type==0) table_name = 'article'
                else if(type==1) table_name = 'news'
                let user_info = await articleModel.getDataById(table_name, req.body.type_id)
                if(user_info[0].user_id != req.session.user.id) return res.status(400).json(retMsg.error('你没有权限')) 
                let result = await commentModel.addCommentReply(req.params.id, req.body.content, req.session.user.id)
                if(result.insertId){
                    res.json(retMsg.success('','回复成功'))
                } else {
                    return res.status(400).json(retMsg.error('回复失败'))                   
                }  
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 获取评论（包括评论信息，回复评论的信息，用户信息）
    getComment(req,res){
        let async = async ()=>{
            try{
                let type = req.query.type
                let type_id = req.query.type_id
                let page = req.query.page || null
                let limit = req.query.limit || null
                let result = await commentModel.getComment(type,type_id, page, limit)
                for(let i=0; i<result.length; i++){
                    let item = result[i]
                    let reply_list = await commentModel.getCommentReply(item.id)
                    let user_info = await userModel.getDataById('user', item.user_id)
                    result[i].reply = reply_list
                    result[i].user = {
                        id: user_info[0].id,
                        img: user_info[0].img,
                        name:  user_info[0].name
                    }
                }
                res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
}

module.exports = new commentController()