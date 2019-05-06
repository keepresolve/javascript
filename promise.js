function axios() {
  return new Promise((resolve, reject) => {
    resolve({ code: 200 });
  });
}

function dpRequest() {
  return new Promise(resolve => {
    axios()
      .then(res => {
        // if(false)
        resolve(res);
      })
      .catch(err => {
        resolve(err);
      });
  });
}

dpRequest().then(res => {
  console.log(res);
});
