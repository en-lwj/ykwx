
'use strict'
const express = require('express')
const router = express.Router()
const controller = require("../controller/commentController")

router.get("/", controller.getComment)
router.post("/", Common.ifLogin, controller.addComment)
router.post("/:id([0-9]+)", Common.ifLogin, controller.addCommentReply)


module.exports = router