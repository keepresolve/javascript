<template>
  <div class="Input">
    <el-input v-model="value"></el-input>
    <cTransfer v-model="checklist" :data="data" type='text'></cTransfer>
    <el-transfer v-model="checklist" :data="data"  :props="{key:'id',label:'value'}"></el-transfer>
  </div>
</template>

<script>
// import { cTransfer } from "../../element/pkg/p";
// console.log({cTransfer})
export default {
  name: "Input",

  data() {
    return {
      checklist: [1],
      data: [{ id: 1, vlaue: "1选中" }],
      value: "ss"
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
