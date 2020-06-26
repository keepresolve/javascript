<template>
  <div id="app">
    <keep-alive>
      <router-view style="height:100%"/>
    </keep-alive>
    
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
