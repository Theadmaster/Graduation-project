const db = require('../db/index')
const async = require('async')
const { result } = require('@hapi/joi/lib/base')
const qs = require('qs')
const myCon = require('../config')
const mysql = require('mysql')


// 获取权限列表
exports.getBusiness = (req, res) => {
    let query = qs.parse(req.query)
    
    // debug
    // console.log(query);

    let currentPage = (query.currentPage - 1) * query.pageSize

    const sqlSearch = `select *
                        from business
                        where name like '%${query.searchInfo}%'
                        order by id asc 
                        limit ${currentPage}, ${query.pageSize}`
    const sqlSearch1 = `select count(*) as id_count 
                        from business 
                        where name like '%${query.searchInfo}%'`
    const sql = `select *
                from business 
                order by id asc
                limit ${currentPage}, ${query.pageSize}`
    const sql1 = `select count(*) as id_count from business`
    let total = 0;
    const p1 = new Promise((resolve, reject) => {
        if (query.searchInfo != '') {
            db.query(sqlSearch1, (err, results) => {
                if(err) return reject(err)
                total = results[0].id_count
                resolve(total)
            }) 
        } else {
            db.query(sql1, (err, results) => {
                if(err) return reject(err)
                total = results[0].id_count
                resolve(total)
            })
        }
    })
    const p2 = new Promise((resolve, reject) => {
        if (query.searchInfo != '') {
            db.query(sqlSearch, (err, results) => {
                if (err) return reject(err)
                console.log(results);
                resolve(results)
            })
        } else {
            db.query(sql, (err, results) => {
                if (err) return reject(err)
                resolve(results)
            })
        }
    })


    Promise.all([p1, p2]).then(results => {
        let obj = {}
        obj.total = results[0]
        obj.list = results[1]
        obj.currentPage = query.currentPage
        res.send({
            status: 0,
            message: '获取用户列表成功',
            data: obj
        })
    }).catch( e => {
        res.cc(e)
    })
}

exports.addBusiness = (req, res) => {
    const body = req.body
    console.log(body);
    const sql = `insert into business(name, contact, contact_phone, address, type, orderCount) values(?,?,?,?,?,?)`
    const values = [body.name, body.contact, body.contact_phone, body.address, body.type, body.orderCount, body.id]
    db.query(sql, values, (err, results) => {
        if (err) return res.cc(err)
        if (results.affectedRows !== 1)
            return res.cc('插入角色失败')
        res.cc('插入角色表成功', 0)
    })
}

exports.updateBusinessById = (req, res) => {
    const body = qs.parse(req.body)
    console.log(body);
    const sql = `update business set name=?, contact=?, contact_phone=?, address=?, type=?, orderCount=? where id=? `
    const values = [body.name, body.contact, body.contact_phone, body.address, body.type, body.orderCount, body.id]
    db.query(sql, values, (err, results) => {
        if (err) return res.cc(err)
        if (results.affectedRows !== 1) return res.cc('更新角色失败!')  
        return res.cc('更新角色成功!', 0)
    })
}

exports.deleteBusinessById = (req, res) => {
    const sql = `delete from business where id=?`
    db.query(sql, req.params.id, (err, results) => {
        if (err) return res.cc(err)
        if (results.affectedRows !== 1) return res.cc('删除角色失败')
        res.cc('删除角色成功', 0)
    })
}