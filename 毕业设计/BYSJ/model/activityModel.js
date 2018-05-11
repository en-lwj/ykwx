'use strict'
const Model = require("../model/model")
class activityModel extends Model {
    // 获取正在进行的活动
    getRunningActivity(count=null){
        let sql = "select * from activity where start_time < (select now()) and end_time > (select now()) order by create_time desc"
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
    // 获取根据年份获取活动列表
    getActivityByYear(year,count=null){
        let sql = `SELECT  id,  activity_column_id,  name, is_publish,
                        DATE_FORMAT(create_time, '%Y-%m-%d %H:%i:%s') AS create_time,
                        DATE_FORMAT(start_time, '%Y-%m-%d %H:%i:%s') AS start_time,
                        DATE_FORMAT(end_time, '%Y-%m-%d %H:%i:%s') AS end_time
                    FROM  activity
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
    getActivityYears(){
        let sql = `SELECT
                        DATE_FORMAT(create_time, '%Y') AS year
                    FROM
                        activity
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
    // 根据article_id,user_id 获取 score 数据
    getScoreInfo(obj){
        let sql = `SELECT
                        *
                    FROM
                        activity_score
                    WHERE user_id = ? and article_id = ? `
        let async = async (conn)=>{
            try{
                let result = await conn.queryAsync(sql, [obj.user_id, obj.article_id])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 发布/取消发布
    updateActivityPublishById(activity_id,is_publish){
        let sql1 = `UPDATE article a
                    LEFT JOIN prize p ON a.id = p.article_id
                    SET a.is_show = (
                        CASE
                            WHEN p.prize_type > 0 THEN 1
                            ELSE 0
                        END
                    )
                    WHERE a.activity_id = ?`
        let sql2 = `UPDATE article a
                        LEFT JOIN prize p ON a.id = p.article_id
                        SET a.is_show = 0
                        WHERE a.activity_id = ?`

        let async = async (conn)=>{
            try{
                await conn.beginTransactionAsync()
                is_publish = parseInt(is_publish)
                let result = ''
                if(is_publish === 1) result = await conn.queryAsync(sql1,[activity_id])
                else if(is_publish === 0) result = await conn.queryAsync(sql2,[activity_id])
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
}

module.exports = new activityModel()