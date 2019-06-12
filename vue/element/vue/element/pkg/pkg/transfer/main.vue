<template>
  <div class="cTransfer">
    <div class="cTransfer-wrapper">
      <!-- left -->
      <div class="cTransfer-slide" v-loading="loading">
        <!-- header -->
        <div class="cTransfer-slide-header" :style="{marginBottom:hiddenSelect?'14px':''}">
          <el-input
            v-model="query"
            :placeholder="placeholder"
            prefix-icon="el-icon-search"
            class="input-34"
          ></el-input>
          <!-- 全选 -->
          <div>
            <el-checkbox
              v-if="!hiddenSelect"
              :indeterminate="isIndeterminate"
              v-model="checkAll"
              @change="handleCheckAllChange"
            >全选</el-checkbox>
          </div>
        </div>
        <div
          class="cTransfer-slide-body"
          :style="{height:hiddenSelect?'calc(100% - 80px)':'calc(100% - 105px)'}"
        >
          <el-scrollbar style="height: 100%">
            <el-checkbox-group v-model="checked" v-if="!hiddenSort">
              <div v-for="(item, index) in letterList" :key="index">
                <div class="capital">{{item.letter}}</div>
                <div v-for="(subitem, subindex) in item.data" :key="subindex">
                  <el-checkbox
                    :label="subitem.key"
                    :key="subitem.key"
                    :title="subitem.label"
                    :disabled="subitem.disabled"
                  >{{subitem.label}}</el-checkbox>
                </div>
              </div>
            </el-checkbox-group>
            <el-checkbox-group  v-model="checked" v-if="hiddenSort">
                <div v-for="(item, index) in filterData" :key="index">
                    <el-checkbox
                    :label="item.key"
                    :key="item.key"
                    :title="item.label"
                    :disabled="item.disabled"
                    >{{item.label}}</el-checkbox>
                </div>
            </el-checkbox-group>
          </el-scrollbar>
        </div>
      </div>
      <div class="cTransfer-middle"></div>
      <!-- right -->
      <div class="cTransfer-slide">
        <!-- header -->
        <div class="cTransfer-slide-header">
          <span v-html='rightHeaderString'></span>
        </div>
        <div class="cTransfer-slide-body">
          <el-scrollbar style="height: 100%">
            <ul>
              <li class="checked-item" v-for="(item,index) in showcheckedList" :key="index">
                <span class="ellipsis" :title="item[propLabel]">{{item[propLabel]}}</span>
                <span class="pointer" @click="remove(index)">
                  <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABwAAAAcCAYAAAByDd+UAAAAAXNSR0IArs4c6QAAAsFJREFUSA29lr1rFEEYxuedvb27sCgHMYqprCSVhVrExkLBwsbuMEEOEos0nuBfIng2Fho4JJF0pkhhYWHjFWIRLEKqgKB4UTiV5fay2R33mWOOyWRms4dHFo75eub53ezMvPsSK/A8XV2tVUrBhThOpjnzqimJKqZxQVHKksj3vV+Dw/DHk6Wl3kl2lCdovVyfZeTNCRJBnk6NkaCQiWSn+XDhm+ozSyuw3W4HvWTqKmNpzZxQrM17Na//udFohKb+GPDF2tq5aFC6Tkz4pnictmAUVyuHn1YWF3/q844AAYtjPp+mdKRfnzBOnXMhfD/t6FCuDPAasbJJweALL3jCW3FGQOzZ/75GZaqX8Byeh2GvBLbW3866DohgLNEN8upubVqTJz6bPFxhfzBnM4LBlUvn31UC+kAeO7Bp0IcxaKB1QrPrBS3HpXbds+zkeLv7+8FKvf5b8DMfbVD0YQwaaDEHxuYDBlgcEcQc1NsHkZh/9nrr7OMHd/+YUAXDGDTQ6nPNOlg8jmnaHNDbImFlSv/eMKEmDBpo9blmXYZGzoZx0RzU2zYoVqtWVgQGP8ThEgJxkVsuoUyuVIJggFUXhUEP1ugeouM0niz6UFQEZO6ZuadFPMDi+J6dJDZheI34jQsFi+PjmQe0wbCftoMEbZ4XWBxf6jxRuUod12k0oeU+dfCFcPmBJQ9o69XGLVu0UaENEQSXGgCbGVaGP3Z5Zib88rV726ZDNtBcrr8vSYMsLWDEr5lmCFPbe907rnCl9AAMQnFzO+wmTi0Y2SOvxaPl+9+zqjUBchoomla6tbyn8hwJJCKBHARpgTZ/IlV4wluZjS4+Eh7kIHmbriYVLeEFTz2ZGgFhgtwDOcgkVgoPM58BI3vtx59TTRMVXghBz99sXmRZNmC7MkqnlzIRnqrsNBfujZcI6yaoTzLV/wfPBrFhi+k8ygAAAABJRU5ErkJggg==" alt width="14">
                </span>
              </li>
            </ul>
          </el-scrollbar>
        </div>
      </div>
    </div>
  </div>
