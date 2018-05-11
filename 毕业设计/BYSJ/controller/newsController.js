'use strict'
const userModel = require("../model/userModel")
const articleModel = require("../model/articleModel")
const newsModel = require("../model/newsModel")
class newsController {
    // 添加消息
    addNews(req,res){
        let async = async ()=>{
            try{
                let obj = {
                    name: req.body.name,
                    content: req.body.content,
                    user_id: req.session.user.id
                }
                let result = await newsModel.addNews(obj) 
                if(result.insertId) return res.json(retMsg.success('','添加消息成功'))
                return res.status(400).send(retMsg.error('添加消息失败'))
            } catch (err){
                return res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 删除消息
    deleteNewsById(req,res){
        let async = async ()=>{
            try{
                let result = await newsModel.deleteNews(req.params.id) 
                if(result.affectedRows>0) return res.json(retMsg.success())
                return res.status(400).send(retMsg.error())
            } catch (err){
                return res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 获取消息年份
    getNewsYear(req,res){
        let async = async ()=>{
            try{
                // 获取活动年份列表
                let result = await newsModel.getNewsYears() 
                    return res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 根据年份获取消息列表
    getNewsListByYear(req,res){
        let async = async ()=>{
            try{
                let result = await newsModel.getNewsListByYear(req.params.year) 
                res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 获取消息列表
    getNewsList(req,res){
        let async = async ()=>{
            try{
                let count = req.query.count || null
                let result = await newsModel.getnewsList(count) 
                res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
   // 根据id获取消息及内容
   getNewsById(req,res){
    let async = async ()=>{
        try{
            let id = req.params.id
            let result = await newsModel.getNewsById(id) 
            res.json(retMsg.success(result[0]))
        } catch (err){
            res.status(400).send(retMsg.error())
        }
    }
    async()
}

}

module.exports = new newsController()