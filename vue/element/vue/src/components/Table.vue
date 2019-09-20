<template>
  <div>
    <div class="table-warpper">
      <div class="loaddingPage" v-if="loadingPage" v-loading="true"></div>
      <el-table
        :data="tableRowKey"
        v-if="!loadingPage"
        :span-method="arraySpanMethod"
        :cell-class-name="cellClassName"
      >
        <el-table-column prop="title" fixed="left" label="对应条件/供应商" width="180"></el-table-column>
        <template>
          <el-table-column
            v-for="(value) in tableList"
            :key="value"
            min-width="100"
            :label="value.hotelIndex"
            align="center"
          >
            <template slot="header">
              <div v-if="value.colType=='1'">
                <span>{{ value.hotelIndex}}</span>
                <span @click="checkHotel(value)">edit</span>
              </div>
              <div v-else>
                {{
                value.hotelIndex
                }}
              </div>
            </template>
            <template slot-scope="scope">
              <div v-if="!scope.row.isHandle">{{filterKey(value,scope.row.keyName)}}</div>
              <div v-else>
                <div v-if="scope.row.keyName=='longitudeLatitude'">
                  <span>经度 {{value[scope.row.keyName]['x']}}</span>
                  <span>纬度 {{value[scope.row.keyName]['y']}}</span>
                  <div>
                    <a @click="checkMap">查看地图</a>
                  </div>
                </div>
                <div v-else>--</div>
              </div>
            </template>
          </el-table-column>
        </template>
        <template slot="append">
          <div class="footer cell">
            <div>
              选择并合并酒店
              <el-radio-group v-model="radio">
                <el-radio :label="1">备选项</el-radio>
                <el-radio :label="2">备选项</el-radio>
                <el-radio :label="3">备选项</el-radio>
              </el-radio-group>
            </div>
            <div>
              <el-button type="primary">取消</el-button>
              <el-button type="primary">确认</el-button>
            </div>
          </div>
        </template>
      </el-table>
    </div>
  </div>
</template>
<script>
export default {
  name: "table",
  computed: {
    eiditCol() {
      let index = 0;
      let item = this.tableList.find((v, i) => {
        if (v.colType == "1") index = i;
        return v.colType == "1";
      });
      return { item, index: index + 1 };
    },
    colList() {
      let list = [];
      this.tableList.forEach((item, i) => {
        if (item.isCol) {
          list.push({ index: i + 1, item });
        }
      });
      return list;
    }
  },
  data() {
    return {
      tableRowKey: [
        {
          title: "酒店名称",
          keyName: "hotelName",
          isHeader: true,
          isHandle: false
        },
        {
          title: "所在城市",
          keyName: "city",
          isHandle: false
        },
        {
          title: "地址",
          keyName: "url",

          isHandle: false
        },
        {
          title: "经纬度",
          keyName: "longitudeLatitude",

          isHandle: true
        },
        {
          title: "品牌",
          keyName: "brand",

          isHandle: false
        },
        {
          title: "电话",
          keyName: "phone",
          isHandle: false
        }
      ],

      tableList: [
        {
          colType: "1", //0 推荐匹配结果 //1 是自定义添加  //1 所有对比
          isCol: true, //是都合并行
          hotelIndex: "自定义酒店",
          hotelName: "无任何数据信息",
          city: "北京",
          longitudeLatitude: {
            x: "2313",
            y: 12132
          },
          brand: "李宁",
          phone: "123213"
        }
      ],
      radio: 3,
      loadingPage: false
    };
  },
  mounted() {
    this.loadingPage = true;
    setTimeout(() => {
      this.loadingPage = false;
      this.tableList.unshift(
        {
          colType: "0",
          hotelIndex: "酒店名称A",
          hotelName: "酒店名称名称",
          city: "北京",
          longitudeLatitude: {
            x: "2313",
            y: 12132
          },
          brand: "李宁1",
          phone: "123213"
        },
        {
          colType: "0",
          hotelIndex: "酒店名称A",
          hotelName: "酒店名称名称",
          city: "北京",
          longitudeLatitude: {
            x: "2313",
            y: 12132
          },
          brand: "李宁2",
          phone: "123213"
        }
      );
      this.tableList.push({
        colType: "2",
        hotelIndex: "捷旅酒店",
        hotelName: "无任何数据信息",
        city: "北京1",
        longitudeLatitude: {
          x: "asdasd",
          y: 123123
        },
        brand: "李1宁",
        phone: "12321qq3"
      });
    }, 3000);
  },
  methods: {
    arraySpanMethod({ row, column, rowIndex, columnIndex }) {
      let isHas = this.colList.find(v => v.index == columnIndex);
      if (isHas) {
        if (rowIndex == 0) {
          return [7, 1];
        } else {
          return [0, 0];
        }
      }
    },
    cellClassName({ row, column, rowIndex, columnIndex }) {
      // if (rowIndex > 0) {
      //   let { item, index } = this.eiditCol;
      //   if (item.isCol && columnIndex == index) {
      //     return "customCell";
      //   }
      // }
    },
    filterKey(value, key) {
      return value[key] || "--";
    },
    //选择自定义
    checkHotel(item) {
      item.isCol = !item.isCol;
    },
    //查看地图
    checkMap() {}
  }
};
</script>
<style scope>
/* .customCell .cell {
  padding: 0px;
  margin: 0px;
  height: 0px;
} */
/* .table-warpper {
  display: flex;
} */
/* .table-list > .el-table {
  flex: 1;
} */
.table-warpper .el-table {
  max-width: 100%;
}
.loaddingPage {
  height: 100%;
}
.el-table {
  border: 1px solid;
}
.el-table td {
  border: 1px solid;
  border-left: transparent;
  border-top: transparent;
}
.el-table tr td:last-child {
  border-right: transparent;
}
.el-table th {
  border: 1px solid;
  border-left: transparent;
}
.el-table__header th {
  background: purple;
}
.footer {
  text-align: center;
  padding: 12px 0px;
}
</style>
