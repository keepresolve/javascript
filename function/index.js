/**
 * 
 * @param {*} options 
 */
function  pollRequest(request,options){
    this.request= {
        url:"",
        method:"get"   
    }
   this.options={
    times:5,
    delay:500,
    destroyed: false
   }
   
}
pollRequest.prototype={
 destroyed() {
    this.options.destroyed=true
 },
 init(){
   let {delay,url} = this.options
   await new Promise(res => {
     setTimeout(() => {
       res(this.$api.get("/modifyEp"));
     }, delay);
   })
 },
 isGetDelete(method){
    return (method.toLowerCase() == 'get' ||
    method.toLowerCase() == 'delete')
 }
}