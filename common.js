for (let i of new Array(10)) {
  let result = await new Promise(res => {
    if (that.isBreak) return res({ code: 200 });
    setTimeout(() => {
      res(this.$api.get("/modifyEp"));
    }, 500);
  });
  if (this.isBreak) break;
  console.log(result);
}
