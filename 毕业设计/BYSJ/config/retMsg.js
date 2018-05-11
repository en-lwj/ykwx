/**
 * api返回信息
 * status 成功200 失败-1及其他
 */
'use strict'
class retMsg {
    success(){
        let ret_val = {}
        ret_val.status = 200
        ret_val.msg = 'success'
        ret_val.data = arguments[0] || ''
        arguments[1]&&(ret_val.msg = arguments[1])
        return ret_val
    }
    error(){
        let ret_val = {
            status : -1,
            msg : '请求出错'
        }
        if(arguments[0] && typeof arguments[0] == 'string'){
            ret_val.msg = arguments[0]
        } else if(arguments[0] && typeof arguments[0] == 'object'){
            let obj = arguments[0]
            for(let key in obj){
                ret_val[key] = obj[key]
            }
        }
        return ret_val
    }
}

module.exports = new retMsg()