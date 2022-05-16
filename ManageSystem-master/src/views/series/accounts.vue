<template>
  <div>
    <el-card class="control-bar">
      <div class="header">
        <div class="btn-group">
          <el-button
            type="primary"
            icon="el-icon-plus"
            size="mini"
            @click="addClick"
            >创建</el-button
          >
          <el-button
            :disabled="currentRow === null"
            type="warning"
            icon="el-icon-edit"
            size="mini"
            @click="editDialogVisibleClick"
            >修改</el-button
          >
          <el-button
            :disabled="currentRow === null"
            type="danger"
            icon="el-icon-delete"
            size="mini"
            @click="deleteClick"
            >删除</el-button
          >
          
        </div>
        <div class="exp-group">
            <!-- <span>Book Type：</span> -->
            <el-select size="mini" v-model="bookType" placeholder="请选择book type">
            <el-option
              v-for="item in options"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
            <el-button
            :disabled="currentRow === null"
            type="primary"
            icon="el-icon-s-order"
            size="mini"
            @click="exportClick"
            >导出 Excel</el-button
          ></div>
        <div class="search-group">
            <div style="margin-right: 5px;">
                <el-date-picker
                    size="mini"
                    v-model="dateValue"
                    type="date"
                    placeholder="选择日期">
                </el-date-picker>
            </div>
          <div style="margin-right: 5px">
            <el-input
              size="mini"
              placeholder="请输入台账名"
              @keyup.enter="getList"
              prefix-icon="el-icon-search"
              v-model="listQuery.searchInfo"
            >
            </el-input>
          </div>
          <el-button
            type="primary"
            icon="el-icon-search"
            size="mini"
            @click="getList"
            >查询</el-button
          >
        </div>
      </div>
    </el-card>
    <!-- 列表栏 -->
    <el-card class="table">
      <el-table
        :data="list"
        v-loading="listLoading"
        stripe
        border
        type="index"
        height="calc(100vh - 250px)"
        highlight-current-row
        @current-change="handleCurrentChange"
        style="width: 100%"
      >
        <el-table-column width="100px" align="center" prop="id" label="序号"> </el-table-column>
        <el-table-column prop="form_name" label="台账名称"> </el-table-column>
        <el-table-column  label="当前状态">
            <template slot-scope="scope">
                <el-tag :type="scope.row.status===1?'':(scope.row.status===2? 'success': (scope.row.status===3? 'warning': 'info'))" size="mini">{{getStatus( scope.row.status)}}</el-tag>
            </template>
        </el-table-column>
        <el-table-column prop="form_date" label="发布时间"> </el-table-column>
        <el-table-column fixed="right" label="操作" width="150">
          <template slot-scope="scope" >
            <el-button @click="handleClick(scope.row)" type="text" size="small"
              >查看详情</el-button
            >
            <el-button @click="handleCommit(scope.row)" type="text" size="small"
              >发布</el-button
            >
          </template>
        </el-table-column>
      </el-table>
    </el-card>
    <!-- /列表栏 -->

    <!-- 添加对话框 -->
    <el-dialog
      v-if="addDialogVisible"
      title="新建角色"
      :visible.sync="addDialogVisible"
      width="700px"
    >
      <el-form
        ref="create"
        :model="createForm"
        label-position="left"
        label-width="80px"
        style="padding: 0 20px"
        @keyup.enter.native="submitForm('create')"
      >
        <el-form-item label="台账名称" prop="name">
          <el-input
            v-model="createForm.tempName"
            maxlength="20"
            clearable
            placeholder="请输入台账名称"
          />
        </el-form-item>
        <el-form-item label="截止日期" prop="date">
          <el-date-picker
              v-model="createForm.tempDate"
              type="date"
              placeholder="选择日期">
          </el-date-picker>
          
        </el-form-item>
        
        <el-form-item label="台账模版" prop="role_id">
          <el-select
            v-model="createForm.formTempId"
            
            filterable
            clearable
            placeholder="请选择模版"
            style="width: 100%"
          >
            <el-option
              v-for="temp in tempOptions"
              :key="temp.id"
              :label="temp.name"
              :value="temp.id"
            />
          </el-select>
        </el-form-item>
        
        
        

        <el-form-item>
          <el-button type="primary" size="mini" @click="submitForm('create')"
            >创建</el-button
          >
          <!-- <el-button @click="resetForm('create')">重置</el-button> -->
        </el-form-item>
      </el-form>
    </el-dialog>
    <!-- 添加对话框 -->



    <!-- 详情对话框 -->
    <el-dialog title="模板详情" :visible.sync="infoDialogVisible" width="700px">
      <!-- <tempBuild :tempData="tempData" /> -->
      <k-form-build ref="kfb" :value="tempData"></k-form-build>
      <el-button type="primary" size="mini" @click="finishClick">审批</el-button>
    </el-dialog>
    <!-- 详情对话框 -->

    <!-- 分页栏 -->
    <div class="footer">
      <el-pagination
        background
        @size-change="handleSizeChange"
        @current-change="handleCurrentPageChange"
        :current-page="listQuery.currentPage"
        :page-sizes="[10, 20, 30, 40]"
        :page-size="listQuery.pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="listQuery.total"
      >
      </el-pagination>
    </div>
    <!-- 分页栏 -->
  </div>
