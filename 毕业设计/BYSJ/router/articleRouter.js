
'use strict'
const express = require('express')
const router = express.Router()
const articleCtrl = require("../controller/articleController")

router.get("/",articleCtrl.getArticleList)
router.get("/:id([0-9]+)",articleCtrl.getArticleById)
router.get("/:id([0-9]+)/content",articleCtrl.getArticleContentById)
router.get("/search",articleCtrl.getArticleWithContentByKey)

router.post("/textArticle", Common.ifLogin, articleCtrl.addTextArticle)
router.post("/fileArticle", Common.ifLogin, Common.upFile, articleCtrl.addFileArticle)

router.put("/:id([0-9]+)", Common.adminAccess, articleCtrl.undateArticle)

router.delete("/:id([0-9]+)", Common.adminRole, articleCtrl.deleteArticle)

module.exports = router