'use strict'
const Model = require('./model')
class recommendModel extends Model{
    // 获取推荐列表
    getRecommendList(count=null){
        let sql = `SELECT
                        r.*, a.name, u.name as author,
                        DATE_FORMAT(r.create_time,'%Y-%m-%d') as create_time
                    FROM
                        recommend r
                    LEFT JOIN article a ON r.article_id = a.id
                    LEFT JOIN user u ON u.id = a.user_id
                    ORDER BY
                        r.rank ASC,
                        r.create_time DESC `
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
    //根据article_id获取推荐信息
    getRecommendByArticleId(article_id){
        let sql = `SELECT r.*,DATE_FORMAT(r.create_time,'%Y-%m-%d') as create_time
                from recommend r
                left join article a on a.id = r.article_id
                where r.article_id = ? and a.is_show = 1 and r.show = 1 `
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql,[article_id])
                return result 
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn)=>{
            return async(conn)
        })
    }
    //修改排名
    updateRanks(arr){
        let sql = `update recommend set rank=1000 where rank != 1000`
        let async = async (conn)=>{
            try{
                await conn.beginTransactionAsync()
                await conn.queryAsync(sql)
                for(let i=0; i<arr.length; i++){
                    let item = arr[i]
                    this.updateTableById('recommend',item.id,{rank: item.rank})
                }
                await conn.commit()
                return 'success'
            } catch (err){
                conn.rollback()
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn)=>{
            return async(conn)
        })
    }
}

module.exports = new recommendModel()