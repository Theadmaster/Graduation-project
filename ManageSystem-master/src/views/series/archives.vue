<template>
  <div>
    <el-card class="control-bar">
      <div class="header">
        <div class="btn-group">
          <el-select size="mini" v-model="value" placeholder="请选择">
            <el-option
              v-for="item in options"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
        </div>
        <div class="search-group">
          <div style="margin-right: 5px">
            <el-input
              size="mini"
              placeholder="请输入台账名"
              @keyup.enter="getList"
              prefix-icon="el-icon-search"
              v-model="searchInfo"
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
      <!-- <el-table
        :data="list"
        v-loading="listLoading"
        stripe
        type="index"
        height="calc(100vh - 250px)"
        highlight-current-row
        @current-change="handleCurrentChange"
        style="width: 100%"
      >
        <el-table-column prop="id" label="序号"> </el-table-column>
        <el-table-column prop="name" label="模板名称"> </el-table-column>
        <el-table-column fixed="right" label="操作" width="100">
          <template slot-scope="scope">
            <el-button @click="handleClick(scope.row)" type="text" size="small"
              >查看详情</el-button
            >
            
          </template>
        </el-table-column>
      </el-table> -->
      <div class="month-wrap" v-for="(item, index) in list" :key="index">
        <div class="title">
          <span>{{item.month}}</span>
        </div>
        <div class="account-wrap" >
          <div class="account-item"
           v-for="(ele, i) in item.accounts" :key="i"
           @click="handleClick(ele)">
            <span>{{ele.name}}</span>
          </div>
        </div>
      </div>
    </el-card>
    <!-- /列表栏 -->



    <!-- 详情对话框 -->
    <el-dialog title="台账详情" :visible.sync="infoDialogVisible" width="700px">
      <tempBuild :tempData="tempData" />
    </el-dialog>
    <!-- 详情对话框 -->

    <!-- 分页栏 -->
    <div class="footer">
      
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
  name: "archives",
  components: { tempBuild },
  data() {
    return {
      list: [
        {
          id: 1,
          month: "一月",
          accounts: [
            {
              id: 1,
              name: 'name1',
              form_json: '{"list": [{"key": "input_1651052163688", "help": "", "type": "input", "label": "订单号", "model": "input_1651052163688", "rules": [{"message": "必填项", "required": false}], "options": {"type": "text", "width": "100%", "hidden": false, "disabled": false, "clearable": false, "maxLength": null, "addonAfter": "", "addonBefore": "", "placeholder": "请输入", "defaultValue": ""}}, {"key": "textarea_1651052165210", "help": "", "type": "textarea", "label": "文本框", "model": "textarea_1651052165210", "rules": [{"message": "必填项", "required": false}], "options": {"width": "100%", "hidden": false, "maxRows": 6, "minRows": 4, "disabled": false, "clearable": false, "maxLength": null, "placeholder": "请输入", "defaultValue": ""}}], "config": {"layout": "horizontal", "labelCol": {"lg": 4, "md": 4, "sm": 4, "xl": 4, "xs": 4, "xxl": 4}, "labelWidth": 100, "wrapperCol": {"lg": 18, "md": 18, "sm": 18, "xl": 18, "xs": 18, "xxl": 18}, "customStyle": "", "labelLayout": "flex", "hideRequiredMark": false}}'
            },
            {
              id: 2,
              name: 'name2',
              form_json: ''
            }
          ]
        },
        {
          id: 2,
          month: '二月',
          accounts: [
            {
              id: 1,
              name: '设备2',
              form_json: ''
            }
          ]
        },
        { 
          id: 3,
          month: '三月',
          accounts: [
            {
              id: 1,
              name: '设备3',
              form_json: ''
            },
            {
              id: 2,
              name: '设备4',
              form_json: ''
            }
          ]
        },
        {
          id: 4,
          month: "四月",
          accounts: [
            {
              id: 1,
              name: 'name1',
              form_json: ''
            },
            {
              id: 2,
              name: 'name2',
              form_json: ''
            }
          ]
        },
        {
          id: 5,
          month: '五月',
          accounts: [
            {
              id: 1,
              name: '设备2',
              form_json: ''
            }
          ]
        },
        { 
          id: 6,
          month: '六月',
          accounts: [
            {
              id: 1,
              name: '设备3',
              form_json: ''
            },
            {
              id: 2,
              name: '设备4',
              form_json: ''
            }
          ]
        },
        {
          id: 7,
          month: "七月",
          accounts: [
            {
              id: 1,
              name: 'name1',
              form_json: ''
            },
            {
              id: 2,
              name: 'name2',
              form_json: ''
            }
          ]
        },
        {
          id: 8,
          month: '八月',
          accounts: [
            {
              id: 1,
              name: '设备2',
              form_json: ''
            }
          ]
        },
        { 
          id: 9,
          month: '九月',
          accounts: [
            {
              id: 1,
              name: '设备3',
              form_json: ''
            },
            {
              id: 2,
              name: '设备4',
              form_json: ''
            }
          ]
        },
        {
          id: 10,
          month: "十月",
          accounts: [
            {
              id: 1,
              name: 'name1',
              form_json: ''
            },
            {
              id: 2,
              name: 'name2',
              form_json: ''
            }
          ]
        },
        {
          id: 11,
          month: '十一月',
          accounts: [
            {
              id: 1,
              name: '设备2',
              form_json: ''
            }
          ]
        },
        { 
          id: 12,
          month: '十二月',
          accounts: [
            {
              id: 1,
              name: '设备3',
              form_json: ''
            },
            {
              id: 2,
              name: '设备4',
              form_json: ''
            }
          ]
        },
      ],
      listLoading: false,
      currentRow: null,
      searchInfo: '',
      infoDialogVisible: false,
      tempData: '',
      options: [
        {
          value: 1,
          label: '一月'
        },
        {
          value: 2,
          label: '二月'
        },
        {
          value: 3,
          label: '三月'
        },
        {
          value: 4,
          label: '四月'
        },
        {
          value: 5,
          label: '五月'
        },
        {
          value: 6,
          label: '六月'
        },
        {
          value: 7,
          label: '七月'
        },
        {
          value: 8,
          label: '八月'
        },
        {
          value: 9,
          label: '九月'
        },
        {
          value: 10,
          label: '十月'
        },
        {
          value: 11,
          label: '十一月'
        },
        {
          value: 12,
          label: '十二月'
        }
      ],
      value: 1
      
    };
  },
  computed: {
    // ...mapGetters(["roleOptions"]),
  },
  created() {
    // this.getList();
  },
  methods: {
    /**
     * 获取列表
     */
    getList() {
      console.log(this.listQuery);
      request({
        url: `/temp/getTemp?${qs.stringify(this.listQuery)} `,
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
    /**
     * 提交表单
     */
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          switch (formName) {
            case "create":
              break;
            case "edit":
              this.handleEdit();
              break;
          }
        }
      });
    },
    // 跳转表单创建页面
    addClick() {
      this.$router.push("/tempDesign");
    },
    handleClick(row) {
      this.infoDialogVisible = true
      this.tempData = JSON.parse(row.form_json)
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
.table {
  height: 800px;
  overflow: scroll;
}
.month-wrap {
  .title {
    margin: 20px;
    font-size: 25px;
    color: #222f3e;
  }
  .account-wrap {
    height: 100px;
    display: flex;
    // justify-content: space-around;
    // border-left: 1px solid #ccc;
    box-shadow: -2px 0px 0px #eee ;
    padding-left: 40px;
    margin-left: 35px;
    align-items: center;
    .account-item {
      cursor: pointer;
      text-decoration: underline;
      color: blue;
      width: 60px;
      text-align: center;
      margin-right: 20px;
    }
  }
}
</style>