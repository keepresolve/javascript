<template>
  <div class="directive" v-through:isShow:isShow1="bindCb">
      <button @click="isShow=!isShow">isShow</button>
      <button @click="isShow1=!isShow1">isShow1</button>
      <ul>
          <li v-for="i in list" :key="i">{{i}}</li>
      </ul>
      <div class="pop" v-if="isShow">
          <span @click="close">&times;</span>
      </div>
       <div class="pop" v-if="isShow1">
          <span @click="close1">&times;</span>
      </div>
  </div>
</template>

<script>
export default {
  name: "directive",
//   components: { },
  data() {
    return {
        list: Array.from(new Array(100)).map((v,i)=>{return i+1}),
        isShow:false,
        isShow1:false
    };
  },
  methods:{
      close(){
          this.isShow=!this.isShow
      },
       close1(){
          this.isShow1=!this.isShow1
      },
      bindCb(type,{el,context}){
          console.log("bindCb",type,arguments,this)
          console.log(this==context)
        //   if(type=="bind"){
        //        context.list=["a","b"]
        //   }
        //   if(vnode.context.list.length==2) return 
        //   vnode.context.list=["a","b"]
      }
  }
};
</script>

<style scoped>
.directive{
    width: 100%;
    height: 100%;
}
.pop{
    position:fixed;
    left: 0;
    right: 0;
    bottom: 0;
    top:0;
    border:1px solid;
    background: rgba(0,0,0,.4)
}
</style>
