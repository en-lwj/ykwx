/**
 * 封装并配置mailer
 */
'use strict'
const mailer = require("nodemailer")
const bluebird = require('bluebird')
class Mailer{
    constructor(){
        this.transporter = null
        this.init()
    }
    // 初始化
    init(){
        // 创建一个SMTP客户端配置
        let config = {
            host: 'smtp.qq.com', 
            port: 25,
            auth: {
                user: '576175351@qq.com', //刚才注册的邮箱账号
                pass: 'ziwuthwhoepubcee'  //邮箱的授权码，不是注册时的密码
            }
        }
        // 创建一个SMTP客户端对象
        this.transporter = mailer.createTransport(config)
        return this.transporter
    }
    // 发送邮件
    // 一个参数： obj:{from,subject,to,text},后两个一定要
    // 二个参数： to,text
    send(){
        let obj = arguments.length==1? arguments[0]: { to:arguments[0], text:arguments[1] }
        let mail = {
            // 发件人
            from: obj.form||'"邑刊文学"576175351@qq.com',
            // 主题
            subject: obj.subject||'邮箱验证码',
            // 收件人
            to: obj.to||'576175351@qq.com',
            // 邮件内容，HTML格式
            text: obj.text||'你好' //接收激活请求的链接
        }
        this.transporter.sendMailAsync = bluebird.promisify(this.transporter.sendMail)
        return this.transporter.sendMailAsync(mail).then((info)=>{
            return true
        }).catch((err)=>{
            console.log(err)
            return false
        })   
    }
}

module.exports = new Mailer()