'use strict'
const Model = require('./model')
class userModel extends Model{
    // 判断该字段filed是否存在值value
    //obj:{filed,value}
    //filed,value
    getExist(){
        let obj = arguments.length == 1? arguments[0] : {filed: arguments[0], value: arguments[1]}
        let sql = "select id from user where ?? = ? limit 1"
        async function async(conn){
            try{
                let result = await conn.queryAsync(sql, [obj.filed, obj.value])
                return result.length >0 ? true : false
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    login(obj){
        let sql = "select * from user where ( account = ? or name = ? or email = ? ) and password = ? limit 1"
        async function async(conn){
            try{
                let result = await conn.queryAsync(sql,[obj.account, obj.account, obj.account, obj.password])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // obj:{email,password}
    changePwd(obj){
        let sql = "update user set password = ? where email = ?"
        async function async(conn){
            try{
                let result = await conn.queryAsync(sql,[obj.password, obj.email])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    register(obj){
        let sql = "insert into user set ?"
        async function async(conn){
            try{ 
                // 存入数据库               
                let result = await conn.queryAsync(sql, obj)
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    getUserList(){
        let sql = "select * from user"
        async function async(conn){
            try{ 
                // 存入数据库               
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
    // 获取个人投稿列表及状态
    getArticleListByUserId(user_id){
        let sql = `SELECT
                        a.id,
                        a.name,
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
                    END AS 'prize'
                    FROM article a
                    LEFT JOIN prize p ON a.id = p.article_id
                    LEFT JOIN category c ON a.category_id = c.id
                    LEFT JOIN activity act ON a.activity_id = act.id
                    WHERE a.user_id = ?
                    ORDER BY a.create_time DESC `
        async function async(conn){
            try{              
                let result = await conn.queryAsync(sql,[user_id])
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

module.exports = new userModel()