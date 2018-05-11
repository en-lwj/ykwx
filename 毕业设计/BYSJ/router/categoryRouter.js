
'use strict'
const express = require('express')
const router = express.Router()
const controller = require("../controller/categoryController")


router.get("/",controller.getCategory)
router.get("/info",controller.getCategoryById)
router.get("/all",(req,res)=>{
    controller.getCategoryAll(req,res)
})
router.get("/article",controller.getArticleWithContentByCategoryId)
router.get("/article/count",controller.getArtileCountByCategoryId)
router.get("/article/Processing", Common.adminAccess, controller.getProcessingCategoryArticleList)


module.exports = router