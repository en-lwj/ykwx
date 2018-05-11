'use strict'
const Model = require('./model')
class praiseModel extends Model{
    // 获取活动类型列表
    getPraiseByTypeIdAndUserId(type,type_id,user_id){
        let sql  =  `SELECT
                        *, DATE_FORMAT(create_time,'%Y-%m-%d %H:%i:%s') as create_time
                    FROM
                        praise
                    WHERE
                    type = ? and type_id = ? and user_id = ?
                    ORDER BY
                        create_time DESC `
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql,[type, type_id, user_id])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }

    // 点赞
    addPraise(type, type_id, comment_id, user_id){
        let sql  =  `insert into praise(type, type_id, comment_id, user_id) values(?,?,?,?)`
        let async = async (conn)=>{
            try{
                await conn.beginTransactionAsync()
                let result = await conn.queryAsync(sql,[type, type_id, comment_id, user_id])
                let comment = await this.getDataById('comment',comment_id)
                await this.updateTableById('comment', comment_id , {
                    like_num: comment[0].like_num + 1
                })
                await conn.commit() 
                return true
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

module.exports = new praiseModel()