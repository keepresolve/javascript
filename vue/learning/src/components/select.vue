<template>
  <div>
    <el-select slot="reference" v-model="value5" multiple placeholder="请选择" @change="selectChange">
      <!-- <el-option key="0" label="请选择" value=""> </el-option> -->
      <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value"></el-option>
    </el-select>
    <!-- 功能—— -->
    <el-popover trigger="click" ref="popover" width="200px" v-model="isShow">
      <el-scrollbar>
        <div class="empty" @click="value5=[]">-请选择-</div>
        <el-tree
          empty-text="暂无数据"
          ref="tree"
          :data="selectData"
          :show-checkbox="true"
          node-key="id"
          :props="defaultProps"
          @check="change"
        ></el-tree>
        <div class="popover_footer">
          <el-button @click="isShow=false">重置</el-button>
          <el-button @click="isShow=false">确定</el-button>
        </div>
      </el-scrollbar>
      <el-select
        slot="reference"
        v-model="value5"
        multiple
        placeholder="请选择"
        @change="selectChange"
        popper-class="show"
      >
        <!-- <el-option key="0" label="请选择" value=""> </el-option> -->
        <el-option
          v-show="false"
          v-for="item in options"
          :key="item.value"
          :label="item.label"
          :value="item.value"
        ></el-option>
      </el-select>
    </el-popover>
  </div>
