'use strict'
const articleModel = require("../model/articleModel")
class articleController {
    // 获取稿件列表（包括状态和奖项）
    getArticleList(req,res){
        let async = async ()=>{
            try{
                let page = req.query.page||undefined
                let limit = req.query.limit||undefined
                if(page != null) page = parseInt(page)
                if(limit != null) limit = parseInt(limit)
                let result = await articleModel.getArticleList(page,limit)
                let count = await articleModel.getArticleListCount()
                let all_page = 1
                if(limit != null) all_page = Math.ceil(count/limit)
                res.json(retMsg.success({data:result,all_page:all_page}))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 保存手写文章
    addTextArticle(req,res){
        let async = async ()=>{
            try{
                let result = await articleModel.addArticle({
                    type: req.body.type.split("-")[0],
                    type_id: req.body.type.split("-")[1],
                    name: req.body.name,
                    content: req.body.content,
                    user_id: req.session.user.id
                })
                res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 保存文件上传的文章
    addFileArticle(req,res){
        let async = async ()=>{
            try{
                let result = await articleModel.addArticle({
                    type: req.fields.type[0].split("-")[0],
                    type_id: req.fields.type[0].split("-")[1],
                    name: req.fields.title[0],
                    content: Common.tranDocxToHtml(req.files.file[0].path),
                    user_id: req.session.user.id
                })
                return res.redirect(Host+'/page/userPersonal');
            } catch (err){
                return res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 获取文章信息
    getArticleById(req,res){
        let async = async ()=>{
            try{
                let result = await articleModel.getArticleById(req.params.id) 
                if(result.length == 0){
                   return res.status(404).send(retMsg.error('文章不存在'))
                }
                result = result[0]
                let user = await articleModel.getDataById('user',result.user_id)
                if(user.length == 0){
                    result['author'] = ''
                    return res.json(retMsg.success(result))
                }
                user = user[0]
                result['author'] = user.name
                res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 获取文章内容
    getArticleContentById(req,res){
        let async = async ()=>{
            try{
                let result = await articleModel.getArticleContentById(req.params.id) 
                res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 根据key模糊查询文章名称返回所有信息（包括内容）
    getArticleWithContentByKey(req,res){
        let async = async ()=>{
            try{
                let result = await articleModel.getArticleWithContentByKey(req.query.key) 
                res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 更新文章信息
    undateArticle(req,res){
        let async = async ()=>{
            try{
                let result = await articleModel.updateTableById('article',req.params.id,req.body) 
                if(result.affectedRows){
                    return res.json(retMsg.success('修改成功'))
                }else{
                    return res.status(400).json(retMsg.error('修改失败'))                   
                }
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 删除文章
    deleteArticle(req,res){
        let async = async ()=>{
            try{
                let result = await articleModel.deleteArticle(req.params.id) 
                return res.json(retMsg.success('删除成功'))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    
}

module.exports = new articleController()