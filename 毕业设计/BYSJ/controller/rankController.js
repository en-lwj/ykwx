'use strict'
const userActionModel = require("../model/userActionModel")
const categoryModel = require("../model/categoryModel")
const articleModel = require("../model/articleModel")
class rankController {
    // req.query.count：要返回数据的条数，如果没有默认6条
    getUserLike(req,res){
        // 数据分析用户一个月以来的浏览记录
        let async = async ()=>{
            try{
                let count = parseInt(req.query.count)||6
                // 1.如果用户登录了
                if(req.session.user){
                    // 获取用户一个月来的类别浏览次数数据
                    let user_id = req.session.user.id
                    let end_time = new Date()
                    let start_time = new Date(end_time.getFullYear(), end_time.getMonth()-1, end_time.getDate())
                    let category_count = await userActionModel.getUserRead(user_id, start_time.toLocaleDateString(), end_time.toLocaleDateString())
                    // 如果该月内用户数据为空 执行2
                    if(category_count.length == 0){
                        // 获取所有类别排行榜
                        let result = await categoryModel.getCategoryRank(count) 
                        return res.json(retMsg.success(result))
                    }
                    // 获取数据
                    // 总条数
                    let all_count = 0
                    category_count.forEach(item => {
                        all_count += item.count
                    })
                    let promise_all = []
                    // 需查询条数 count, 剩余查询条数 rest_count
                    let rest_count = count
                    category_count.forEach(item => {
                        if(rest_count==0) return
                        // 该类别获取数据的条数，向上取整
                        let item_count = Math.ceil(item.count/all_count * count)
                        if(rest_count<item_count){
                            item_count = rest_count, rest_count = 0
                        } else{
                            rest_count -= item_count
                        }
                        // 该类别返回的数据
                        promise_all.push(categoryModel.getCategoryRankById(item.category_id, item.article_ids.split(','), item_count))
                    })
                    let result = []
                    await Promise.all(promise_all).then(res=>{
                        res.forEach(item=>{
                            result = result.concat(item)
                        })
                    })
                    return res.json(retMsg.success(result))
                } else {
                    // 2.如果用户没有登录
                    // 获取所有类别排行榜
                    let result = await categoryModel.getCategoryRank(count) 
                    return res.json(retMsg.success(result))
                }
            } catch (err){
                console.log(err)
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }

    // 获取所有排名
    getRanks(req,res){
        let async = async ()=>{
            try{
                let result = await articleModel.getRanks() 
                res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
}

module.exports = new rankController()