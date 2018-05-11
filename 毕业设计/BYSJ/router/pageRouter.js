
/**
 * page路由
 */
'use strict'
const express = require('express')
const router = express.Router()
const controller = require("../controller/pageController.js")

router.get("/index",controller.renderIndex)
router.get("/changePwd",controller.renderChangePwd)
router.get("/login",controller.renderLogin)
router.get("/register",controller.renderRegister)
router.get("/tougao",controller.renderTougao)
router.get("/article/:id([0-9]+)",controller.renderArticle)
router.get("/userPersonal",controller.renderUserPersonal)
router.get("/category",controller.renderCategory)
router.get("/activity",controller.renderActivity)
router.get("/news/:id([0-9]+)",controller.renderNews)
router.get("/news/list",controller.renderNewsListALL)
router.get("/prize/:id([0-9]+)",controller.renderPrize)
router.get("/setUserImg", Common.ifLogin, controller.renderSetUserImg)
router.get("/search", controller.renderSearch)

//后台页面
router.get("/admin" , controller.renderAdmin)
router.get("/admin/userRole", Common.adminAccess, controller.renderUserRole)
router.get("/admin/activityList", Common.adminAccess, controller.renderActivityList)
router.get("/admin/newsList", Common.adminAccess, controller.renderNewsList)
router.get("/admin/addNews", Common.adminAccess, controller.renderAddNews)
router.get("/admin/recommendList", Common.adminAccess, controller.renderRecommendList)
router.get("/admin/articleList", Common.adminAccess, controller.renderArticleList)
router.get("/admin/checkCategoryArticle", Common.adminAccess, controller.renderCheckCategoryArticle)
router.get("/admin/checkActivityArticle", Common.adminAccess, controller.renderCheckActivityArticle)
router.get("/admin/adminArticlePrize", Common.adminAccess, controller.renderAdminArticlePrize)

module.exports = router