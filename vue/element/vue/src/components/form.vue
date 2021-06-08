<template>
    <div class="page-main">
      
            <el-form ref="ruleForm" :model="tourist" inline class="tourist-list" :rules='touristRules'>
                <transition-group name="el-fade-in-linear" tag="div">
                    <div v-for="(tourist, index) in tourist.list" :key="tourist.id" class="tourist-item">
                        <el-form-item :prop="`list.${index}.name`" :ref='`tourist-${tourist.id}`'>
                              <ElTimeSelect/>
                            <span slot='label'></span>
                            <el-input :disabled="tourist.disabled" placeholder="请输入姓名" v-model="tourist.name" style="width:100px"></el-input>
                        </el-form-item>
                        <el-form-item label="手机号" :prop="`list.${index}.phone`">
                            <el-input :disabled="tourist.disabled" placeholder="请输入手机号" v-model="tourist.phone"></el-input>
                        </el-form-item>
                        <el-form-item :prop="`list.${index}.num`">
                            <el-input-number v-model="tourist.num" :min="1"></el-input-number>
                        </el-form-item>
                        <el-form-item><span class="el-icon-remove-outline h2 pointer" /></el-form-item>
                    </div>
                </transition-group>

            </el-form>
        <el-button @click="reset">aaa</el-button>
    </div>

</template>


<script>
import Vue from "vue";
const getUniqueld = (function () {
    const id = 0;
    return function (_key) {
        return "uuid_" + Date.now() + "_" + _key;
    };
})();
const ElTimeSelect = {
    componentName: 'ElTimeSelect',
    name: "ElTimeSelect",
    data() {},
    created() {
        console.log({ ElTimeSelect: this });
        this.$on("fieldReset", function () {
            console.log("ElTimeSelect", arguments);
        });
    },
    render() {
        return <div>{this.$scopedSlots.default&&this.$scopedSlots.default()}</div>;
    },
};
// Vue.component("ElTimeSelect", ElTimeSelect);

export default {
    name: "form",
    components: {
        ElTimeSelect,
    },
    data() {
        return {
            tourist: {
                list: new Array(30).fill({}).map((v, index) => ({
                    phone: new Array(11)
                        .fill("")
                        .map(() => Math.floor(Math.random() * 10))
                        .join(""),
                    name: new Array(Math.ceil(Math.random() * 10))
                        .fill("")
                        .map(() =>
                            String.fromCharCode(
                                String(
                                    Math.floor(
                                        Math.random() * (4086900 - 19968 + 1)
                                    ) + 19968,
                                    16
                                )
                            )
                        )
                        .reduce((t, i) => t + i, ""),
                    num: 1,
                    id: getUniqueld("orderTourist"),
                    checked: false,
                })),
            },
        };
    },
    created() {
        console.log({ form: this });
        this.$on("fieldReset", function () {
            console.log("ElTimeSelect", arguments);
        });
    },
    computed: {
        touristRules() {
            return;
        },
    },
    methods: {
        reset() {
            this.$refs.ruleForm.resetFields();
        },
    },
};
</script>

<style>
</style>