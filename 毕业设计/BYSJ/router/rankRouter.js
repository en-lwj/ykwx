
/**
 * user路由
 */
'use strict'
const express = require('express')
const router = express.Router()
const controller = require("../controller/rankController.js")

router.get("/userLike",(req,res,next)=>{
    controller.getUserLike(req,res)
})
router.get("/ranks",(req,res,next)=>{
    controller.getRanks(req,res)
})


module.exports = router