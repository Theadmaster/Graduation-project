<template>
  <div>
    <el-container class="home-container">
      <el-header class="el-head">
        <div class="logo">
          <span>台账管理系统</span>
          <!-- <img src="~/assets/logo.svg" alt=""> -->
          
        </div>
        <i class="col" :class="collapseIcon" @click="collapseClick"></i>
        <div class="breadcrumb"> 
            <el-breadcrumb separator="/">
              <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item >{{title}}</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="user">
          <el-dropdown
          @command="handleCommand"
          trigger="click">
            <img src="~/assets/avatar.gif" alt="">
            <i class="el-icon-caret-bottom"></i>
            <el-dropdown-menu slot="dropdown" divided>
              <el-dropdown-item command="user" icon="el-icon-user-solid" >用户1</el-dropdown-item>
              <el-dropdown-item divided command="logout" icon="el-icon-s-promotion" >退出登录</el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </div>
      </el-header>
      <el-container>
        <el-aside :width="asideWidth">
              <el-menu
              :default-active="this.$router.history.current.path"
              class="el-menu-vertical-demo"
              background-color="#2d3d51"
              text-color="#ccc"
              :collapse="isCollapse"
              router
              >
              <el-menu-item 
                :index="item.menuUrl" 
                style="width: 210px;" 
                @click="menuItemClick(item)"
                :key="index" v-for="(item, index) in menu">
                <i :class="item.menuIcon"></i>
                <span slot="title">{{item.menuName}}</span>
              </el-menu-item>
            </el-menu>
        </el-aside>
        <el-main>
          <router-view />
          
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script>

import { mapGetters } from 'vuex';

export default {
  name: 'layout',
  data() {
    return {
      isCollapse: false,
      asideWidth: '210',
      collapseIcon: 'el-icon-s-fold',
      // title: '',
    }
  },
  computed: {
    ...mapGetters(['menu']),
    title: {
      get: function () {
        return this.menu[0].menuName || ''
      },
      set: function (newVal) {
        return newVal
      }
    }
  },
  watch: {
    $route: 'breadChange',
    menu: 'printMenu'
  },
  mounted(){
    console.log(this.menu);
  },
  methods: {
    printMenu() {
      console.log(this.menu);
    },
    /**
     * 折叠导航
     */
    collapseClick() {
      this.isCollapse = !this.isCollapse
      if(this.isCollapse) {
        // this.asideWidth = '80'
        this.collapseIcon = 'el-icon-s-unfold'
      }else {
        this.asideWidth = '210'
        this.collapseIcon = 'el-icon-s-fold'
      }
    },
    /**
     * 改变面包屑
     */
    breadChange() {
      switch(this.$router.history.current.path) {
      
      }
    },
    menuItemClick(item) {
      console.log(item);
      this.title = item.menuName
    },
    /**
     * 退出登录
     */
    handleCommand(command) {
      if(command === 'user') {
        console.log(command);
        this.printMenu()
      } else {
        this.$router.push('/login')
      } 
      
    }
  }
}
</script>

<style lang="less">
  .el-header {
    background-color: #fff;
    color: #333;
    height: 52px!important;
    line-height: 52px;
    padding: 0;
    display: flex;
    align-items: center;
    box-shadow: 0 2px 3px #eee;
  }
  
  .el-aside {
    background-color: #2d3d51;
    color: #333;
    line-height: 200px;
  }
  
  .el-main {
    // background-color: #e0e8f5;
  }

  .home-container {
    height: 100vh;
  }
  .el-head i{
      font-size: 22px;
      cursor:pointer;
      margin-left: 20px;
  }
  .el-menu-vertical-demo {
    font-weight: 500;
    border-right: 0;
  }

  .logo {
    padding-left: 20px;
    width: 210px;
    background-color: #fff;
  }

  .logo img {
    width: 160px;
  }

  .logo span {
    width: 160px;
    font-size: 20px;
    font-weight: 700;
    color: #000;
  }

  .col {
    font-size: 22px;
    cursor:pointer;
  }

  .breadcrumb {
    
    margin-left: 20px;
  }

  .el-breadcrumb {
    font-size: 14px;
  }
 
  .user {
    position: absolute;
    right: 13px;
    cursor:pointer;
  }

  .user img {
    border-radius: 10px;
    width: 42px;
  }

  .user i {
    position: relative;
    top: 17px;
    left: 5px;
  }

  .control-bar {
    margin-bottom: 20px;
  }

  .el-card__body {
    padding: 5px;
  }

  .header {
    display: flex;
    justify-content:space-between;
  }

  .search-group {
    display: flex;
  }

  .btn-group {
    border-radius: 3px;
    overflow: hidden;
  }

  .btn-group .el-button+.el-button{
    margin: 0;
  }

  .btn-group .el-button {
    border-radius: 0;
  }
  
  .footer {
    position: absolute;
    right: 40px;
    bottom: 40px;
  }

  .el-form--label-left /deep/.el-form-item__label {
    font-size: 12px;
  }

  .el-input--suffix /deep/ .el-input__inner {
    height: 30px;
    font-size: 12px;
  }
</style>