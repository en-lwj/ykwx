
'use strict'
class Model{
    // 添加数据
    addTableData(table,obj){
        let sql = 'insert into ?? set ?'
        let async = async (conn) =>{
            try{
                let result = await conn.queryAsync(sql, [table, obj])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 根据id获取table表单条数据
    getDataById(table,id){
        let sql = 'select * from ?? where id = ? limit 1'
        let async = async (conn) =>{
            try{
                let result = await conn.queryAsync(sql, [table, id])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 根据id更新tablel表数据
    updateTableById(table,id,obj){
        delete obj.id
        let sql = 'update ?? set ? where id = ?'
        let async = async (conn) =>{
            try{
                let result = await conn.queryAsync(sql, [table, obj, id])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 根据id删除tablel表数据
    deleteTableById(table,id){
        let sql = 'DELETE FROM ?? WHERE id = ?'
        let async = async (conn) =>{
            try{
                let result = await conn.queryAsync(sql, [table, id])
                return result
            } catch (err){
                return Promise.reject(err)
            }
        }
        return Pool.getConn((conn) => {
            return async(conn)
        })
    }
    // 把数组对象里的Date类型数据转化为指定格式的String
    // arr: array, type: 1（2018-2-8 17:03:02），2 （2018-2-8）
    // return array (返回转化后的数组)
    tranDateToStr(arr,type=1){
        arr.forEach((item,i) => {
            for(let key in item){
                if(arr[i][key] instanceof Date){
                    if(type == 1) arr[i][key] = arr[i][key].toLocaleString()
                    else if(type == 2) arr[i][key] = arr[i][key].toLocaleDateString()
                }
            }
        })
        return arr
    }
}

module.exports = Model