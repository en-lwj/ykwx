'use strict'
const Model = require('./model')
class newsModel extends Model{
    // 添加消息
    addNews(obj){
        let sql1 = `insert into news_content(content) values(?) `
        let sql2 = `insert into news(news_content_id, name, user_id) values(?,?,?) `
        let async = async (conn)=>{
            try{
                await conn.beginTransactionAsync()
                let result_content = await conn.queryAsync(sql1,[obj.content])
                let result = await conn.queryAsync(sql2, [result_content.insertId, obj.name, obj.user_id])
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
    // 删除消息
    deleteNews(id){
        let sql1 = `delete  `
        let sql2 = `insert into news(news_content_id, name, user_id) values(?,?,?) `
        let async = async (conn)=>{
            try{
                await conn.beginTransactionAsync()
                let news_info = await this.getDataById('news',id)
                await this.deleteTableById('news_content',news_info[0].news_content_id)
                let result = await this.deleteTableById('news',id)
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
    // 获取消息列表
    getnewsList(count=null){
        let sql = `SELECT
                        n.id, n.name, DATE_FORMAT(n.create_time, '%Y-%m-%d') AS create_time
                    FROM
                        news n
                    ORDER BY
                        n.create_time DESC `
        count != null && (sql += 'limit ?')
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql,[parseInt(count)])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    //根据id获取消息及内容信息
    getNewsById(id){
        let sql = `SELECT
                        n.id,
                        n.name, 
                        DATE_FORMAT(n.create_time, '%Y-%m-%d') AS create_time, 
                        n.all_click, 
                        u.name as author,
                        nc.content
                    FROM
                        news n
                    LEFT JOIN news_content nc ON n.news_content_id = nc.id
                    LEFT JOIN user u ON n.user_id = u.id
                    WHERE n.id = ?
                    ORDER BY
                        n.create_time DESC `
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql,[id])
                return result 
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn)=>{
            return async(conn)
        })
    }

    // 消息点击量+1
    addClick(id){
        let sql   = 'select id from news where id = ?'
        let sql2  = `update news set all_click = all_click+1 where id = ?`
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
    // 获取根据年份获取消息列表
    getNewsListByYear(year,count=null){
        let sql = `SELECT  n.id,  n.news_content_id,  n.name, n.all_click, u.name as author,
                        DATE_FORMAT(n.create_time, '%Y-%m-%d %H:%i:%s') AS create_time
                    FROM  news n
                    LEFT JOIN user u ON n.user_id = u.id
                    WHERE  DATE_FORMAT(create_time, '%Y') = ?
                    ORDER BY create_time DESC`
        count != null && (sql += ' limit ?')
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql,[year,count])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 获取活动年份列表
    getNewsYears(){
        let sql = `SELECT
                        DATE_FORMAT(create_time, '%Y') AS year
                    FROM
                        news
                    GROUP BY
                        DATE_FORMAT(create_time, '%Y')
                    ORDER BY
                        year DESC`
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

}

module.exports = new newsModel()