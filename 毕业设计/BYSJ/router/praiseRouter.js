
'use strict'
const express = require('express')
const router = express.Router()
const controller = require("../controller/praiseController")

router.get("/:id([0-9]+)", controller.getPraise)
router.post("/:id([0-9]+)", Common.ifLogin, controller.addPraise)



module.exports = router