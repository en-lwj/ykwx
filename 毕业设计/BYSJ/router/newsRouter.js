
/**
 * index路由
 */
'use strict'
const express = require('express')
const router = express.Router()
const controller = require("../controller/newsController")

router.get("/list",controller.getNewsList)
router.get("/:id([0-9]+)",controller.getNewsById)
router.post("/", Common.adminAccess, controller.addNews)

router.get("/year",controller.getNewsYear)
router.get("/year/:year([0-9]+)",controller.getNewsListByYear)

router.delete('/:id([0-9]+)',Common.adminAccess,controller.deleteNewsById)

module.exports = router