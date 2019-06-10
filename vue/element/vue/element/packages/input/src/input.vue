<template>
  <div
    :class="['el-input',{
        'el-input--prefix': $slots.prefix || prefixIcon,
    }]"
    @mouseenter="hovering = true"
    @mouseleave="hovering = false"
  >
    <template>
      <input
        class="el-input__inner"
        v-bind="$attrs"
        ref="input"
        @input="handleInput"
        @change="handleChange"
      >
      <!-- 前置内容 -->
      <span class="el-input__prefix" v-if="$slots.prefix || prefixIcon">
        <slot name="prefix"></slot>
        <i class="el-input__icon" v-if="prefixIcon" :class="prefixIcon"></i>
      </span>
    </template>
  </div>
</template>
<script>
export default {
  name: "ElInput",
  componentName: "ElInput",
  data() {
    return {
      hovering: false,
      focused: false
    };
  },

  props: {
    value: [String, Number],
    prefixIcon: String,
    disabled: Boolean,
    readonly: Boolean,
    type: {
      type: String,
      default: "text"
    }
  },

  computed: {
    nativeInputValue() {
      return this.value === null || this.value === undefined
        ? ""
        : String(this.value);
    }
  },

  watch: {
    value(val) {
      console.log({ val });
    },
    nativeInputValue() {
      this.setNativeInputValue();
    }
  },

  methods: {
    setNativeInputValue() {
      const input = this.getInput();
      if (!input) return;
      if (input.value === this.nativeInputValue) return;
      input.value = this.nativeInputValue;
    },

    handleInput(event) {
      this.$emit("input", event.target.value);

      // ensure native input value is controlled
      // see: https://github.com/ElemeFE/element/issues/12850
      this.$nextTick(this.setNativeInputValue);
    },
    handleChange(event) {
      this.$emit("change", event.target.value);
    },

    getInput() {
      return this.$refs.input;
    }
  },

  mounted() {
    this.setNativeInputValue();
  },

  updated() {
    this.$nextTick(this.updateIconOffset);
  }
};
</script>
