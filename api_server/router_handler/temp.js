const db = require('../db/index')
const qs = require('qs')


// 获取模板列表
exports.getTemp = (req, res) => {
    let query = qs.parse(req.query)
    
    // debug
    // console.log(query);

    let currentPage = (query.currentPage - 1) * query.pageSize

    const sqlSearch = `select *
                        from form_temp
                        where name like '%${query.searchInfo}%'
                        order by id asc 
                        limit ${currentPage}, ${query.pageSize}`
    const sqlSearch1 = `select count(*) as id_count 
                        from form_temp 
                        where name like '%${query.searchInfo}%'`
    const sql = `select *
                from form_temp 
                order by id asc
                limit ${currentPage}, ${query.pageSize}`
    const sql1 = `select count(*) as id_count from form_temp`
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
            message: '获取模板列表成功',
            data: obj
        })
    }).catch( e => {
        res.cc(e)
    })
}


// 创建表单模板
exports.buildTemp = (req, res) => {
    const body = qs.parse(req.body)
    // console.log(body);
    const sql = `insert into form_temp(name, form_json) values(?,?)`
    const values = [body.tempName, body.tempJson]
    db.query(sql, values, (err, results) => {
        if (err) return res.cc(err)
        if (results.affectedRows !== 1)
            return res.cc('插入模板失败')
        res.cc('插入模板成功', 0)
    })
}


exports.updateTempById = (req, res) => {
    const body = qs.parse(req.body)
    console.log(body);
    const sql = `update form_temp set name=? where id=? `
    const values = [body.name, body.id]
    db.query(sql, values, (err, results) => {
        if (err) return res.cc(err)
        if (results.affectedRows !== 1) return res.cc('更新模板失败!')  
        return res.cc('更新模板成功!', 0)
    })
}

exports.deleteTempById = (req, res) => {
    const sql = `delete from form_temp where id=?`
    db.query(sql, req.params.id, (err, results) => {
        if (err) return res.cc(err)
        if (results.affectedRows !== 1) return res.cc('删除模板失败')
        res.cc('删除模板成功', 0)
    })
}