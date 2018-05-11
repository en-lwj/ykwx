
/**
 * user路由
 */
'use strict'
const express = require('express')
const router = express.Router()
const controller = require("../controller/userController.js")

router.get("/", Common.ifLogin, (req,res,next)=>{
    controller.getUserInfo(req,res)
})
router.get("/login",(req,res,next)=>{
    controller.login(req,res)
})
router.get("/logout",controller.logout)
router.post("/register",(req,res,next)=>{
    controller.register(req,res)
})
router.get("/exist",controller.getExist)
router.get("/code",controller.getCode)
router.get("/articleList", Common.ifLogin, controller.getArticleListByUserId)
router.get("/list", Common.adminAccess, controller.getUserList)
router.post("/icon", Common.ifLogin, Common.upFile, controller.saveUserIcon)
router.put("/changePwd",controller.changePwd)
router.put("/role", Common.adminRole, controller.changeRole)
router.put("/info", Common.ifLogin, controller.saveInfo)


module.exports = router