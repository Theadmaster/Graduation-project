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
            @click="deleteClick"
            >导出 Excel</el-button
          ></div>
        <div class="search-group">
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
        <el-table-column prop="name" label="台账名称"> </el-table-column>
        <el-table-column  label="当前状态">
            <template slot-scope="scope">
                <el-tag :type="scope.row.status===1?'':(scope.row.status===2? 'success': (scope.row.status===3? 'warning': 'info'))" size="mini">{{getStatus( scope.row.status)}}</el-tag>
            </template>
        </el-table-column>
        <el-table-column prop="date" label="发布时间"> </el-table-column>
        <el-table-column fixed="right" label="操作" width="150">
          <template slot-scope="scope" >
            <el-button @click="handleClick(scope.row)" type="text" size="small"
              >查看详情</el-button
            >
            <el-button @click="handleClick(scope.row)" type="text" size="small"
              >发布</el-button
            >
          </template>
        </el-table-column>
      </el-table>
    </el-card>
    <!-- /列表栏 -->



    <!-- 详情对话框 -->
    <el-dialog title="模板详情" :visible.sync="infoDialogVisible" width="700px">
      <tempBuild :tempData="tempData" />
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
        pageSize: 20,
        total: 400,
        searchInfo: "",
      },
      createForm: {
        name: "",
        json: "",
      },
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
      ]
      
    };
  },
  computed: {
    // ...mapGetters(["roleOptions"]),
    
  },
  created() {
    // this.getList();
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