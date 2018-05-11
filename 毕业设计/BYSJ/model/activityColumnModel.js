'use strict'
class activityColumnModel{
    // 获取活动类型列表
    getActivityColumn(count=null){
        let sql = `SELECT  *  FROM  activity_column`
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

module.exports = new activityColumnModel()