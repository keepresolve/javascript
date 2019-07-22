<template>
    <div>
        <div class="scrollContainer">
            <ul v-infinite-scroll="load" class="warpper" :infinite-scroll-disabled='disabled' :infinite-scroll-delay='delay' :infinite-scroll-distance='distance' :infinite-scroll-immediate='immediate'>
                <li v-for="i in count">{{ i }}</li>
                <p v-if="loading">加载中...</p>
            </ul>

            <p v-if="noMore">没有更多了</p>
        </div>
        <button @click="disabled=!disabled">{{disabled?"打开":"禁用"}}</button>
        触发加载的距离阈值，单位为px<input type="number" v-model="distance">
        节流时延，单位为ms<input type="number" v-model="delay">
    </div>
</template>

<script>
import { setTimeout } from "timers";
export default {
    data() {
        return {
            count: 2,
            immediate: false,
            delay: 300, // 节流时延，单位为ms
            distance: 30, //触发加载的距离阈值，单位为px
            disabled: false,
            loading: false,
            noMore: false
        };
    },
    methods: {
        load() {
            this.loading = true;
            setTimeout(() => {
                this.count += 2;
                this.loading = false;
            }, 2000);
        }
    }
};
</script>
<style >
* {
    padding: 0px;
    margin: 0px;
}
.scrollContainer {
    width: 300px;
    height: 350px;
    border: 1px solid;
}
.warpper {
    width: 300px;
    height: 300px;
}
.warpper {
    overflow: auto;
}
</style>