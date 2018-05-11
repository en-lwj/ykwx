/**
 * 分派路由
 */
'use strict'
class Router {
    setResHead(req,res,next){
        res.statusCode = 200
        res.setHeader("Content-Type","application/json;charset=UTF-8")
        res.setHeader("Access-Control-Allow-Credentials",true)
        res.setHeader("Access-Control-Allow-Origin",'*')
        next()
    }
    init(app){
        app.get('/',require("../controller/pageController").renderIndex)
        app.use('/page',require("./pageRouter"))
        app.use('/category',this.setResHead,require("./categoryRouter"))
        app.use('/article',this.setResHead,require("./articleRouter"))
        app.use('/activity',this.setResHead,require("./activityRouter"))
        app.use('/user',this.setResHead,require("./userRouter"))
        app.use('/rank',this.setResHead,require("./rankRouter"))
        app.use('/comment',this.setResHead,require("./commentRouter"))        
        app.use('/praise',this.setResHead,require("./praiseRouter"))        
        app.use('/recommend',this.setResHead,require("./recommendRouter"))        
        app.use('/news',this.setResHead,require("./newsRouter"))        
        app.use('/admin',this.setResHead,require("./adminRouter"))
    }
}

module.exports = new Router()