</template>
<style >
.cTransfer .el-checkbox {
    display: inline-block;
    vertical-align: middle;
    width: calc(100% - 25px);
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
.cTransfer .el-scrollbar__wrap{
  overflow-x:hidden;
}
</style>
<style scoped>
.cTransfer,
.cTransfer-wrapper {
    height: 100%;
    width: 100%;
    box-sizing: border-box;
}
.cTransfer-wrapper {
    border: 1px solid #dddddd;
    border-radius: 2px 0 2px 2px 2px;
    display: flex;
}
.cTransfer-slide {
    height: 100%;
    flex: 1;
    width: 50%;
    box-sizing: border-box;
}
.cTransfer-middle {
    align-self: stretch;
    border-left: 1px solid #ebeef5;
    width: 1px;
}
.cTransfer-slide-header {
    padding: 14px 16px 0px 16px;
    font-size: 12px;
    color: #91a1a9;
}
.cTransfer-slide:first-child .cTransfer-slide-body {
    /* height: calc(100% - 96px); */
    line-height: 28px;
    width: calc(100% - 5px);
}

.cTransfer-slide:last-child .cTransfer-slide-body {
    height: calc(100% - 55px);
    line-height: 30px;
}

.capital {
    line-height: 24px;
    background: #f5f5f5;
    font-size: 12px;
    color: #616161;
    padding-left: 16px;
}
.cTransfer-slide-body .el-checkbox {
    padding-left: 15px;
}
.checked-item {
    display: flex;
    padding: 0px 15px;
    color: #606266;
}
.checked-item > span:first-child {
    flex: 6;
}
.checked-item > span:last-child {
    flex: 1;
    text-align: right;
}
</style>
<script>
import initialSort from '../../src/util'
export default {
    name: 'cTransfer',
    componentName: 'cTransfer',
    props: {
        value: {
            type: Array, //选中
            default() {
                return []
            }
        },
        // 数据加载loading
        loading: {
            type: Boolean,
            default() {
                return false
            }
        },
        // 列表数据
        data: {
            type: Array, //所有
            default() {
                return []
            }
        },
        //显示控制
        hiddenList: {
            type: Array,
            default() {
                return []
            }
        },
        format:{
            type:Object,
             default() {
                return {
                    left:'已选择{total}个'
                }
            }
        },
        props: {
            type: Object,
            default() {
                return {
                    label: 'label',
                    key: 'key',
                    disabled: 'disabled'
                }
            }
        },
        placeholder: {
            type: String,
            default: '请输入内容'
        }
    },
    watch: {
        value(n, o) {
            // console.log('valueChange', n, o)
            if (!n) this.checked = []
            if (n.find(v => o.indexOf(v) == -1) || n.length != o.length) {
                this.checked = n
            }
        },
        checked(n, o) {
            // console.log('checkedChange', n, o)
            if (n.length > 0) {
                this.checkAll = !Boolean(
                    this.filterData.find(v => n.indexOf(String(v.key)) == -1)
                )
            }
            this.isIndeterminate = this.checkAll ? false : n.length > 0
            let currentValue = n.slice()

            this.$emit('input', currentValue)
            this.$emit('change', currentValue)
        }
    },
    computed: {
        hiddenSelect() {
            return Boolean(this.hiddenList.find(v => v == 'selectAll'))
        },
        hiddenSort(){
            return Boolean(this.hiddenList.find(v => v == 'sortLetter'))
        },
        rightHeaderString(){
            if(!this.format.right|| typeof this.format.right != 'string') return  `已选择 <span style="font-size: 12px;color: #E6A441;">${this.checked.length}</span> 个`
            return this.format.right.replace(/\${checked}/g, ` <span style="font-size: 12px;color: #E6A441;">${this.checked.length}</span>`).replace(/\${total}/g, `<span>${this.data.length}</span>`)
        },
        propKey() {
            return this.props.key || 'key'
        },
        propLabel() {
            return this.props.label || 'label'
        },
        propDisabled() {
            return this.props.disabled || 'disabled'
        },
        filterData() {
            let query = this.query.toLowerCase()
            let list = this.data.filter(
                v =>
                    String(v[this.propLabel])
                        .toLowerCase()
                        .indexOf(query) > -1
            )
            return list.map(v => {
                return {
                    key: String(v[this.propKey]),
                    label: String(v[this.propLabel]),
                    disabled: v[this.propDisabled]
                }
            })
        },
        letterList() {
            let tmp = this.filterData || []
            if(this.hiddenSort) return tmp
            return tmp.length > 0 ?  initialSort(tmp) : []
        },
        showcheckedList() {
            let checkeList = this.checked
            let list = this.data.filter(
                v => checkeList.indexOf(String(v[this.propKey])) != -1
            )
            return list
        }
    },

    data() {
        return {
            checked: [],
            query: '',
            isIndeterminate: false,
            checkAll: false
        }
    },
    methods: {
        remove(index) {
            this.checked.splice(index, 1)
        },
        handleCheckAllChange(selected) {
            let tmp = this.filterData.map(v => v.key)
            // console.log({ tmp })
            this.checked = selected ? tmp : []
            this.isIndeterminate = false
        }
    },
    mounted() {
        this.checked = this.value.map(v=>String(v))
    }
}
</script>