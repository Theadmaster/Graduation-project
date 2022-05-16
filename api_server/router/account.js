const express = require('express')

const router = express.Router()

const accountHandler = require('../router_handler/account')

const expressJoi = require('@escook/express-joi')


// 获取台账列表
router.get('/getAccounts', accountHandler.getAccounts)

// 获取台账模版列表
router.get('/getTemps', accountHandler.getTemps)

// 创建台账
router.post('/buildAccount', accountHandler.buildAccount)

// 发布台账
router.post('/commitAccount/:id', accountHandler.commitAccount)

router.get('/getAccountDetail', accountHandler.getAccountDetail)

// 审批
router.post('/approvalAccount/:id', accountHandler.approvalAccount)

// 导出 Excel
// router.get('/excel', tempHandler.getExcel)


// 将路由对象共享出去
module.exports = router