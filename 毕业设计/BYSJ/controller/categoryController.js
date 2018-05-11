'use strict'
const categoryModel = require("../model/categoryModel")
const articleModel = require("../model/articleModel")
class categoryController {

    getCategoryById(req,res){
        let async = async ()=>{
            try{
                let result = await categoryModel.getDataById('category',req.query.id) 
                res.json(retMsg.success(result[0]))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 获取栏目信息
    getCategory(req,res){
        let async = async ()=>{
            try{
                let result = await categoryModel.getCategory(req) 
                res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 获取分类所有信息（包括各栏目稿件标题7个）
    getCategoryAll(req,res){
        let async = async ()=>{
            try{
                let result = await categoryModel.getCategoryAll(req) 
                res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 获取该分类所有文章及具体内容（默认每页10条）
    getArticleWithContentByCategoryId(req,res){
        let async = async ()=>{
            try{
                var obj  = {
                    id: req.query.id,
                    page: req.query.page || 1,
                    limit: req.query.limit || 10
                }
                let result = await articleModel.getArticleWithContentByCategoryId(obj.id, obj.page, obj.limit) 
                res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 获取该分类文章数量
    getArtileCountByCategoryId(req,res){
        let async = async ()=>{
            try{
                let id = req.query.id
                let result = await articleModel.getArtileCountByCategoryId(id) 
                res.json(retMsg.success({count:result}))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 获取为审核的稿件列表（日常分栏稿件）
    getProcessingCategoryArticleList(req,res){
        let async = async ()=>{
            try{
                let page = req.query.page||undefined
                let limit = req.query.limit||undefined
                if(page != null) page = parseInt(page)
                if(limit != null) limit = parseInt(limit)
                let result = await articleModel.getProcessingCategoryArticleList(page,limit)
                let count = await articleModel.getProcessingCategoryArticleListCount()
                let all_page = 1
                if(limit != null) all_page = Math.ceil(count/limit)
                res.json(retMsg.success({data:result,all_page:all_page}))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }

}

module.exports = new categoryController()