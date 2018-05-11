
'use strict'
const express = require('express')
const router = express.Router()
const controller = require("../controller/activityController")

router.get("/running",controller.getRunningActivity)
router.get("/year/all",controller.getActivityOrderByYear)
router.get("/year",controller.getActivityYear)
router.get("/year/:year([0-9]+)",controller.getActivityByYear)
router.get("/prize/:id([0-9]+)",controller.getPrizeList)
router.get("/:id([0-9]+)",controller.getActivity)
router.get("/column", controller.getActivityColumn)
router.get("/article/:id([0-9]+)", Common.adminAccess, controller.getActivityArticleListById)
router.get("/article/Processing/:id([0-9]+)", Common.adminAccess, controller.getProcessingActivityArticleListById)
router.post('/',Common.adminRole,controller.addActivity)
router.post("/score", Common.adminAccess, controller.setScore)
router.post("/prize/:id([0-9]+)", Common.adminRole, controller.setPrize)
router.put('/:id([0-9]+)',Common.adminRole,controller.updateActivityById)
router.put('/publish/:id([0-9]+)',Common.adminRole,controller.updateActivityPublishById)
router.delete('/:id([0-9]+)',Common.adminRole,controller.deleteActivityById)

module.exports = router