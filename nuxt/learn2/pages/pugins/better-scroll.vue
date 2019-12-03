<template>
    <div id='better-scroll'>
        <header @click="pointer">
            better-scroll
            <div>test</div>
        </header>
        <div class='container' ref='container'>
            <ul class='wrapper'>
                <li v-for="(item,index) in lis" :ref='`target_${item.key}`' :key='index'>{{item.key}}</li>
            </ul>
        </div>
        <div class='bar' @touchmove="tap">
            <ul>
                <li v-for="(item,index) in barList" :data-key='item.key' :key='index' @click="scrollto(item)">{{item.key}}</li>
            </ul>
        </div>
    </div>
</template>
<script>
import BScroll from "better-scroll";
export default {
    name: "better-scroll",
    head() {
        return {
            title: "better-scroll"
        };
    },
    data() {
        return {
            lis: []
        };
    },
    computed: {
        barList() {
            return this.lis.filter(e => {
                return e.key % 10 == 0;
            });
        }
    },
    mounted() {
        let length = 0;
        this.scroll = new BScroll(this.$refs.container, {
            scrollY: true,
            // scrollX: true,
            startY: 0,
            click: true
            // freeScroll: true,
            // eventPassthrough: "vertical"
        });
        while (length <= 100) {
            length++;
            this.lis.push({
                key: length,
                value: length
            });
        }

        this.$nextTick(() => {
            console.log(111);
            // this.scroll.refresh();
            // let scroll = new BScroll(this.$refs.container);
        });

        // scroll.refresh();
        let event = [
            "beforeScrollStart",
            "scrollStart",
            "scroll",
            "scrollCancel",
            "scrollEnd",
            "touchEnd",
            "flick",
            "refresh",
            "disable",
            "enable",
            "destroy",
            "click"
        ];
        event.forEach(ev => {
            this.scroll.on(ev, function() {
                console.log(ev, arguments);
            });
        });
    },
    updated() {
        console.log("update");
        this.scroll.refresh();
    },
    methods: {
        pointer() {
            alert(1);
        },
        scrollto(item) {
            console.log({ item, target: this.$refs });
            this.scroll.scrollToElement(this.$refs[`target_${item.key}`][0]);
        },
        tap(ev) {
            console.log("tap", arguments);
            let target = ev.target || ev.srcElement;
            if (target.dataset.key) {
                this.scroll.scrollToElement(
                    this.$refs[`target_${target.dataset.key}`][0]
                );
            }
            // console.log({ item, target: this.$refs });
        }
    }
};
</script>
<style scoped>
#better-scroll {
}
header {
    text-align: center;
    pointer-events: none;
    /* 禁止鼠标事件 */
}
html,
body {
    height: 100%;
}
.container {
    height: 300px;
    border: 1px solid;
    overflow: hidden;
}
.container li {
    width: 1000px;
    border: 1px solid rosybrown;
}
.bar {
    position: fixed;
    width: 20px;
    right: 50px;
    top: 10px;
}
.bar {
    -webkit-touch-callout: none; /*系统默认菜单被禁用*/
    -webkit-user-select: none; /*webkit浏览器*/
    -khtml-user-select: none; /*早期浏览器*/
    -moz-user-select: none; /*火狐*/
    -ms-user-select: none; /*IE10*/
    user-select: none;
}
.bar li {
    width: 18px;
    height: 18px;
    border-radius: 50%;
    background: saddlebrown;
}
</style>