'use strict'
// 解析zip文件的包
const AdmZip = require('adm-zip')
const multiparty  =  require('multiparty')
const fs = require('fs')

const common = {}

// 判断用户是否登录
common.ifLogin = (req,res,next)=>{
    if(req.session && req.session.user){
        next()
    } else {
        if(!req.xhr) return res.redirect(Host+'/page/login')
        res.send(retMsg.error({
            status: -10,
            msg: "用户没有登录"
        }))
    }
}

// 判断进入后台权限
common.adminAccess  = (req,res,next)=>{
    if(req.session && req.session.user){
        if(req.session.user.admin > 0) return next()
        else{
            res.status(400).send(retMsg.error({
                status: -20,
                msg: "用户权限不足"
            }))
        }
    } else {
        res.send(retMsg.error({
            status: -10,
            msg: "用户没有登录"
        }))
    }
}

// 判断管理员角色权限
common.adminRole  = (req,res,next)=>{
    if(req.session && req.session.user){
        if(req.session.user.admin == 100) return next()
        else{
            res.status(400).send(retMsg.error({
                status: -20,
                msg: "用户权限不足"
            }))
        }
    } else {
        res.send(retMsg.error({
            status: -10,
            msg: "用户没有登录"
        }))
    }
}

// multipart/form-data 文件解析
common.upFile = (req,res,next)=>{
    if(!req.headers['content-type']) {
        return next()
    }
    if(req.headers['content-type'] && req.headers['content-type'].indexOf('multipart/form-data') == -1) return next()
    // 为每个用户创建一个文件夹
    let path = RootPath+'/uploads/'+req.session.user.id
    if(!fs.existsSync(path)){
        fs.mkdirSync(path)
        fs.mkdirSync(path+'/img')
    }
    // 文件保存
    let form = new multiparty.Form({uploadDir:  path})
    form.parse(req, function(err, fields, files) {
        if(err) {
            console.log(err)
            return
        }
        req.fields = fields
        req.files = files
        return next()
    })
}

// md5加密
common.md5 = (text)=>{
    let buf = Buffer.from(text);
    // 转化为二进制再加密，防止中文乱码
    let str = buf.toString("binary");
    let crypto = require('crypto')
    return crypto.createHash('md5').update(str).digest('hex');
}

// docx文档转为已设定格式的html
common.tranDocxToHtml = (path)=>{
    let zip = new AdmZip(path);
    let xml = zip.readAsText("word/document.xml")
    let html = ''
    let wps = xml.match(/<w:p>[\s\S]*?<\/w:p>/ig)
    if(wps==null) return
    wps.forEach((wp)=>{
        let wrs = wp.match(/<w:r>[\s\S]*?<\/w:r>/ig)
        if(wrs==null) return
        html += '<p>'
        wrs.forEach((wr,i)=>{
            let wts = wr.match(/<w:t[\s\S]*?<\/w:t>/ig)
            if(wts==null) return
            wts.forEach((wt)=>{
                // 去掉首行空格和空行
                if(i==0 && wt.indexOf('xml:space="preserve"') != -1 && wt.match(/<w:t[\s\S]*?>\s*<\/w:t>/ig)!=null) return
                if(i==0 && wt.indexOf('xml:space="preserve"') != -1){
                    // 去掉段落前后空格
                    let text = wt.replace(/<\/?w:t[\s\S]*?>\s*/ig,'')
                    html += text
                }else{
                    let text = wt.replace(/<\/?w:t[\s\S]*?>/ig,'')
                    html += text
                }
                
            })
        })
        html += '</p>'
    })
    return html
}

// 生成随机字符串
common.getRandomStr = (len=16)=>{
    let code = ''
    let str = 'abcdefghijklmnopqrstuvwsyz0123456789'
    for(let i=0; i<len; i++){
        let n = Math.random()*str.length|0
        code += str[n]
    }
    return code
}

// 当前时间年月日str
// separator: 分隔符，默认为'/'
common.getDateTime = (separator='/')=>{
    let date = new Date()
    let Y = date.getFullYear().toString()
    let M = (date.getMonth()+1).toString()
    M = M.length == 1 ? '0'+M : M
    let D = date.getDate().toString()
    D = D.length == 1 ? '0'+D : D
    return Y+separator+M+separator+D
}

// 当前周的周一日期 Date类型
common.getThisWeekMonday = ()=>{
    let date = new Date()
    let Y = date.getFullYear()
    let M = date.getMonth()
    let D = date.getDate()
    let more_day = Math.abs(date.getDay()-1)
    let res_date = new Date(Y,M,D-more_day)
    return res_date
}

module.exports = common