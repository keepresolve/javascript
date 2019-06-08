<script>
export default {
  data() {
    return {
      msg: "jsx语法"
    };
  },
  methods: {
    print(e) {
      console.log(e);
      console.log(this);
      console.log("点击了我");
    }
  },
  render() {
    return (
      <div>
        <h1 class="h1" onClick={e => this.print(e)}>
          {this.msg}
        </h1>
      </div>
    );
  }
};
</script>

<style scoped>
.h1 {
  color: #f00;
}
</style>
