'use strict'
const Model = require('./model')
class CategoryModel extends Model{
    // 获取栏目信息
    getCategory(){
        let sql = "select * from category"
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql)
                return result
            } catch (err){
                conn.rollback()
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }

    // 获取分类所有信息(不包括内容)（包括各栏目稿件标题7个）
    getCategoryAll(){
        let sql = "select * from category"
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql)
                let articleModel = require('./articleModel')
                for(let i=0; i<result.length; i++){
                    let articles = await articleModel.getArticleByCategoryId(result[i].id,1,7)
                    // 转化时间类型
                    articles = this.tranDateToStr(articles,2)
                    for(let i=0;i<articles.length; i++){
                        // 文章内容url
                        articles[i]['content_url'] = Host+"/page/article/"+ articles[i]['article_content_id']
                    }
                    result[i]['articles'] = articles
                }
                return result
            } catch (err){
                conn.rollback()
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 通过category_id获取该类别文章排行榜
    getCategoryRankById(category_id, ignore_id, count=10){
        // 权值，暂定
        let weight = 3.03;
        // 受欢迎程度 ： 点击率/(现在-创建时间得到的天数+权值)
        let sql = `SELECT id, category_id, name, all_click / (to_days(now()) - TO_DAYS(create_time) + 3.03) AS score
                    FROM article
                    WHERE category_id = ? and id not in (?) and is_show = 1
                    ORDER BY score DESC, create_time DESC
                    LIMIT ?`
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql, [category_id, ignore_id, count])
                return result
            } catch (err){
                conn.rollback()
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 获取所有类别文章排行榜
    getCategoryRank(count=10){
        // 权值，暂定
        let weight = 3.03;
        // 受欢迎程度 ： 点击率/(现在-创建时间得到的天数+权值)
        let sql = `SELECT id, category_id, name, all_click / (to_days(now()) - TO_DAYS(create_time) + 3.03) AS score
                    FROM article
                    WHERE is_show = 1
                    ORDER BY score DESC, create_time DESC
                    LIMIT ?`
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql, [count])
                return result
            } catch (err){
                conn.rollback()
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
}

module.exports = new CategoryModel()