
/**
 * 定时器运行
 */
'use strict'
const timerCtrl = require('../controller/timerController')
const Timer = {}
// 返回到指定时间的时间戳
let toTimeStamp = (h=0,m=0,s=0)=>{
    let a = Date.now()
    let b = new Date()
    let c = new Date(b.getFullYear(), b.getMonth(), b.getDate(), h, m, s)
    return a - c.getTime()
}

Timer.setDayClick =  ()=>{
    return setInterval(()=>{
        timerCtrl.setDayClick()
    },24*60*60*1000)
}

setTimeout(()=>{
    timerCtrl.setDayClick()
    Timer.setDayClick()
},toTimeStamp())

timerCtrl.setDayClick()