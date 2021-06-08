
const baz = () => {
    console.log('3:baz')
}

const bar = () => {
    console.log('6:bar')
}
const foo = () => {
 process.nextTick(() => {
  //做些事情
   console.log('4:process')
  })
  console.log('1:foo')
  setTimeout(()=>{
    bar()
  }, 5000)
  new Promise(resolve=>{
    console.log("2:Promise 同步执行")
    resolve("Promise 异步")
  }).then(res=>{
    console.log("5:"+res)
  })
  baz()
}

foo()

// const baz = () => {
//     console.log('baz')
// }

// const foo = () => {
//   console.log('foo')
//   setTimeout(bar, 0)
//   baz()
// }

// foo() 