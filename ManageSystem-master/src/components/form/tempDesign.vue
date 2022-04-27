<template>
  <div>
   <k-form-design 
    title="台账模板定义"
    @save="saveClick" />

    <!-- 添加对话框 -->
    <el-dialog
      v-if="addDialogVisible"
      title="新建模板"
      :visible.sync="addDialogVisible"
      width="700px"
    >
      <el-form
        ref="create"
        :model="createForm"
        :rules="rules"
        label-position="left"
        label-width="80px"
        style="padding: 0 20px"
        @keyup.enter.native="submitForm('create')"
      >
        <el-form-item label="模板名" prop="roleName">
          <el-input
            v-model="createForm.tempName"
            maxlength="20"
            clearable
            placeholder="请输入模板名"
          />
        </el-form-item>

        <el-form-item>
          <el-button type="primary" size="mini" @click="buildTemp"
            >创建</el-button
          >
          <!-- <el-button @click="resetForm('create')">重置</el-button> -->
        </el-form-item>
      </el-form>
    </el-dialog>
    <!-- 添加对话框 -->
  </div>
</template>


<script>
import { request } from '@/utils/request'
import qs from 'qs'
export default {
  data() {
    return {
      addDialogVisible: false,
      createForm: {
        tempName: '',
        tempJson: ''
      },
      rules: {
        tempName: [
          { required: true, message: "模板名称不能为空", trigger: "blur" },
          {
            min: 2,
            max: 20,
            message: "长度在 2 到 20 个字符",
            trigger: "blur",
          },
        ],
      },
    }
  },
  created() {
    console.log(11);
  },
  methods: {
    saveClick(val) {
      this.createForm.tempJson = val
      this.addDialogVisible = true
    },
    back(){
        this.$router.go(-1)
    },
    async buildTemp() {
      console.log(this.createForm);
      try {
        let res = await request({
          url: `/temp/buildTemp`,
          method: 'post',
          data: qs.stringify(this.createForm)
        })
        console.log(res);
        if(res.status === 0) {
          this.$notify.success({
            title: "成功",
            message: res.message,
            duration: 1500,
          });
          this.back()
        }
      } catch(err) {
        console.log(err);
      }
    },
  }
}
</script>

<style>

</style>