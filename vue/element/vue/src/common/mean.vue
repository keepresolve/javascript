<template>
  <div id="cMean">
    <ul>
      <li v-for="(item,index) in links" :key="index">
          <router-link :to='item.path'>{{item.name}}</router-link>
        <!-- <a :href="item.path">{{item.name}}</a> -->
      </li>
    </ul>
  </div>
</template>
<script>
export default {
  name: "cMean",
  componentName: "cMean",
  computed: {
    links() {
      return this.$router.options.routes[0].children;
    }
  },
  props: {}
};
</script>