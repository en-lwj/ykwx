'use strict'
const express     =  require('express')
const app         =  express()
const session     =  require('express-session')
const body_parser =  require("body-parser")
const multiparty  =  require('multiparty')
const router      =  require('./router/router')
const ejs         =  require('ejs')
global.Cache      =  require('memory-cache')
global.RootPath   =  __dirname
global.Promise    =  require("bluebird")
global.Logger     =  require("./config/logger")
global.Pool       =  require("./config/mysql")
global.retMsg     =  require('./config/retMsg')
global.Common     =  require("./config/common")
global.Host       =  'http://localhost'

// 运行定时器
require('./config/timer')


// 配置post body解析中间件
app.use(body_parser.json({limit : "5mb"}))     //添加json解析器
app.use(body_parser.urlencoded({extended:false,limit : "5mb" }))

//静态文件中间件
app.use(express.static(__dirname + '/public'))
app.use('/uploads',express.static(__dirname + '/uploads'))

// 配置session
// 有请求时刷新过期时间
app.use(session({
    secret: "!@#$qwe",
    // 是否允许session重新设置
    resave: true,
    // 是否按照原设定的maxAge值重设session同步到cookie中
    rolling: true,
    // 初始化session时是否保存到存储
    saveUninitialied: true,
    cookie:{maxAge: 24*60*60*1000}
}))

// 配置ejs模版
app.set('views', __dirname+"/views")
app.set('view engine',"html")
app.engine('.html',ejs.__express)

// 使用路由
router.init(app)

// 404错误中间件
app.use((req,res,next)=>{
    res.status(404).json(retMsg.error({
        status : 404,
        msg : "请求路径不正确"
    }))
})

//服务器内部错误
app.use((err,req,res,next)=>{
    Logger.error(req,err)
    res.status(500).json(retMsg.error({
        status : 500,
        msg : "服务器内部错误"
    }))    
})

//发生未捕获的错误,守护中间件
process.on("uncaughtException",(err)=>{
    Logger.error(err)
})

const server = app.listen(80,()=>{
    let host = server.address().address
    let port = server.address().port
    console.info("服务器启动了\thost:"+host+"\tport："+port)
})
