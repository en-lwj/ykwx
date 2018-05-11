'use strict'
const Model = require('./model')
class prizeModel extends Model{
    // 根据活动id获取奖项列表
    getPrizeList(activity_id){
        let sql  =  `SELECT
                        p.*, a.name as article_name , u.name as user_name
                    FROM
                        prize p
                    LEFT JOIN article a ON p.article_id = a.id
                    LEFT JOIN user u ON a.user_id = u.id
                    WHERE
                        p.activity_id = ? and p.prize_type != 0
                    ORDER BY
                        p.prize_type ASC `
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql,[activity_id])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 通过article_id查询prize信息
    getPrizeByArticleId(id){
        let sql  =  `SELECT
                        p.*
                    FROM
                        prize p
                    WHERE
                        p.article_id = ? `
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

}

module.exports = new prizeModel()