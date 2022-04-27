const express = require('express')

const router = express.Router()

const tempHandler = require('../router_handler/temp')

const expressJoi = require('@escook/express-joi')



// 创建表单模板
router.post('/buildTemp', tempHandler.buildTemp)

// 获取模板列别
router.get('/getTemp', tempHandler.getTemp)

router.post('/updateTemp', tempHandler.updateTempById)

router.post('/deleteTemp/:id', tempHandler.deleteTempById)


// 将路由对象共享出去
module.exports = router