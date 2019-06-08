<template>
  <div id="app">
    <router-view style="height:100%"/>
  </div>
</template>

<script>
export default {
  name: "App"
};
</script>

<style>
#app,
html,
body {
  padding: 0px;
  margin: 0px;
  height: 100%;
}
*{
  list-style: none;
}
#app {
  box-sizing: border-box;
}
</style>
