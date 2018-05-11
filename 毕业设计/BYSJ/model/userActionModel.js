'use strict'
const Model = require('./model')
class userActionModel extends Model{
    // 获取用户浏览文章信息
    // user_id: 用户Id， start_date: YYYY/MM/dd， end_date: YYYY/MM/dd
    // return [{category_id, article_ids: '1,2,3', count: 123}]
    getUserRead(user_id, start_date, end_date){
        // 暂时不统计活动类型
        let sql = 'select category_id, GROUP_CONCAT(distinct article_id ORDER BY article_id) as article_ids, count(id) as count '
                + ' from user_action '
                + ' where user_id = ? and read_time > ? and read_time <= ? and category_id != 0 '
                + ' GROUP BY category_id ORDER BY count desc'
        let async = async (conn)=>{
            try{
                // 成功返回 category_id, article_ids 数组,  count 数组
                let result = await conn.queryAsync(sql, [user_id, start_date, end_date])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 保存用户浏览文章信息
    //article_id： 浏览的文章id
    saveUserRead(user_id, article_id){
        let sql = 'insert into user_action(user_id, article_id, category_id, activity_id, article_name) values (?,?,?,?,?)'
        let async = async (conn)=>{
            try{
                // 检查当前月份的分区是否存在
                let ifPartition = await this.checkPartition()
                // 如果分区不存在则创建分区
                if(!ifPartition) await this.createPartition()
                // 查找article信息
                let article = (await this.getDataById('article',article_id))[0]
                // 保存用户行为数据
                let result = await conn.queryAsync(sql, [user_id, article_id, article.category_id, article.activity_id, article.name])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 检查用户表月份分区
    // name: 分区名，p_201801 / p_all
    checkPartition(name){
        var name = name || 'p_'+Common.getDateTime('').slice(0,6)
        let sql = 'ALTER TABLE user_action CHECK partition ??'
        let async = async (conn)=>{
            try{
                // 成功返回一条信息，错误两条，其中一条是错误信息
                let result = await conn.queryAsync(sql, [name])
                console.log(result)
                if(result.length == 2){
                    return false
                }
                return true
            } catch (err){
                console.log(err)
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 并创建用户表当前月份分区
    // name: 分区名，p_201801 
    createPartition(){
        let name = 'p_'+Common.getDateTime('').slice(0,6)
        // 下个月一号秒级时间戳
        let date = new Date()
        let time = (new Date(date.getFullYear(), date.getMonth()+1, date.getDate())).getTime()/1000|0
        let sql = 'alter table user_action add partition (partition ?? values LESS THAN (?))'
        let async = async (conn)=>{
            try{
                // 成功返回一条信息，错误两条，其中一条是错误信息
                let result = await conn.queryAsync(sql, [name, time])
                return true
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
}

module.exports = new userActionModel()