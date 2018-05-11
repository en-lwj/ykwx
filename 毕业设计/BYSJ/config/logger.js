/**
 * 错误日志文件配置
 */
'use strict'
const log4js = require('log4js')

// logger.trace('Entering cheese testing');
// logger.debug('Got cheese.');
// logger.info('Cheese is Gouda.');
// logger.warn('Cheese is quite smelly.');
// logger.error('Cheese is too ripe!');
// logger.fatal('Cheese was breeding ground for listeria.');

class Logger {
    constructor(){
        this.logger = null
    }
    // 初始化日志构造器
    init(){
        log4js.configure({
            appenders: {
                cheese: {
                    type: 'dateFile', 
                    absolute: true, 
                    alwaysIncludePattern: true,
                    pattern: "yyyy-MM-dd.log", 
                    filename: RootPath + '/log/error/'
                }
            },
            categories: { default: { appenders: ['cheese'], level: 'error' } }
        })
        this.logger = log4js.getLogger('cheese')
        return this.logger
    }
    // 封装错误类型日志函数
    // error(req,msg) | error(msg) | error(err)
    error(){
        if(arguments.length == 1){
            if(arguments[0] instanceof Error){
                var err = arguments[0]
                var text = "\r\nhref:"+""+"\tmethods:"+""+"\r\nmsg:"+err.stack
            } else {
                var msg = arguments[0]
                var text = "\r\nhref:"+""+"\tmethods:"+""+"\r\nmsg:"+msg
            }
        }else if(arguments.length == 2){
            var req = arguments[0]
            if(arguments[1] instanceof Error){
                var err = arguments[1]
                var text = "\r\nhref:"+req.originalUrl+"\tmethods:"+req.method+"\r\nmsg:"+err.stack
            } else {
                var msg = arguments[1]
                var text = "\r\nhref:"+req.originalUrl+"\tmethods:"+req.method+"\r\nmsg:"+msg
            }
        }
        text = text + "\r\n"
        this.init().error(text)
        err && console.error(err)
        !err && console.error(text)
    }

}

// new Logger()

module.exports = new Logger()