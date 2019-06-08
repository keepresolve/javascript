<template>
  <div class="container">
    <el-container>
      <el-aside width="200px">
        <c-mean></c-mean>
      </el-aside>
      
      <el-container>
        <el-header>{{$route.name}}</el-header>
        <el-main>
          <router-view style="height:100%"></router-view>
        </el-main>
        <el-footer></el-footer>
      </el-container>
    </el-container>
  </div>
</template>
<script>
import cMean from "../common/mean";
export default {
  name: "index",
  components: {
    cMean
  }
};
</script>
<style>
.container,
.container > .el-container,
.container > .el-container > div {
  height: 100%;
  box-sizing: border-box;
}

.el-main {
  height: calc(100% - 120px);
}
.el-header,
.el-footer {
  font-size: 28px;
  color: #333;
  text-align: center;
  line-height: 60px;
}
</style>