
/**
 * index路由
 */
'use strict'
const express = require('express')
const router = express.Router()
const controller = require("../controller/recommendController")

router.get("/list",controller.getRecommendList)
router.get("/list/:id([0-9]+)",controller.getRecommendByArticleId)

router.post("/", Common.adminAccess,controller.addRecommend)

router.put("/:id([0-9]+)", Common.adminAccess,controller.updateDescribeById)
router.put("/ranks", Common.adminAccess,controller.updateRanks)


module.exports = router