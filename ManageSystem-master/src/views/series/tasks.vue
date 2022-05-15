<template>
  <div>
    <el-card class="control-bar">
      <div class="header">
        <div class="btn-group">
          <!-- <el-button
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
           -->
            
            <el-select style="margin-right:5px" size="mini" v-model="bookType" placeholder="请选择book type">
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
          >
        </div>
        <div class="exp-group">
            <!-- <span>Book Type：</span> -->
          <!-- <el-select size="mini" v-model="bookType" placeholder="请选择book type">
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
            @click="deleteClick"
            >导出 Excel</el-button
          > -->
        </div>
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
              placeholder="请输入文件名"
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
        <el-table-column prop="status" label="当前状态">
            <template slot-scope="scope">
                <el-tag :type="scope.row.status===1?'':(scope.row.status===2? 'warning': (scope.row.status===3? 'success': 'info'))" size="mini">{{getStatus( scope.row.status)}}</el-tag>
            </template>
        </el-table-column>
        <el-table-column prop="form_date" label="发布时间"> </el-table-column>

        <el-table-column fixed="right" label="操作" width="150">
          <template slot-scope="scope" >
            <el-button @click="handleClick(scope.row)" type="text" size="small"
              >查看详情</el-button
            >
            <el-button @click="handleCommit(scope.row)" type="text" size="small"
              >提交</el-button
            >
          </template>
        </el-table-column>
      </el-table>
    </el-card>
    <!-- /列表栏 -->



    <!-- 详情对话框 -->
    <el-dialog title="模板详情" :visible.sync="infoDialogVisible" width="700px">
      <tempBuild :tempData="tempData" />
      <el-button type="primary" size="mini" @click="finishClick">完成</el-button>
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
          status: 2,
          date: '2022-05-02'
        },
        {
            id: 2,
            name: '设备2',
            status: 2,
            date: '2022-05-02'
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
      editDialogVisible: false,
      infoDialogVisible: false,
      tempData: '',
      listQuery: {
        currentPage: 1,
        pageSize: 10,
        total: 4,
        searchInfo: "",
      },
      createForm: {
        name: "",
        json: "",
      },
      bookType: '',
      dateValue: '',
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
      ]
      
    };
  },
  computed: {
    // ...mapGetters(["roleOptions"]),
    
  },
  created() {
    this.getList();
  },
  methods: {
      // 获取status信息
    getStatus(status) {
        return status===1? '未发布' : (status===2? '待提交': (status===3? '已提交/待审批': '已审批'))
    },
    /**
     * 获取列表
     */
    getList() {
      console.log(this.listQuery);
      request({
        url: `/task/getTasks?${qs.stringify(this.listQuery)} `,
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
    handleClick(row) {
      this.infoDialogVisible = true
      this.tempData = JSON.parse(row.form_json)
    },
    handleCommit(row) {
      console.log(row);
    },
    // 导出
    exportClick() {

    },
    finishClick() {
      
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