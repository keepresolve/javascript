<template>
  <div id="transfer" ref="transfer">
    <div>
      <c-transfer
        v-model="checklist"
        :data="data"
        :loading='loading'
        @change="transferChange"
        :props="{
        key:'id',
        label:'value',
        disabled:'disabled'
      }"
      ></c-transfer>
    </div>
    <div
      draggable="true"
      ref="dragSource"
      style="width:530px"
      @dragstart="dragstart"
      data-ref="dragSource"
    >
      <el-transfer v-model="checklist" :data="data" :props="{key:'id',label:'value'}"></el-transfer>
    </div>
    <el-button @click="defaultChecked">设置默认选中v-model</el-button>
  </div>
</template>

<script>
export default {
  name: "transfer",

  data() {
    return {
      checklist: [1, 5],
      data: [
        { id: 0, value: "0选中" },
        { id: 1, value: "1选中" },
        { id: 2, value: "2选中" },
        { id: 3, value: "3选中" },
        { id: 4, value: "4选中" },
        { id: 5, value: "5选中" }
      ],
      move: false ,
      loading:false
    };
  },
  methods: {
    defaultChecked() {
      let num = () => {
        return Math.floor(Math.random() * this.data.length);
      };
      let length = num();
      let arr = new Set();
      while (length) {
        length--;
        arr.add(num());
      }
      this.checklist = Array.from(arr);
      // this.checklist = [0,1,2,3,4,5,6];
    },
    transferChange() {
      console.log("transferChange", arguments);
    },
    dragstart(e) {
      let dataTransfer = e.dataTransfer || e.originalEvent.dataTransfer;
      dataTransfer.effectAllowed = "copyMove";
      dataTransfer.dropEffect = "copyMove";
      dataTransfer.setData("Text", e.target.dataset.ref);
      console.log("dragstart", arguments);
    }
  },
  mounted() {
     this.loading=true
    setTimeout(()=>{
      this.loading=false
    },2000)
    document.body.addEventListener("dragover", function(e) {
      let dataTransfer = e.dataTransfer || e.originalEvent.dataTransfer;
      dataTransfer.effectAllowed = "move";
      dataTransfer.dropEffect = "move";
      dataTransfer.dropEffect = "meove";
      console.log("dragover", arguments, dataTransfer.getData("Text"));
      e.preventDefault();
    });
    document.body.addEventListener("drop", e => {
      let dataTransfer = e.dataTransfer || e.originalEvent.dataTransfer;
      let ref = dataTransfer.getData("Text");
      dataTransfer.effectAllowed = "move";
      dataTransfer.dropEffect = "move";
      if (this.move) {
        Object.assign(this.$refs[ref].style, {
          position: "fixed",
          // 自己去算吧
          left: (e.pageX - e.offsetX || e.pageX || e.x || e.clientX) + "px",
          top: (e.offsetY || e.pageY || e.y || e.clientY) + "px"
        });
      }

      console.log("drop", arguments, dataTransfer.getData("Text"));
    });
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
#transfer {
  height: 100%;
  width: 100%;
}
#transfer > div {
  margin-bottom: 50px;
}
</style>
