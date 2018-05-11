'use strict'
class commentModel{
    // 添加评论
    addComment(type, type_id,content,user_id){
        let sql = `INSERT INTO COMMENT (type, type_id, content, user_id) VALUES (?,?, ?, ?)`
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql,[type, type_id, content, user_id])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 回复评论
    addCommentReply(reply_id,content,user_id){
        let sql = `INSERT INTO COMMENT (reply_id, content, user_id) VALUES (?, ?, ?)`
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql,[reply_id, content, user_id])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 获取评论
    getComment(type,type_id,page=null,limit=null){
        let sql  =  `SELECT
                        c.*, DATE_FORMAT(c.create_time,'%Y-%m-%d %H:%i:%s') as create_time
                    FROM
                        comment c
                    WHERE
                        c.type = ? and c.type_id = ? and c.reply_id = 0 and c.is_show = 1
                    ORDER BY
                        c.like_num DESC, c.create_time DESC `
        if(page != null) {
            limit = limit !=null? limit: 10
            let start = (page-1)*limit
            let end = page*limit
            sql += ' LIMIT '+ start + ',' + end
        }
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql,[type, type_id])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 获取评论回复
    getCommentReply(comment_id){
        let sql  =  `SELECT
                        c.*, DATE_FORMAT(c.create_time,'%Y-%m-%d') as create_time
                    FROM
                        comment c
                    WHERE
                        c.reply_id = ? and c.is_show = 1
                    ORDER BY
                        c.create_time ASC `
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql,[comment_id])
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

module.exports = new commentModel()