</template>

<script>
import { request } from "@/utils/request";
import qs from "qs";
import { mapGetters, mapState } from "vuex";
import { underscore2camelCase } from "@/utils/index";
import tempBuild from "@/components/form/formBuild";
export default {
  name: "temp",
  components: { tempBuild },
  data() {
    return {
      list: [
        {
          id: 1,
          name: "设备",
          status: 1,
          date: '2022-05-02',
          form_json: '{"list": [{"key": "input_1651328555040", "help": "", "type": "input", "label": "输入框", "model": "input_1651328555040", "rules": [{"message": "必填项", "required": false}], "options": {"type": "text", "width": "100%", "hidden": false, "disabled": false, "clearable": false, "maxLength": null, "addonAfter": "", "addonBefore": "", "placeholder": "请输入", "defaultValue": ""}}, {"key": "input_1651328556741", "help": "", "type": "input", "label": "输入框", "model": "input_1651328556741", "rules": [{"message": "必填项", "required": false}], "options": {"type": "text", "width": "100%", "hidden": false, "disabled": false, "clearable": false, "maxLength": null, "addonAfter": "", "addonBefore": "", "placeholder": "请输入", "defaultValue": ""}}, {"key": "input_1651328555857", "help": "", "type": "input", "label": "输入框", "model": "input_1651328555857", "rules": [{"message": "必填项", "required": false}], "options": {"type": "text", "width": "100%", "hidden": false, "disabled": false, "clearable": false, "maxLength": null, "addonAfter": "", "addonBefore": "", "placeholder": "请输入", "defaultValue": ""}}, {"key": "input_1651328557757", "help": "", "type": "input", "label": "输入框", "model": "input_1651328557757", "rules": [{"message": "必填项", "required": false}], "options": {"type": "text", "width": "100%", "hidden": false, "disabled": false, "clearable": false, "maxLength": null, "addonAfter": "", "addonBefore": "", "placeholder": "请输入", "defaultValue": ""}}, {"key": "textarea_1651328559107", "help": "", "type": "textarea", "label": "文本框", "model": "textarea_1651328559107", "rules": [{"message": "必填项", "required": false}], "options": {"width": "100%", "hidden": false, "maxRows": 6, "minRows": 4, "disabled": false, "clearable": false, "maxLength": null, "placeholder": "请输入", "defaultValue": ""}}, {"key": "date_1651328560990", "help": "", "type": "date", "label": "日期选择框", "model": "date_1651328560990", "rules": [{"message": "必填项", "required": false}], "options": {"range": false, "width": "100%", "format": "YYYY-MM-DD", "hidden": false, "disabled": false, "showTime": false, "clearable": false, "placeholder": "请选择", "defaultValue": "", "rangePlaceholder": ["开始时间", "结束时间"], "rangeDefaultValue": []}}], "config": {"layout": "horizontal", "labelCol": {"lg": 4, "md": 4, "sm": 4, "xl": 4, "xs": 4, "xxl": 4}, "labelWidth": 100, "wrapperCol": {"lg": 18, "md": 18, "sm": 18, "xl": 18, "xs": 18, "xxl": 18}, "customStyle": "", "labelLayout": "flex", "hideRequiredMark": false}}'
        },
        {
            id: 2,
            name: '设备2',
            status: 2,
            date: '2022-05-02',
            form_json: '{"list":[{"type":"input","label":"姓名","options":{"type":"text","width":"100%","defaultValue":"123","placeholder":"请输入","clearable":false,"maxLength":null,"addonBefore":"","addonAfter":"","hidden":false,"disabled":false},"model":"小红","key":"input_1651754809279","help":"","rules":[{"required":false,"message":"必填项"}]},{"type":"input","label":"输入框","options":{"type":"text","width":"100%","defaultValue":"","placeholder":"请输入","clearable":false,"maxLength":null,"addonBefore":"","addonAfter":"","hidden":false,"disabled":false},"model":"input_1651754868868","key":"input_1651754868868","help":"","rules":[{"required":false,"message":"必填项"}]},{"type":"input","label":"输入框","options":{"type":"text","width":"100%","defaultValue":"","placeholder":"请输入","clearable":false,"maxLength":null,"addonBefore":"","addonAfter":"","hidden":false,"disabled":false},"model":"input_1651754882823","key":"input_1651754882823","help":"","rules":[{"required":false,"message":"必填项"}]},{"type":"input","label":"输入框","options":{"type":"text","width":"100%","defaultValue":"","placeholder":"请输入","clearable":false,"maxLength":null,"addonBefore":"","addonAfter":"","hidden":false,"disabled":false},"model":"input_1651754884904","key":"input_1651754884904","help":"","rules":[{"required":false,"message":"必填项"}]},{"type":"input","label":"输入框","options":{"type":"text","width":"100%","defaultValue":"","placeholder":"请输入","clearable":false,"maxLength":null,"addonBefore":"","addonAfter":"","hidden":false,"disabled":false},"model":"input_1651754886752","key":"input_1651754886752","help":"","rules":[{"required":false,"message":"必填项"}]}],"config":{"layout":"inline","labelCol":{"xs":4,"sm":4,"md":4,"lg":4,"xl":4,"xxl":4},"labelWidth":100,"labelLayout":"flex","wrapperCol":{"xs":18,"sm":18,"md":18,"lg":18,"xl":18,"xxl":18},"hideRequiredMark":false,"customStyle":""}}'
        },
        {
            id: 3,
            name: '设备3',
            status: 3,
            date: '2022-05-02'
        },
        {
            id: 4,
            name: '文具材料',
            status: 4,
            date: '2022-05-02'
        }
      ],
      listLoading: false,
      currentRow: null,
      addDialogVisible: false,
      editDialogVisible: false,
      infoDialogVisible: false,
      tempData: '',
      currentRow: null,
      listQuery: {
        currentPage: 1,
        pageSize: 10,
        total: 4,
        searchInfo: "",
      },
      createForm: {
        tempName: "",
        tempDate: '',
        formTempId: ''
      },
      tempOptions: [],
      bookType: '',
      options: [
          {
              label: 'xlsx',
              value: 1
          },
          {
              label: 'csv',
              value: 2
          },
          {
              label: 'txt',
              value: 3
          }
      ],
      dateValue: ''
    };
  },
  computed: {
    // ...mapGetters(["roleOptions"]),
    
  },
  created() {
    this.getList();
    this.getTemps()
  },
  methods: {
      // 获取status信息
    getStatus(status) {
        return status===1? '未发布' : (status===2? '已发布': (status===3? '已提交/待审批': '已审批'))
    },
    /**
     * 获取列表
     */
    getList() {
      console.log(this.listQuery);
      request({
        url: `/account/getAccounts?${qs.stringify(this.listQuery)} `,
        method: "get",
      })
        .then((res) => {
          console.log(res);
          if (res.status === 0) {
            this.list = res.data.list;

            this.listQuery.currentPage = parseInt(res.data.currentPage);
            this.listQuery.total = res.data.total;
            console.log(this.list);
            this.listLoading = false;
          }
        })
        .catch((err) => {
          console.log(err);
        });
    },
    getTemps() {
      request({
        url: `/account/getTemps`
      }).then( res => {
        console.log(res);
        this.tempOptions = res.data
      }).catch( err => {
        console.log(err);
      })
    },
    /**
     * 改变pagesize
     */
    handleSizeChange() {
      this.getList();
    },
    /**
     * 改变页数
     */
    handleCurrentPageChange() {
      this.getList();
    },
    async finishClick() {
      console.log(this.currentRow);
      
      try {
        let res = await request({
          url: `/account/approvalAccount/${this.currentRow.id}`,
          method: 'post'
        })
        // console.log(res);
        if(res.status === 0) {
          this.getList()
          this.$message.success({
            message: '审批成功'
          })
          this.infoDialogVisible = false
        }
      } catch (error) {
        console.log(error);
      }
    },
    /**
     * 提交表单
     */
    async handleCommit(item) {
      console.log(item);
      try {
        const res = await request({
          url: `/account/commitAccount/${item.id}`,
          method: 'post'
        })
        console.log(res);
        if(res.status === 0) {
          this.getList()
          this.$message.success({
            message: '发布成功'
          })
        }
        
      } catch (error) {
        
      }
    },
    async handleBuild(){
      console.log(this.createForm);
      try {
        let res = await request({
          url: `/account/buildAccount`,
          method: 'post',
          data: qs.stringify(this.createForm)
        })
        console.log(res);
        if (res.status === 0) {
          this.addDialogVisible = false
          this.$notify.success({
            title: "成功",
            message: res.message,
            duration: 1500,
          })
          this.getList()
        }
      } catch (error) {
        console.log(error);
      }
    },
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          switch (formName) {
            case "create":
              this.handleBuild()
              break;
            case "edit":
              this.handleEdit();
              break;
          }
        }
      });
    },
    // 导出
    exportClick() {
        // try {
        //     let res = await request({url: `/temp/excel`})
        //     console.log(res);
        // } catch (error) {
        //     console.log(error);
        // }
        let obj = JSON.parse(this.list[0].form_json)
        
        import('@/vendor/Export2Excel').then(excel => {
        let tHeader = ['name', 'sex', 'age']
        let data = ['gert', 'male', '20']
        const list = this.list
        
        excel.export_json_to_excel({
          header: tHeader,
          data,
          
          bookType: 'xlsx'
        })
        
      })
        
    },
    // 跳转表单创建页面
    addClick() {
    //   this.$router.push("/tempDesign");
        this.addDialogVisible = true
        
    },
    handleClick(row) {
      this.infoDialogVisible = true
      this.currentRow = row
      this.tempData = JSON.parse(row.form_json)
      this.$nextTick(() => {
        this.$refs.kfb.setData(JSON.parse(row.form_data)).then(res => {
          console.log(res);
        }).catch(err => {
          console.log(err);
        })
      })
    },
    /**
     * 修改显示框
     */
    editDialogVisibleClick() {
      this.editForm = this.currentRow;
      this.editDialogVisible = true;
      console.log(this.editForm);
    },
    /**
     * 修改
     */
    async handleEdit() {
      this.editForm.id = this.currentRow.id;
      console.log(this.editForm);
      let res = await request({
        url: `/temp/updateTemp`,
        method: "post",
        data: qs.stringify(this.editForm),
      });
      if (res.status === 0) {
        this.$notify.success({
          title: "成功",
          message: res.message,
          duration: 1500,
        });
        this.editDialogVisible = false;
        this.getList();
      } else {
        this.$notify.error({
          title: "失败",
          message: res.message,
          duration: 1500,
        });
      }
    },
    /**
     * 删除
     */
    deleteClick() {
      this.$confirm("删除后无法撤销，确定删除?", "提示", { type: "warning" })
        .then(() => {
          request({
            url: `/temp/deleteTemp/${this.currentRow.id}`,
            method: "post",
          }).then((res) => {
            if (res.status === 0) {
              this.$notify.success({
                title: "成功",
                message: "删除成功",
                duration: 1500,
              });
              if (this.list.length - 1 === 0) {
                this.listQuery.currentPage -=
                  this.listQuery.currentPage < 1 ? 0 : 1;
              }
              this.getList();
            }
          });
        })
        .catch(() => {});
      console.log(this.currentRow);
    },
    /**
     * 选中一行
     */
    handleCurrentChange(row) {
      this.currentRow = row;
    },
  },
};
</script>

<style lang="less" scoped>
.content {
  text-align: center;
}

.content img {
  width: 600px;
}

.content-text {
  /* margin: 30px 30px 0 30px; */
  padding-right: 0;
}

.tag-wrap {
  display: inline-block;
  margin-left: 5px;
  margin-right: 5px;
}

.exp-group {
    span {
        font-weight: 500;
        font-size: 15px;
    }
    .el-select {
        margin-right: 10px;
        width: 150px;
    }
}
</style>