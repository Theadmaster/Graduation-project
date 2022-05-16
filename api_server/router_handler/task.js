const db = require('../db/index')
const qs = require('qs')


// 获取模板列表
exports.getTasks = (req, res) => {
    let query = qs.parse(req.query)
    
    // debug
    // console.log(query);

    let currentPage = (query.currentPage - 1) * query.pageSize

    const sqlSearch = `select *
                        from form
                        where form_name like '%${query.searchInfo}%' and status <> ${1}
                        order by id asc 
                        limit ${currentPage}, ${query.pageSize}`
    const sqlSearch1 = `select count(*) as id_count 
                        from form 
                        where form_name like '%${query.searchInfo}%' and status <> ${1}`
    const sql = `select *
                from form 
                where status <> ${1}
                order by id asc
                limit ${currentPage}, ${query.pageSize}`
    const sql1 = `select count(*) as id_count from form where status <> ${1}`
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
            message: '获取任务列表成功',
            data: obj
        })
    }).catch( e => {
        res.cc(e)
    })
}



// 提交任务
exports.commitTask = (req, res) => {
    const body = qs.parse(req.body)
    // for debug
    // console.log(body);
    const sql = `update form set status=${3} where id=?`
    const values = [body.id]
    db.query(sql, values, (err, results) => {
        if (err) {
            console.log(err);
            return res.cc(err)
        }
        if (results.affectedRows !== 1)
            return res.cc('提交失败')
        res.cc('提交成功', 0)
    })
}

// 保存任务内容
exports.finishTask = (req, res) => {
    const body = qs.parse(req.body)
    // for debug
    // console.log(body);
    const sql = `update form set form_data='${body.form_data}' where id=?`
    const values = [body.id]
    db.query(sql, values, (err, results) => {
        if (err) {
            console.log(err);
            return res.cc(err)
        }
        if (results.affectedRows !== 1)
            return res.cc('保存失败')
        res.cc('保存成功', 0)
    })
}

// 查看详情
exports.getAccountDetail = (req, res) => {

}

