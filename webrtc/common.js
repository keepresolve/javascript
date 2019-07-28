var signalChannel = createSignalChannel()


//candidate  候选人
/**
 * 
 * @param {*} candidate  ice candidate  ice协议建立连接需要的信息 双方需要交互这个信息
 */
function sendCandidate(candidate){
    if(candidate) signalChannel.send(JSON.stringify({"candidate":candidate}))
}
function sendDescription(){
    signalChannel.send(JSON.stringify({
        "sdp":conn.localDescription
    }))
}
//如果没有建立连接 需要创建 这里是接受端
signalChannel.onmessage=function(event){
   if(conn==null) start()
   var message = JSON.parse(event.data)
   if(message.sdp){
       conn.setRemoteDescription(new RTCSessionDescription(message.sdp),function(){
           if(conn.remoteDescription.type=='offer'){
               conn.createAnswer(function(desc){
                conn.setLocalDescription(desc,sendDescription)
               })
           }else if(message.candidate){
               conn.addIceCandidate(new RTCIceCandidate(message.candidate))
           }
       })
   }
}