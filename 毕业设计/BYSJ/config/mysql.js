
/**
 * 封装并配置mysql
 * 这里使用mysql连接池
 */
'use strict'
const mysql = require("mysql")
const Logger = require("./logger")
Promise.promisifyAll(mysql)
class Pool{
    constructor(){
        this.pool = null
        this.init()
    }
    // 初始化连接线程池
    init(){
        let pool  = mysql.createPool({
            // 连接数
            connectionLimit : 2,
            host            : '127.0.0.1',
            user            : 'root',
            password        : '',
            database        : 'bysj',
            connectTimeout  : 10000,
            charset         : 'UTF8_GENERAL_CI'
        })
        Promise.promisifyAll(pool)
        this.pool = pool
        return pool
    }
    // 获取单个连接实例
    // getConn(req,cb) | getConn(cb)
    getConn(){
        let req, cb, conn
        arguments.length == 1 && (cb = arguments[0])
        arguments.length == 2 && (req = arguments[0], cb = arguments[1])
        return this.pool.getConnectionAsync().then((connection)=>{
            conn = connection
            Promise.promisifyAll(conn)
            return Promise.resolve().then(()=>{
                return cb(conn)
            }).then((result)=>{
                conn.release()
                return result
            })
        }).catch((err)=>{
            conn.release()
            req && Logger.error(req,err)
            !req && Logger.error(err)
            return Promise.reject(err)     
        })
    }
    // 关闭Pool
    end(){
        this.pool.end((err)=>{
            err && Logger.error(err)
        })
    }
}

module.exports = new Pool()