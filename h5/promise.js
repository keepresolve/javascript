async function test() {
  await new Promise(res => {
    setTimeout(()=>{res()}, 10000);
  });
  return {code:13213}
}
test().then(res=>{
    console.log(res)
})