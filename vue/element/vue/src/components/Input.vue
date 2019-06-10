<template>
  <div class="Input">
    <el-input v-model="value"></el-input>
  </div>
</template>

<script>
// import { cTransfer } from "../../element/pkg/p";
// console.log({cTransfer})
export default {
  name: "Input",

  data() {
    return {
      value: "value"
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
