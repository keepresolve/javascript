<template>
  <div class="index">
    <selectTree></selectTree>
  </div>
</template>

<script>
import selectTree from "./select.vue";
export default {
  name: "index",
  data() {
    return {
      msg: "index"
    };
  },
  components: {
    selectTree
  }
};
</script>

</style>
