<template>
  <div class="cTransfer">
    <!-- 左边 -->
    <div class="cTransferSlide">
      <div class="cTransferHeader">
        <el-input v-model="query" :placeholder="placeholder">
          <i slot="prefix" class="el-input__icon el-icon-search"></i>
        </el-input>
        <el-checkbox
          :indeterminate="isIndeterminate"
          v-model="checkAll"
          @change="handleCheckAllChange"
        >全选</el-checkbox>
      </div>
      <div>
        <el-checkbox-group v-model="checked">
          <ul>
            <li v-for="(item,index) in letterList" :key="index" v-loading="loading">
              <div style="width:100%;height30px;">{{item.letter}}</div>
              <ul>
                <li v-for="(subItem,subIndex) in item.data" :key="subIndex">
                  <el-checkbox :label="subItem.key" :key="subItem.key">{{subItem.label}}</el-checkbox>
                </li>
              </ul>
            </li>
          </ul>
        </el-checkbox-group>
      </div>
    </div>
    <!-- 中间 -->
    <div class="cTransferMiddle"></div>
    <!-- 右边 -->
    <div class="cTransferSlide">
      <div class="cTransferHeader"></div>
      <ul>
        <li v-for="(item,index) in showcheckedList" :key="index">
          <span>{{item[propLabel]}}</span>
          <span @click="remove(index)">&times;</span>
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
import letterSort from "../../src/util/index";
export default {
  name: "cTransfer",
  componentName: "cTransfer",
  props: {
    value: {
      type: Array, //选中
      default: []
    },
    loading: {
      type: Boolean,
      default: false
    },
    data: {
      type: Array, //所有
      default: []
    },
    props: {
      type: Object,
      default() {
        return {
          label: "label",
          key: "key",
          disabled: "disabled"
        };
      }
    },
    placeholder: {
      type: String,
      default: "请输入内容"
    }
  },
  watch: {
    value(n, o) {
      console.log("valueChange", n, o);
      if (!n) this.checked = [];
      if (n.find(v => o.indexOf(v) == -1) || n.length != o.length) {
        this.checked = n;
      }
    },
    checked(n, o) {
      console.log("checkedChange", n, o);
      this.checkAll = !Boolean(
        this.data.find(v => n.indexOf(v[this.propKey]) == -1)
      );
      this.isIndeterminate = this.checkAll ? false : n.length > 0;
      let currentValue = n.slice();

      this.$emit("input", currentValue);
      this.$emit("change", currentValue);
    }
  },
  computed: {
    propKey() {
      return this.props.key || 'key';
    },
    propLabel() {
      return this.props.label || 'label';
    },
    propDisabled() {
      return this.props.disabled || 'disabled' ;
    },
    letterList() {
      let query = this.query.toLowerCase();
      let list = this.data.filter(
        v =>
          String(v[this.propLabel])
            .toLowerCase()
            .indexOf(query) > -1
      );
      let tmp = list.map(v => {
        return {
          key: v[this.propKey],
          label: v[this.propLabel]
        };
      });
      return tmp.length > 0 ? letterSort(tmp) : [];
    },
    showcheckedList() {
      let list = this.data.filter(
        v => this.checked.indexOf(v[this.propKey]) > -1
      );
      return list;
    }
  },

  data() {
    return {
      checked: [],
      query: "",
      isIndeterminate: false,
      checkAll: false
    };
  },
  methods: {
    remove(index) {
      this.checked.splice(index, 1);
    },
    handleCheckAllChange(selected) {
      this.checked = selected ? this.data.map(v => v[this.propKey]) : [];
      this.isIndeterminate = false;
    }
  },
  mounted() {
    this.checked = this.value.slice();
  },
  render(h) {}
};
</script>
<style scoped>
* {
  box-sizing: border-box;
}
.cTransfer {
  border: 1px solid #ebeef5;
  width: 100%;
  height: 100%;
  display: flex;
}
.cTransferSlide {
  padding: 5px;
  flex: 1;
}
.cTransferHeader {
  margin: 15px;
}
.cTransferMiddle {
  align-self: stretch;
  border-left: 1px solid #ebeef5;
  width: 1px;
}
</style>
