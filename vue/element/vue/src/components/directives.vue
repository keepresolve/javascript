<template>
  <div class="directive" v-through:isShow:isShow1="bindCb">
      <button @click="isShow=!isShow">v-through</button>
      <ul>
          <li v-for="i in list" :key="i">{{i}}</li>
      </ul>
      <div class="throughModel" v-if="isShow">
          <span class="close" @click="close">&times;</span>
          v-through 指令穿透的滑动
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
        isShow:false
    };
  },
  methods:{
      close(){
          this.isShow=!this.isShow
      },
      bindCb(type,{el,context}){
          console.log("bindCb",type,arguments,this)
          console.log(this==context)
        //   if(type=="bind"){
        //        context.list=["a","b"]
        //   }
        //   if(vnode.context.list.length==2) return 
        //   vnode.context.list=["a","b"]
        return {
          border:"1px solid red"
        }
      }
  }
};
</script>

<style scoped>
.directive{
    width: 100%;
    height: 100%;
    border: 1px solid;
}
.throughModel{
    position:fixed;
    left: 0;
    right: 0;
    bottom: 0;
    top:0;
    border:1px solid;
    text-align: center;
    vertical-align: middle;
    background: rgba(0,0,0,.4)
}
.throughModel .close{
   position:absolute;
   right: 0;
   top: 5px;


}
</style>
