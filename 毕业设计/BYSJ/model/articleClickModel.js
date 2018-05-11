'use strict'
const Model = require('./model')
class articleClickModel extends Model{
    // 统计每日点击量
    setDayClick(){
        let sql   = 'select id, user_id, day_click from article where day_click != 0'
        let sql2  = 'insert into article_click( article_id, user_id, day_click ) values(?,?,?)'
        let sql3  = 'update article set day_click = 0 where id = ?'
        let async = async (conn)=>{
            try{
                let article_list = await conn.queryAsync(sql)
                if(article_list.length <= 0) return
                // 检查当前月份的分区是否存在
                let ifPartition = await this.checkPartition()
                // 如果分区不存在则创建分区
                if(!ifPartition) await this.createPartition()
                // 开启事务
                await conn.beginTransactionAsync()
                for(let i=0; i<article_list.length; i++){
                    let article_id = article_list[i].id
                    let user_id = article_list[i].user_id
                    let day_click  = article_list[i].day_click
                    // 写入点击统计表
                    await conn.queryAsync(sql2, [article_id, user_id, day_click])
                    // 文章表day_click归零
                    await conn.queryAsync(sql3, [article_id])
                }     
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
    // 检查文章点击表月份分区
    // name: 分区名，p_201801 
    checkPartition(name){
        name = name || 'p_'+Common.getDateTime('').slice(0,6)
        let sql = 'ALTER TABLE article_click CHECK partition ??'
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
    // 创建文章点击表当前月份分区
    // name: 分区名，p_201801 
    createPartition(){
        let name = 'p_'+Common.getDateTime('').slice(0,6)
        // 下个月一号秒级时间戳
        let date = new Date()
        let time = (new Date(date.getFullYear(), date.getMonth()+1, date.getDate())).getTime()/1000|0
        let sql = 'alter table article_click add partition (partition ?? values LESS THAN (?))'
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

module.exports = new articleClickModel()