</template>
<script>
export default {
  name: "",
  data() {
    return {
      value5: [],
      selectData: [],
      isShow: false,
      defaultProps: {
        children: "children",
        label: "name"
      },
      currentNode: ""
    };
  },
  watch: {
    value5() {}
  },
  computed: {
    options() {
      let map = [];
      function fn(data) {
        data.map(v => {
          v.value = v.id;
          v.label = v.name + "(" + v.id + ")";
          map.push(v);
          if (v.children && v.children.length > 0) fn(v.children);
        });
      }
      fn(this.selectData);
      return map;
    }
  },
  methods: {
    init() {
      // this.$refs.tree.setCheckedKeys([9], true);
      // this.value5 = [9];
    },
    selectChange(item) {
      this.$refs.tree.setCheckedKeys(item, true);
    },
    change(item) {
      let checkKeys = this.$refs.tree.getCheckedKeys();
      // this.value5 = checkKeys;
      console.log(
        "getHalfCheckedKeys",
        this.$refs.tree.getHalfCheckedKeys(),
        this.$refs.tree.getHalfCheckedNodes()
      );
      console.log("getCheckedKeys", this.$refs.tree.getCheckedKeys());
      console.log("getCheckedNodes", this.$refs.tree.getCheckedNodes());
      let getCheckedTerrNode = checkKeys.map(v => this.$refs.tree.getNode(v));
      console.log("getCheckedTerrNode", getCheckedTerrNode);
      let map = new Set(checkKeys);
      function fn(children) {
        for (let index = 0; index < children.length; index++) {
          let element = children[index];
          console.log(element.key);
          map.delete(element.key);
          if (!element.isLeaf) {
            fn(element.childNodes);
          }
        }
      }
      getCheckedTerrNode.forEach(node => {
        if (!node.isLeaf && node.checked) {
          fn(node.childNodes);
        }
      });
      console.log({ map });
      this.value5 = Array.from(map);
      setTimeout(() => {
        this.$refs.popover.updatePopper();
      }, 50);
    },
    getCurrentNode(checkList) {
      console.log({ checkList });
    },
    getCheckedNode(checkList) {}
  },
  mounted() {
    this.selectData = [
      {
        id: 179,
        seid: 134,
        ccgeid: 0,
        name: "11",
        parent_id: 0,
        order: 0,
        children: [
          {
            id: 182,
            seid: 134,
            ccgeid: 0,
            name: "111",
            parent_id: 179,
            order: 0,
            created_at: "2019-03-27 16:30:07",
            updated_at: "2019-03-27 16:30:07",
            children: [
              {
                id: 199,
                seid: 134,
                ccgeid: 0,
                name: "111",
                parent_id: 179,
                order: 0,
                created_at: "2019-03-27 16:30:07",
                updated_at: "2019-03-27 16:30:07",
                children: [
                  {
                    id: 200,
                    seid: 134,
                    ccgeid: 0,
                    name: "111",
                    parent_id: 179,
                    order: 0,
                    created_at: "2019-03-27 16:30:07",
                    updated_at: "2019-03-27 16:30:07",
                    children: [
                      {
                        id: 201,
                        seid: 134,
                        ccgeid: 0,
                        name: "111",
                        parent_id: 179,
                        order: 0,
                        created_at: "2019-03-27 16:30:07",
                        updated_at: "2019-03-27 16:30:07",
                        children: [
                          {
                            id: 204,
                            seid: 134,
                            ccgeid: 0,
                            name:
                              "111111111111111111111111111111111111111111111",
                            parent_id: 179,
                            order: 0,
                            created_at: "2019-03-27 16:30:07",
                            updated_at: "2019-03-27 16:30:07",
                            children: [
                              {
                                id: 206,
                                seid: 134,
                                ccgeid: 0,
                                name: "111",
                                parent_id: 179,
                                order: 0,
                                created_at: "2019-03-27 16:30:07",
                                updated_at: "2019-03-27 16:30:07"
                              }
                            ]
                          }
                        ]
                      }
                    ]
                  }
                ]
              }
            ]
          },
          {
            id: 185,
            seid: 134,
            ccgeid: 0,
            name: "11",
            parent_id: 179,
            order: 1,
            created_at: "2019-03-27 16:30:18",
            updated_at: "2019-03-27 16:30:18",
            children: []
          }
        ],
        created_at: "2019-03-27 16:29:44",
        updated_at: "2019-03-28 16:41:49"
      },
      {
        id: 177,
        seid: 134,
        ccgeid: 0,
        name: "\u603b\u90e81",
        parent_id: 0,
        order: 1,
        children: [
          {
            id: 178,
            seid: 134,
            ccgeid: 0,
            name: "111",
            parent_id: 177,
            order: 0,
            created_at: "2019-03-27 16:29:44",
            updated_at: "2019-03-27 16:29:44",
            children: []
          }
        ],
        created_at: "2019-03-27 16:29:44",
        updated_at: "2019-03-28 16:41:49"
      },
      {
        id: 180,
        seid: 134,
        ccgeid: 0,
        name: "12",
        parent_id: 0,
        order: 2,
        children: [
          {
            id: 183,
            seid: 134,
            ccgeid: 0,
            name: "121",
            parent_id: 180,
            order: 0,
            created_at: "2019-03-27 16:30:07",
            updated_at: "2019-03-27 16:30:07",
            children: []
          }
        ],
        created_at: "2019-03-27 16:29:44",
        updated_at: "2019-03-27 16:29:44"
      },
      {
        id: 181,
        seid: 134,
        ccgeid: 0,
        name: "13",
        parent_id: 0,
        order: 3,
        children: [
          {
            id: 184,
            seid: 134,
            ccgeid: 0,
            name: "131",
            parent_id: 181,
            order: 0,
            created_at: "2019-03-27 16:30:07",
            updated_at: "2019-03-27 16:30:07",
            children: []
          }
        ],
        created_at: "2019-03-27 16:29:44",
        updated_at: "2019-03-27 16:29:44"
      },
      {
        id: 201,
        seid: 134,
        ccgeid: 0,
        name: "\u6492\u65e6\u6492",
        parent_id: 0,
        order: 4,
        children: [],
        created_at: "2019-03-28 15:22:28",
        updated_at: "2019-03-28 15:22:28"
      },
      {
        id: 211,
        seid: 134,
        ccgeid: 0,
        name: "\u5ba2\u6237\u5c5e\u6027",
        parent_id: 0,
        order: 5,
        children: [
          {
            id: 212,
            seid: 134,
            ccgeid: 0,
            name: "\u91d1\u878d",
            parent_id: 211,
            order: 0,
            created_at: "2019-04-08 11:19:37",
            updated_at: "2019-04-08 11:19:37",
            children: []
          },
          {
            id: 213,
            seid: 134,
            ccgeid: 0,
            name: "\u94f6\u884c",
            parent_id: 211,
            order: 1,
            created_at: "2019-04-08 11:19:37",
            updated_at: "2019-04-09 16:25:00",
            children: []
          },
          {
            id: 214,
            seid: 134,
            ccgeid: 0,
            name: "\u7269\u6d41",
            parent_id: 211,
            order: 2,
            created_at: "2019-04-08 11:19:37",
            updated_at: "2019-04-09 16:25:00",
            children: []
          },
          {
            id: 215,
            seid: 134,
            ccgeid: 0,
            name: "\u4fdd\u9669",
            parent_id: 211,
            order: 3,
            created_at: "2019-04-08 11:19:37",
            updated_at: "2019-04-09 16:25:00",
            children: []
          },
          {
            id: 216,
            seid: 134,
            ccgeid: 0,
            name: "\u7535\u5546",
            parent_id: 211,
            order: 4,
            created_at: "2019-04-08 11:19:37",
            updated_at: "2019-04-08 11:19:37",
            children: []
          },
          {
            id: 217,
            seid: 134,
            ccgeid: 0,
            name: "\u9500\u552e",
            parent_id: 211,
            order: 5,
            created_at: "2019-04-08 11:19:37",
            updated_at: "2019-04-08 11:19:37",
            children: []
          },
          {
            id: 218,
            seid: 134,
            ccgeid: 0,
            name: "\u5176\u4ed6",
            parent_id: 211,
            order: 6,
            created_at: "2019-04-08 11:19:37",
            updated_at: "2019-04-08 11:19:37",
            children: []
          }
        ],
        created_at: "2019-04-08 11:19:37",
        updated_at: "2019-04-08 11:19:37"
      }
    ];
  }
};
</script>
