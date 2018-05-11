'use strict'
const userModel = require("../model/userModel")
const mailer = require("../config/mailer")
const images = require('images')
class userController {
    // 获取所有用户列表
    getUserList(req,res){
        let async = async ()=>{
            try{
                let result = await userModel.getUserList() 
                res.json(retMsg.success(result))
            } catch (err){
                res.status(400).send(retMsg.error())
            }
        }
        async()
    }
    // 发送邮箱验证码
    getCode(req,res){
        let async = async ()=>{
            try{
                let code = Common.getRandomStr(4)
                let text = "【邑刊文学】 您的邮箱验证码为："+code+" 有效时间为3分钟"
                let result = await mailer.send({
                    to: req.query.email,
                    text: text
                })
                if(result){
                    // 设置缓存时间 3分钟
                    Cache.put(req.query.email, code, 1000*60*3)
                    res.json(retMsg.success('验证码已发送'))
                } else {
                    res.status(400).json(retMsg.error('验证码发送失败')).end()
                }
            } catch (err){
                res.status(400).json(retMsg.error()).end()
            }
        }
        async()
    }
    // 上传头像
    // 裁剪图片+保存
    saveUserIcon(req,res){
        let async = async ()=>{
            try{
                // （x,y）起点坐标，w:宽度，s缩放倍数
                let f_path = req.files.f[0].path
                let x = Number(req.fields.x[0])
                let y = Number(req.fields.y[0])
                let w = Number(req.fields.m[0])
                let s = Number(req.fields.s[0])
                let img_path = '/uploads/'+req.session.user.id+'/img/'+Date.now() +'.jpg'
                let lastPut = RootPath+img_path
                let img = images(f_path)
                img.resize(img.width()*s)
                await images(img, x, y, w, w).save( lastPut)
                // 保存路径
                let result = await userModel.updateTableById('user', req.session.user.id, {img: img_path})
                // if(!result.affectedRows) {
                //     return res.status(400).json(retMsg.error('保存头像失败'))
                // }
                //return res.json(retMsg.success('保存头像成功'))
                return res.redirect(Host+'/page/userPersonal')
            } catch (err){
                console.log(err)
                res.status(400).json(retMsg.error())
            }
        }
        async()
    }
    // 判断该字段filed是否存在值value
    getExist(req,res){
        let async = async ()=>{
            try{
                let arr = ['account','name','phone','email']
                arr.indexOf(req.query.filed)==-1 && res.json(retMsg.error('非法字段！'))
                let result = await userModel.getExist({
                    filed: req.query.filed,
                    value: req.query.value
                }) 
                if(!result) {
                    return res.json(retMsg.success('该字段值可以用'))
                }
                return res.json(retMsg.error('该字段值已存在'))
            } catch (err){
                res.status(400).json(retMsg.error())
            }
        }
        async()
    }
    // 获取用户信息
    getUserInfo(req,res){
        let async = async ()=>{
            try{
                let result = await userModel.getDataById('user', req.session.user.id)
                if(result[0].img!='') result[0].img = Host + result[0].img
                delete result[0].password
                return res.json(retMsg.success(result[0]))
            } catch (err){
                res.status(400).json(retMsg.error())
            }
        }
        async()
    }
    login(req,res){
        let async = async ()=>{
            try{
                let result = await userModel.login({
                    account: req.query.account,
                    password: Common.md5(req.query.password)
                }) 
                if(result.length != 0) {
                    this.setUserSession(req,result[0])
                    if(result[0].img!='') result[0].img = Host+result[0].img
                    let obj = {
                        id: result[0].id,
                        name: result[0].name,
                        img: result[0].img,
                        admin: result[0].admin
                    }
                    return res.json(retMsg.success(obj,'登录成功'))
                }
                result.length == 0 && res.status(400).json(retMsg.error('登录失败,用户名或密码错误'))
            } catch (err){
                res.status(400).json(retMsg.error()).end()
            }
        }
        async()
    }
    register(req,res){
        let async = async ()=>{
            try{
                // 验证唯一
                let result1 = await userModel.getExist('account', req.body.account)
                if(result1) return res.status(400).json(retMsg.error('账号已存在')).end()
                let result2 = await userModel.getExist('name', req.body.name)
                if(result2) return res.status(400).json(retMsg.error('用户名已存在')).end()
                let result3 = await userModel.getExist('email', req.body.email)
                if(result3) return res.status(400).json(retMsg.error('该邮箱已存在')).end()

                // 验证邮箱验证码
                let captcha = req.body.captcha
                let captcha_cache = Cache.get(req.body.email)
                if(captcha_cache == null){
                    return res.status(400).json(retMsg.error('请获取验证码'))
                } else if(captcha_cache != captcha){
                    return res.status(400).json(retMsg.error('验证码填写错误'))
                }
                Cache.del(req.body.email)
                // 存取数据
                let result = await userModel.register({
                    account: req.body.account,
                    name: req.body.name,
                    password: Common.md5(req.body.password),
                    email: req.body.email,
                    phone: req.body.phone,
                    student: req.body.student,
                    sno: req.body.sno
                })
                if(result.insertId){
                    let user_info = await userModel.getDataById('user',result.insertId)
                    let obj = {
                        name: user_info[0].name,
                        img: user_info[0].img
                    }
                    return res.json(retMsg.success(obj,'注册成功'))
                }else{
                    return res.status(400).json(retMsg.error('注册失败'))                   
                }
            } catch (err){
                console.log(err)
                res.status(400).json(retMsg.error())
            }
        }
        async()
    }
    logout(req,res){
        try{
            delete req.session.user
            return res.json(retMsg.success())
        } catch (e) {
            res.status(400).json(retMsg.error())
        }
    }
    changePwd(req,res){
        let async = async ()=>{
            try{
                // 验证邮箱验证码
                let code = req.body.code
                let captcha_cache = Cache.get(req.body.email)
                if(captcha_cache == null){
                    return res.status(400).json(retMsg.error('请获取验证码'))
                } else if(captcha_cache != code){
                    Cache.del(req.body.email)
                    return res.status(400).json(retMsg.error('验证码填写错误'))
                }
                Cache.del(req.body.email)
                // 存取数据
                let result = await userModel.changePwd({
                    email: req.body.email,
                    password: Common.md5(req.body.password)
                })
                if(result.affectedRows){
                    return res.json(retMsg.success('密码修改成功'))
                }else{
                    return res.status(400).json(retMsg.error('密码修改失败'))                   
                }
            } catch (err){
                console.log(err)
                res.status(400).json(retMsg.error())
            }
        }
        async()
    }
    changeRole(req,res){
        let async = async ()=>{
            try{
                // 存取数据
                let result = await userModel.updateTableById('user', req.body.id, {
                    admin: req.body.admin
                })
                if(result.affectedRows){
                    return res.json(retMsg.success('修改成功'))
                }else{
                    return res.status(400).json(retMsg.error('修改失败'))                   
                }
            } catch (err){
                console.log(err)
                res.status(400).json(retMsg.error())
            }
        }
        async()
    }
    // 修改用户信息
    saveInfo(req,res){
        let async = async ()=>{
            try{
                // 存取数据
                let result = await userModel.updateTableById('user', req.session.user.id, {
                    name: req.body.name,
                    phone: req.body.phone,
                    sno: req.body.sno||'',
                    student: req.body.student
                })
                if(result.affectedRows){
                    return res.json(retMsg.success('修改成功'))
                }else{
                    return res.status(400).json(retMsg.error('修改失败'))                   
                }
            } catch (err){
                console.log(err)
                res.status(400).json(retMsg.error())
            }
        }
        async()
    }
    // 查看用户所有投稿列表及状态
    getArticleListByUserId(req,res){
        let async = async ()=>{
            try{
                // 存取数据
                let result = await userModel.getArticleListByUserId(req.session.user.id)
                return res.json(retMsg.success(result))
            } catch (err){
                console.log(err)
                return res.status(400).json(retMsg.error())
            }
        }
        async()
    }
    // 设置后台用户session
    setUserSession(req,obj){
        req.session.user = obj
    }
}

module.exports = new userController()