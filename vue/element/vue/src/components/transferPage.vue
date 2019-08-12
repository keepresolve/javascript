<template>
    <div id="transfer" ref="transfer">
        <c-transfer style="height:280px;" v-model="checklist" :data="data" :loading="loading" @change="transferChange" :props="{
        key:'id',
        label:'value',
        disabled:'disabled'
      }"></c-transfer>

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
                { id: "0", value: "啊选中0" },
                { id: "1", value: "不选中1" },
                { id: "2", value: "从选中2" },
                { id: "3", value: "的选中3" },
                { id: "4", value: "阿选中4" },
                { id: "5", value: "发选中5" }
            ],
            move: false,
            loading: false
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
                arr.add(String(num()));
            }
            this.checklist = Array.from(arr);
        },
        transferChange() {
            console.log("transferChange", arguments);
        }
    },
    mounted() {
        this.loading = true;
        setTimeout(() => {
            this.loading = false;
        }, 2000);
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
