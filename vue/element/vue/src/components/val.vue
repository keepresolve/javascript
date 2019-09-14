<template>
  <div>
    <div @click="value3=1000">{{value3}}</div>
  </div>
</template>
<script>
export default {
  name: "sync",
  props: ["value3"],
  data() {
    return {
      //   value: ""
    };
  },
  watch: {
    value(val) {
      this.$emit("update:value", val);
    }
  },
  mounted() {}
};
</script>；

