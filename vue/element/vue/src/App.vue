<template>
  <div id="app">
    <router-view style="height:100%"/>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
#app,html,body{
  padding:0xp;
  margin: 0px;
  height: 100%;
}
#app{
  padding:20px;
  box-sizing: border-box;
}
</style>
