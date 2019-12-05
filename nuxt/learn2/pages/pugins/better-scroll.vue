<template>
    <div id='better-scroll'>
        <header>
            <span @click="change">国内</span>
            <span @click="change">国际</span>
        </header>
        <div>

        </div>
        <div class='container' ref='container'>
            <ul class='wrapper'>
                <li v-for="item in lis" :ref='`target_${item.index}`' :key='item.index'>
                    <h3>{{item.index||item.title}}</h3>
                    <ul>
                        <li v-for="suItem in item.list" :key="suItem.key">
                            {{suItem.value}}
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
        <div class='bar' @touchstart='indexStart'>
            <ul>
                <li class='indexlist-navitem' v-for="(item,index) in indexs" :data-key='item.key' :key='index' @click="scrollto(item)">

                    {{item.index}}
                    <span class="indexlist-title" :class="{hidden:item.hidden}">{{item.key}}</span>
                </li>
            </ul>
        </div>
    </div>
</template>
<script>
const getAllChars = () => {
    let startChar = 65;
    const allChars = [];
    while (startChar < 65 + 26) {
        allChars.push(String.fromCharCode(startChar++));
    }
    return allChars;
};
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
            lis: [
                {
                    index: "A",
                    list: [{ key: 0, value: "" }]
                }
            ],
            indexs: [],
            navOffsetX: 0,
            moving: false
        };
    },
    computed: {
        // barList() {
        //     return this.lis.filter(e => {
        //         return e.key % 10 == 0;
        //     });
        // }
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
        let { lis, indexs } = this.generator();
        this.lis = lis;
        this.indexs = indexs;
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
        // this.scroll.refresh();
    },
    methods: {
        change() {
            let { lis, indexs } = this.generator();
            this.lis = lis;
            this.indexs = indexs;
            this.scroll.refresh();
        },
        generator() {
            let allChart = getAllChars();
            let lis = [];
            let indexs = [];
            while (allChart.length) {
                let index = allChart.shift();
                let num = Math.round(Math.random() * 100);
                let item = {
                    list: [],
                    index
                };
                for (let i = 0; i < num; i++) {
                    item.list.push({
                        key: i,
                        value: `${index}-${String.fromCharCode(
                            Math.round(Math.random() * num * 200)
                        )}`
                    });
                }
                lis.push(item);
                indexs.push({
                    index,
                    key: index,
                    hidden: true
                });
            }
            return {
                lis,
                indexs
            };
        },
        pointer() {
            alert(1);
        },
        scrollto(item) {
            // console.log({ item, target: this.$refs });
            // this.scroll.scrollToElement(this.$refs[`target_${item.key}`][0]);
        },
        tap(ev) {
            // console.log("tap", arguments);
            // let target = ev.target || ev.srcElement;
            // if (target.dataset.key) {
            //     this.scroll.scrollToElement(
            //         this.$refs[`target_${target.dataset.key}`][0]
            //     );
            // }
            // console.log({ item, target: this.$refs });
        },
        indexStart(e) {
            // 如果不是从索引栏开始滑动，则直接return
            // 保证了左侧内容区域能够正常滑动
            console.log({ e });
            if (e.target.tagName !== "LI") {
                return;
            }

            // 记录开始的clientX值，这个clientX值将在之后的滑动中持续用到，用于定位
            this.navOffsetX = e.changedTouches[0].clientX;

            // 内容滑动到指定区域
            this.scrollList(e.changedTouches[0].clientY);
            // if (indicatorTime) {
            //     clearTimeout(indicatorTime);
            // }
            this.moving = true;

            // 在window区域注册滑动和结束事件
            window.addEventListener("touchmove", this.handleTouchMove, {
                passive: false
            });
            window.addEventListener("touchend", this.handleTouchEnd);
        },
        scrollList(y) {
            // 通过当前的y值以及之前记录的clientX值来获得索引栏中的对应item
            var currentItem = document.elementFromPoint(this.navOffsetX, y);
            if (
                !currentItem ||
                !currentItem.classList.contains("indexlist-navitem")
            ) {
                return;
            }
            let { key } = currentItem.dataset;
            if (!key) return;
            console.log({ currentItem });
            // 显示指示器
            // currentIndicator = currentItem.innerText;
            // indicator.innerText = currentIndicator;
            // indicator.style.display = "";
            let targes = this.lis.find(v => v.index == key);
            let index = 0;
            this.indexs.forEach(element => {
                if (element.index == key) index = element;
                element.hidden = true;
            });
            index.hidden = false;
            setTimeout(() => {
                index.hidden = true;
            }, 500);
            if (targes) {
                this.scroll.scrollToElement(
                    this.$refs[`target_${key}`][0],
                    500
                );
                console.log(index, targes);
            }
            // 找到左侧内容的对应section
            // var targets = [].slice.call(sections).filter(function(section) {
            //     var index = section.getAttribute("data-index");
            //     return index === currentItem.innerText;
            // });
            // var targetDOM;
            // if (targets.length > 0) {
            //     targetDOM = targets[0];
            //     // 通过对比要滑动到的区域的top值与最开始的一个区域的top值
            //     // 两者的差值即为要滚动的距离
            //     content.scrollTop =
            //         targetDOM.getBoundingClientRect().top -
            //         firstSection.getBoundingClientRect().top;

            // 或者使用scrollIntoView来达到相同的目的
            // 不过存在兼容性的问题
            // targetDOM.scrollIntoView();
            // }
        },
        handleTouchMove(e) {
            e.preventDefault();
            console.log("handleTouchMove", { e });
            this.scrollList(e.changedTouches[0].clientY);
        },
        handleTouchEnd() {
            this.moving = false;
            window.removeEventListener("touchmove", this.handleTouchMove, {
                passive: false
            });
            window.removeEventListener("touchend", this.handleTouchEnd);
        }
    }
};
</script>
<style scoped>
#better-scroll {
}
header {
    text-align: center;
    /* pointer-events: none; */
    /* 禁止鼠标事件 */
}
li ul {
    list-style: none;
}
* {
    padding: 0px;
    margin: 0;
}
html,
body {
    height: 100%;
}
.container {
    position: absolute;
    left: 0px;
    right: 100px;
    bottom: 50px;
    top: 30px;
    /* width: 100px; */
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
    margin: 5px 0;
    border-radius: 50%;
    /* background: saddlebrown; */
    text-align: center;
    vertical-align: middle;
    font-size: 12px;
    list-style: none;
}
.indexlist-navitem {
    position: relative;
}
.indexlist-title {
    position: absolute;
    left: -20px;
    width: 20px;
    height: 20px;
    line-height: 20px;
    background: saddlebrown;
    border-radius: 50%;
    text-align: center;
    vertical-align: middle;
}
.hidden {
    display: none;
}
</style>