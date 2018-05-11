'use strict'
const Model = require('./model')
class articleModel extends Model{
    // 添加稿件
    // obj{id,type,name,content}
    addArticle(obj){
        let sql1 = "insert into article_content value(default,?)"
        let sql2 = "insert into article(??, name, user_id, article_content_id) value(?,?,?,?)"
        let async = async (conn)=>{
            try{
                await conn.beginTransactionAsync()
                let result1 = await conn.queryAsync(sql1,[obj.content])
                let result2 = await conn.queryAsync(sql2,[obj.type+'_id', obj.type_id, obj.name, obj.user_id, result1.insertId])
                await conn.commit()
                if(result2.insertId){
                    return retMsg.success('投稿成功')
                } else {
                    return retMsg.error('投稿失败')                    
                }
            } catch (err){
                conn.rollback()
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 获取日常分栏文章信息（不包括内容）
    getArticleByCategoryId(id,page=null,limit=null){
        let sql = "select * from article where category_id = ? and is_show = 1 order by create_time desc"
        if(page != null) {
            page = parseInt(page)
            limit = limit !=null? parseInt(limit): 10
            let start = (page-1)*limit
            let end = limit
            sql += ' LIMIT '+ start + ',' + end
        }
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql,[id])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 获取栏目文章数量
    getArtileCountByCategoryId(id){
        let sql = `SELECT
                        count(a.id) as count
                    FROM
                        article a
                    WHERE
                        a.category_id = ? and a.is_show=1 `
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql,[id])
                return result[0].count
            } catch (err){
                conn.rollback()
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 获取日常分栏文章信息（包括内容）
    getArticleWithContentByCategoryId(id,page=null,limit=null){
        let sql  =  `SELECT
                        a.*, DATE_FORMAT(a.create_time,'%Y-%m-%d') as create_time, b.content, c.name as author
                    FROM
                        article a
                    LEFT JOIN article_content b ON a.article_content_id = b.id
                    LEFT JOIN user c ON a.user_id = c.id
                    WHERE
                        a.category_id = ? and a.is_show = 1
                    ORDER BY
                        a.create_time DESC `
        if(page != null) {
            page = parseInt(page)
            limit = limit !=null? parseInt(limit): 10
            let start = (page-1)*limit
            let end = limit
            sql += ' LIMIT '+ start + ',' + end
        }
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql,[id])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 根据key模糊查询文章名称返回所有信息（包括内容）
    getArticleWithContentByKey(key,page=null,limit=null){
        key = '%'+key+'%'
        let sql  =  `SELECT
                        a.*, DATE_FORMAT(a.create_time,'%Y-%m-%d') as create_time, b.content, c.name as author
                    FROM
                        article a
                    LEFT JOIN article_content b ON a.article_content_id = b.id
                    LEFT JOIN user c ON a.user_id = c.id
                    WHERE
                        a.name like ?
                    ORDER BY
                        a.create_time DESC `
        if(page != null) {
            page = parseInt(page)
            limit = limit !=null? parseInt(limit): 10
            let start = (page-1)*limit
            let end = limit
            sql += ' LIMIT '+ start + ',' + end
        }
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql,[key])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 获取文章信息
    getArticleById(id){
        let sql = `select 
                    *,
                    DATE_FORMAT(create_time,'%Y-%m-%d') as create_time,
                    DATE_FORMAT(update_time,'%Y-%m-%d %H:%i:%s') as update_time
                    from article 
                    where id = ? and is_show = 1`
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql,[id])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 获取文章内容
    getArticleContentById(id){
        let sql = "select * from article_content where id = ?"
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql,[id])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 删除文章和内容
    deleteArticle(id){
        let async = async (conn)=>{
            try{
                await conn.beginTransactionAsync()
                let article_info = await this.getDataById('article',id)
                await this.deleteTableById('article_content',article_info[0].article_content_id)
                let result = await this.deleteTableById('article',id)
                await conn.commit()
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
    // 文章点击量+1
    addClick(id){
        let sql   = 'select id from article where id = ?'
        let sql2  = `update article set day_click = day_click+1, all_click = all_click+1 where id = ?`
        let async = async (conn)=>{
            try{
                let result1 = await conn.queryAsync(sql,id)
                if(result1.length <= 0) return
                let result = await conn.queryAsync(sql2,id)                
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 获取文章数量
    getArticleListCount(){
        let sql = `SELECT count(*) as count
                FROM article a
                WHERE a.is_show != 0 `
        let async = async (conn)=>{
            try{              
                let result = await conn.queryAsync(sql)
                return result[0].count
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 获取文章列表及状态(不获取未审核的)
    getArticleList(page=null,limit=10){
        let sql = `SELECT
                    a.id,
                    a.name,
                    a.all_click,
                    u.name as author,
                    c. NAME AS category_name,
                    act. NAME AS activity_name,
                    DATE_FORMAT(a.create_time, '%Y-%m-%d') AS create_time,
                    a.is_show,
                CASE
                    WHEN a.activity_id = 0 THEN '日常'
                    ELSE '活动'
                    END AS type,
                CASE
                    WHEN p.prize_type = 10 THEN '特等奖'
                    WHEN p.prize_type = 11 THEN '一等奖'
                    WHEN p.prize_type = 12 THEN '二等奖'
                    WHEN p.prize_type = 13 THEN '三等奖'
                    WHEN p.prize_type = 14 THEN '优秀奖'
                    ELSE '无'
                    END AS 'prize',
                CASE 
                    WHEN r.article_id is NULL THEN '0'
                    ELSE '1'
                    END AS 'is_recommend'
                FROM article a
                LEFT JOIN user u ON u.id = a.user_id
                LEFT JOIN prize p ON a.id = p.article_id
                LEFT JOIN category c ON a.category_id = c.id
                LEFT JOIN activity act ON a.activity_id = act.id
                LEFT JOIN recommend r ON a.id = r.article_id
                WHERE a.is_show != 0
                ORDER BY a.create_time DESC `
        if(page != null) {
            page = parseInt(page)
            limit = limit !=null? parseInt(limit): 10
            let start = (page-1)*limit
            let end = limit
            sql += ' LIMIT '+ start + ',' + end
        }
        let async = async (conn)=>{
            try{              
                let result = await conn.queryAsync(sql)
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 获取文章数量（未审核日常分栏稿件）
    getProcessingCategoryArticleListCount(){
        let sql = `SELECT count(*) as count
                FROM article a
                WHERE a.is_show = 0 and a.category_id != 0 `
        let async = async (conn)=>{
            try{              
                let result = await conn.queryAsync(sql)
                return result[0].count
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 获取为审核的稿件列表（日常分栏稿件）
    getProcessingCategoryArticleList(page=null,limit=10){
        let sql = `SELECT
                    a.id,
                    a.name,
                    a.article_content_id,
                    u.name as author,
                    c. NAME AS category_name,
                    DATE_FORMAT(a.create_time, '%Y-%m-%d') AS create_time,
                    a.is_show
                FROM article a
                LEFT JOIN user u ON u.id = a.user_id
                LEFT JOIN category c ON a.category_id = c.id
                WHERE a.is_show = 0 and a.category_id != 0
                ORDER BY a.create_time DESC `
        if(page != null) {
            page = parseInt(page)
            limit = limit !=null? parseInt(limit): 10
            let start = (page-1)*limit
            let end = limit
            sql += ' LIMIT '+ start + ',' + end
        }
        let async = async (conn)=>{
            try{              
                let result = await conn.queryAsync(sql)
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 根据id获取为审核的稿件列表（活动分栏稿件）( 获奖列表已发布则不查询)
    getProcessingActivityArticleListById(id,page=null,limit=10){
        let sql = `SELECT
                    a.id,
                    a.name,
                    s.score,
                    a.article_content_id,
                    u.name as author,
                    act.name AS activity_name,
                    DATE_FORMAT(a.create_time, '%Y-%m-%d') AS create_time,
                    a.is_show
                FROM article a
                LEFT JOIN user u ON u.id = a.user_id
                LEFT JOIN activity act ON a.activity_id = act.id
                LEFT JOIN activity_score s ON a.id = s.article_id
                WHERE a.activity_id = ? and a.is_show = 0 and act.is_publish = 0
                ORDER BY s.score DESC, a.create_time DESC `
        if(page != null) {
            page = parseInt(page)
            limit = limit !=null? parseInt(limit): 10
            let start = (page-1)*limit
            let end = limit
            sql += ' LIMIT '+ start + ',' + end
        }
        let async = async (conn)=>{
            try{              
                let result = await conn.queryAsync(sql,[id])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 根据id获取文章数量（未审核活动分栏稿件）
    getActivityArticleListCountById(id){
        let sql = `SELECT count(*) as count
                FROM article a
                LEFT JOIN activity act ON a.activity_id = act.id
                WHERE a.is_show = 0 and a.activity_id = ? and act.is_publish = 0`
        let async = async (conn)=>{
            try{              
                let result = await conn.queryAsync(sql,[id])
                return result[0].count
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 根据id获取为审核的稿件列表（活动分栏稿件）
    getActivityArticleListById(id,page=null,limit=10){
        let sql = `SELECT
                        a.id,
                        a.name,
                        s.score,
                        p.prize_type,
                        a.article_content_id,
                        u.name as author,
                        act.name AS activity_name,
                        DATE_FORMAT(a.create_time, '%Y-%m-%d') AS create_time,
                        a.is_show
                    FROM article a
                    LEFT JOIN user u ON u.id = a.user_id
                    LEFT JOIN activity act ON a.activity_id = act.id
                    LEFT JOIN (select avg(score) as score,article_id from activity_score GROUP BY article_id) s ON a.id = s.article_id
                    LEFT JOIN prize p ON p.article_id = a.id
                    WHERE a.activity_id = ?
                    ORDER BY (case when p.prize_type = 0 then 10000 else p.prize_type end) ASC, s.score DESC, a.create_time DESC `
        if(page != null) {
            page = parseInt(page)
            limit = limit !=null? parseInt(limit): 10
            let start = (page-1)*limit
            let end = limit
            sql += ' LIMIT '+ start + ',' + end
        }
        let async = async (conn)=>{
            try{              
                let result = await conn.queryAsync(sql,[id])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 获取总排名
    getRanks(){
        let async = async ()=>{
            let result = {}
            try{
                result.weekRank = await this.getWeekRank(10)
                result.monthRank = await this.getMonthRank(10)
                result.allRank = await this.getAllRank(10)
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return async()
    }
    // 获取周排名
    getWeekRank(count=null){
        let sql = `select b.*, sum(a.day_click) as month_click 
                   from article_click a
                   left join article b
                   on a.article_id = b.id
                   where a.create_time >= ? and a.create_time < ? and b.is_show = 1
                   GROUP BY a.article_id 
                   order by month_click `
        count != null && (sql += ' limit ?')
        // let week_date = Common.getThisWeekMonday()
        // let week_start = week_date.toLocaleDateString()
        // let week_end = (new Date(week_date.getFullYear(), week_date.getMonth(), week_date.getDate()+7)).toLocaleDateString()
        let now_date = new Date()
        let start_date = (new Date(now_date.getFullYear(), now_date.getMonth(), now_date.getDate()-7)).toLocaleDateString()
        let end_date = now_date.toLocaleDateString()
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql,[start_date, end_date, count])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }

    // 获取月排名
    getMonthRank(count=null){
        let sql = `select b.*, sum(a.day_click) as month_click 
                   from article_click a
                   left join article b
                   on a.article_id = b.id
                   where a.create_time >= ? and a.create_time < ? and b.is_show = 1
                   GROUP BY a.article_id 
                   order by month_click `
        count != null && (sql += ' limit ?')
        let date = new Date()
        let this_month = date.getFullYear()+'/'+(date.getMonth()+1)+'/1'
        let next_month = date.getFullYear()+'/'+(date.getMonth()+2)+'/1'
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql,[this_month, next_month, count])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }


    // 获取总点击排名
    getAllRank(count=null){
        let sql = `select * 
                    from article 
                    where is_show = 1
                    order by all_click desc`
        count != null && (sql += ' limit ?')
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql,[count])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }

}

module.exports = new articleModel()