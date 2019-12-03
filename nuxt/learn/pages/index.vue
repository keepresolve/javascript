<template>
  <div class="container">

  </div>
</template>

<script>
import Logo from '~/components/Logo.vue'
export default {
  components: {
    Logo
  },
  data(){
    let date=new Date()
    let month=date.getMonth()
    let year=date.getFullYear()
    console.log({year,month,date})
    return {
      current_start:new Date(year,month).getTime(),
      current_end:new Date(year,month+1).getTime(),
    }
  },
  computed:{
     dates(){
       let range=this.current_end-this.current_start
       let date_time=1000*60*60*24
       let length=range/data_time
       return new Array(length).fill(0).map((v,i)=>i+1)
     }
  }
}
</script>

<style>

</style>
