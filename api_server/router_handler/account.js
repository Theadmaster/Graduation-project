const db = require('../db/index')
const qs = require('qs')


// 获取模板列表
exports.getAccounts = (req, res) => {
    let query = qs.parse(req.query)
    
    // debug
    // console.log(query);

    let currentPage = (query.currentPage - 1) * query.pageSize

    const sqlSearch = `select *
                        from form
                        where form_name like '%${query.searchInfo}%'
                        order by id asc 
                        limit ${currentPage}, ${query.pageSize}`
    const sqlSearch1 = `select count(*) as id_count 
                        from form 
                        where form_name like '%${query.searchInfo}%'`
    const sql = `select *
                from form 
                order by id asc
                limit ${currentPage}, ${query.pageSize}`
    const sql1 = `select count(*) as id_count from form`
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
            message: '获取台账列表成功',
            data: obj
        })
    }).catch( e => {
        res.cc(e)
    })
}

// 获取模版options
exports.getTemps = (req, res) => {
    const sql = `select * from form_temp order by id asc` 
    db.query(sql, (err, results) => {
        if(err) return res.cc(err)
        res.send({
            status: 0,
            message: '获取模版列表成功',
            data: results
        })
    })
}


// 创建表单模板
exports.buildAccount = (req, res) => {
    const body = qs.parse(req.body)
    // console.log(body);
    const sql = `insert into form(form_name, form_date, form_temp_id, form_json) values(?,?,?,?)`
    const sql1 = `select form_json from form_temp where id=${body.formTempId}`
    let values = [body.tempName, body.tempDate, body.formTempId]
    const p = new Promise((resolve, reject) => {
        db.query(sql1, (err, results) => {
            if(err) res.cc(err)
            resolve(results)
        })
    })
    p.then(res1 => {
        console.log(res1);
        values.push(res1[0].form_json)
        db.query(sql, values, (err, results) => {
            if (err) return res.cc(err)
            if (results.affectedRows !== 1)
                return res.cc('插入台账失败')
            res.cc('创建台账成功', 0)
        })
    })
    
    

}

// 发布台账
exports.commitAccount = (req, res) => {
    // const body = qs.parse(req.body)
    // console.log(body);
    const sql = `update form set status=${2} where id=?`
    const values = [req.params.id]
    db.query(sql, values, (err, results) => {
        if (err) {
            console.log(err);
            return res.cc(err)
        }
        if (results.affectedRows !== 1)
            return res.cc('发布失败')
        res.cc('发布成功', 0)
    })
}

// 查看详情
exports.getAccountDetail = (req, res) => {

}

// 审批
exports.approvalAccount = (req, res) => {
    console.log(req.params.id);
    const sql = `update form set status=${4} where id=?`
    const values = [req.params.id]
    db.query(sql, values, (err, results) => {
        if(err) {
            console.log(err);
            return res.cc(err)
        }
        if (results.affectedRows !== 1) return res.cc('审批失败')
        res.cc('审批成功', 0)
    })
}


exports.updateAccountById = (req, res) => {
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

exports.deleteAccountById = (req, res) => {
    const sql = `delete from form_temp where id=?`
    db.query(sql, req.params.id, (err, results) => {
        if (err) return res.cc(err)
        if (results.affectedRows !== 1) return res.cc('删除模板失败')
        res.cc('删除模板成功', 0)
    })
}

