<template>
  <div class="Input">
    {{value4}}
    <el-input v-model="value"></el-input>
    <sync :value3="value4"></sync>
  </div>
</template>

<script>
// import { cTransfer } from "../../element/pkg/p";
import sync from "./val.vue";
// console.log({cTransfer})
export default {
  name: "Input",
  components: { sync },
  data() {
    return {
      value: "value",
      value4: "12313"
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
