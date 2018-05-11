'use strict'

const userModel = require("../model/userModel")
const articleModel = require("../model/articleModel")
const recommendModel = require("../model/recommendModel")
class recommendController {
    // 获取推荐列表(不包括详情)
    getRecommendList(req,res){
        let async = async ()=>{
            try{
                let count = req.query.count || null
                let result = await recommendModel.getRecommendList(count) 
                res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 添加recommend
    addRecommend(req,res){
        let async = async ()=>{
            try{
                let article_id = req.params.id
                let obj = req.body
                let result = await recommendModel.addTableData('recommend',obj) 
                if(result.insertId) return res.json(retMsg.success('','添加成功'))
                return res.status(400).send(retMsg.error('添加失败'))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 根据article_id获取推荐信息
    getRecommendByArticleId(req,res){
        let async = async ()=>{
            try{
                let article_id = req.params.id
                let result = await recommendModel.getRecommendByArticleId(article_id) 
                res.json(retMsg.success(result[0]))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 修改编辑语
    updateDescribeById (req,res) {
        let async = async ()=>{
            try{
                let id = req.params.id
                let obj = req.body
                let result = await recommendModel.updateTableById('recommend', id, obj) 
                res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 修改排名
    updateRanks (req,res) {
        let async = async ()=>{
            try{
                let ranks = JSON.parse(req.body.rank)
                let result = await recommendModel.updateRanks(ranks) 
                res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }

}

module.exports = new recommendController()