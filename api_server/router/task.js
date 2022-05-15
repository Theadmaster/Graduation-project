const express = require('express')

const router = express.Router()

const taskHandler = require('../router_handler/task')

const expressJoi = require('@escook/express-joi')


// 获取台账列表
router.get('/getTasks', taskHandler.getTasks)

// 提交台账
router.post('/commitAccount', taskHandler.commitTask)


// 导出 Excel
// router.get('/excel', tempHandler.getExcel)


// 将路由对象共享出去
module.exports = router