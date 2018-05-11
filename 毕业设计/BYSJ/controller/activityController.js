'use strict'
const activityModel = require("../model/activityModel")
const articleModel = require("../model/articleModel")
const activityColumnModel = require("../model/activityColumnModel")
const prizeModel = require("../model/prizeModel")
class activityController{
    // 添加活动
    addActivity(req,res){
        let async = async ()=>{
            try{
                let obj = {
                    name: req.body.name,
                    activity_column_id: req.body.activity_column_id,
                    start_time: req.body.start_time,
                    end_time: req.body.end_time
                }
                let result = await activityModel.addTableData('activity',obj) 
                if(result.insertId) return res.json(retMsg.success('','添加活动成功'))
                return res.status(400).send(retMsg.error('添加活动失败'))
            } catch (err){
                return res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 修改活动
    updateActivityById(req,res){
        let async = async ()=>{
            try{
                let obj = req.body
                let result = await activityModel.updateTableById('activity', req.params.id, obj) 
                return res.json(retMsg.success(result))
            } catch (err){
                return res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 活动发布/取消发布
    updateActivityPublishById(req,res){
        let async = async ()=>{
            try{
                let is_publish = parseInt(req.body.is_publish)
                if(is_publish !== 1 && is_publish !== 0) return res.status(400).send(retMsg.error('参数值错误'))
                let result = await activityModel.updateActivityPublishById(req.params.id, is_publish) 
                return res.json(retMsg.success())
            } catch (err){
                return res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 删除活动
    deleteActivityById(req,res){
        let async = async ()=>{
            try{
                let result = await activityModel.deleteTableById('activity', req.params.id) 
                if(result.affectedRows>0) return res.json(retMsg.success())
                return res.status(400).send(retMsg.error())
            } catch (err){
                return res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    getActivity(req,res){
        let async = async ()=>{
            try{
                let result = await activityModel.getDataById('activity',req.params.id) 
                res.json(retMsg.success(result[0]))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    getRunningActivity(req,res){
        let async = async ()=>{
            try{
                let result = await activityModel.getRunningActivity() 
                res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 获取活动年份
    getActivityYear(req,res){
        let async = async ()=>{
            try{
                // 获取活动年份列表
                let result = await activityModel.getActivityYears() 
                    return res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
     // 获取该年份下的活动
     getActivityByYear(req,res){
        let async = async ()=>{
            try{
                let result = await activityModel.getActivityByYear(req.params.year) 
                    return res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 获取活动栏目
    getActivityColumn(req,res){
        let async = async ()=>{
            try{
                let result = await activityColumnModel.getActivityColumn() 
                res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 获取所有年份及年份下的活动列表
    getActivityOrderByYear(req,res){
        let async = async ()=>{
            try{
                // 获取活动年份列表
                let years = await activityModel.getActivityYears() 
                let arr = years.map((item)=>{
                    return activityModel.getActivityByYear(item.year)
                })
                let result = []
                Promise.all(arr).then((values)=>{
                    values.forEach((item,i)=>{
                        let obj = {}
                        obj.year = years[i].year
                        obj.activities = item
                        result.push(obj)
                    })
                    return res.json(retMsg.success(result))
                })
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 获取当前活动的获奖列表
    getPrizeList(req,res){
        let async = async ()=>{
            try{
                let activity_id = req.params.id
                let activity_info = await activityModel.getDataById('activity',activity_id)
                if(activity_info[0].is_publish==0) return res.json(retMsg.success())
                let result = await prizeModel.getPrizeList(activity_id) 
                res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 获取所有状态的稿件列表（活动分栏稿件）
    getActivityArticleListById(req,res){
        let async = async ()=>{
            try{
                let page = req.query.page||undefined
                let limit = req.query.limit||undefined
                if(page != null) page = parseInt(page)
                if(limit != null) limit = parseInt(limit)
                let result = await articleModel.getActivityArticleListById(req.params.id,page,limit)
                let count = await articleModel.getActivityArticleListCountById(req.params.id)
                let all_page = 1
                if(limit != null) all_page = Math.ceil(count/limit)
                res.json(retMsg.success({data:result,all_page:all_page}))
            } catch (err){
                console.log(err)
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 获取为审核的稿件列表（活动分栏稿件）
    getProcessingActivityArticleListById(req,res){
        let async = async ()=>{
            try{
                let page = req.query.page||undefined
                let limit = req.query.limit||undefined
                if(page != null) page = parseInt(page)
                if(limit != null) limit = parseInt(limit)
                let result = await articleModel.getProcessingActivityArticleListById(req.params.id,page,limit)
                let count = await articleModel.getActivityArticleListCountById(req.params.id)
                let all_page = 1
                if(limit != null) all_page = Math.ceil(count/limit)
                res.json(retMsg.success({data:result,all_page:all_page}))
            } catch (err){
                console.log(err)
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 设置稿件得分
    setScore(req,res){
        let async = async ()=>{
            try{
                let obj = {
                    article_id : req.body.article_id,
                    user_id : req.session.user.id,
                    score: req.body.score
                }
                let score_info = await activityModel.getScoreInfo(obj)
                let result = ''
                if(score_info.length == 0){
                    result = await activityModel.addTableData('activity_score',obj)
                } else{
                    let id = score_info[0].id
                    result = await activityModel.updateTableById('activity_score', id, obj)
                }
                return res.json(retMsg.success('删除成功'))
            } catch (err){
                console.log(err)
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 设置稿件奖项
    setPrize(req,res){
        let async = async ()=>{
            try{
                let obj = {
                    activity_id: req.body.activity_id,
                    article_id: req.params.id,
                    prize_type: req.body.prize
                }
                let prize_info = await prizeModel.getPrizeByArticleId(req.params.id)
                let result = ''
                if(prize_info.length == 0){
                    result = await prizeModel.addTableData('prize',obj)
                } else{
                    let id = prize_info[0].id
                    result = await activityModel.updateTableById('prize', id, obj)
                }
                return res.json(retMsg.success('奖项设置成功'))
            } catch (err){
                console.log(err)
                res.status(400).send(retMsg.error('奖项设置失败'))
            }
        }
        async()
    }
}

module.exports = new activityController()