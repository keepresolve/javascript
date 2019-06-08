<template>
  <div class="cTransfer">
    <!-- 左边 -->
    <div class="cTransferSlide">
      <div class="cTransferHeader">
        <el-input v-model="query" placeholder="请输入搜索内容">
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
            <li v-for="(item,index) in filterData" :key="index">
              <el-checkbox :label="item[propKey]" :key="item[propKey]">{{item[propLabel]}}</el-checkbox>
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
          {{item[propLabel]}}
          <span @click="remove(index)">&times;</span>
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
export default {
  name: "cTransfer",
  componentName: "cTransfer",
  props: {
    value: {
      type: Array, //选中
      default: []
    },
    data: {
      type: Array, //所有
      default: []
    },
    props: {
      key: {
        type: String,
        default: "key"
      },
      label: {
        type: String,
        default: "label"
      },
      disabled: {
        type: String,
        default: "disabled"
      }
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
      this.isIndeterminate=this.checkAll?false:n.length>0
      let currentValue = n.slice();

      this.$emit("input", currentValue);
      this.$emit("change", currentValue);
    }
  },
  computed: {
    propKey() {
      return this.props.key;
    },
    propLabel() {
      return this.props.label;
    },
    propDisabled() {
      return this.props.disabled;
    },
    filterData() {
      let query = this.query.toLowerCase();
      let list = this.data.filter(
        v =>
          String(v[this.propLabel])
            .toLowerCase()
            .indexOf(query) > -1
      );
      return list;
    },
    showcheckedList() {
      let list = this.data.filter(v => this.checked.indexOf(v[this.propKey]) > -1);
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
      this.isIndeterminate=false
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
