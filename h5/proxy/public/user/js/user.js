$(function(){
	var terminaltype=/Android|iPhone|iPad/i.test(navigator.userAgent) ? 0 : 1;//0是移动端，1是PC端
	var debug = require('debug')('user:embed')
	debug("0是移动端，1是PC端 : " + terminaltype)
	if(terminaltype==1){
		if (self != top) { //检测当前页面是否在iframe中
			$(".minimize").show()
			$(".toggle").show()
			var emickfEpid = location.href.match(/emickfEpid=(.*)/)[1]
			debug("嵌入页面:",location)
		}else{
			var windowstyle = location.href.match(/toggle=(.*)&&/)[1]
			var emickfEpid = location.href.match(/emickfEpid=(.*)/)[1]
			debug("企业id" + emickfEpid)
			if(windowstyle=='model'){
				$(".toggle").show()
			}
		}
	}else {
		var emickfEpid = location.href.match(/epid=(.*)/)[1]
	}
	
	var isConnect;//socket是否连接  0是socket未连接，1是socket已连接
	var canLogin;//用户是否可以登录  0是不可以登录，1是可以登录
	var sessionCode;//访客是否可以回话  0是可以进行会话，1是不可以进行会话
	var lastMsgTime;//会话时最近的一条消息时间
	var historyTime;//查看历史纪录时最近的一条消息时间
	var msgRange;//表情待插入位置
	var selection;//表情待插入位置
	var is_robot_welcome;//机器人问候语
	var is_robot_welcome_more; // 不重复填充机器人问候语
	var robot={}
	var isKefu;
	var showHeight1,showHeight2;//广告位内容框的高度,showHeight1窗口宽度小于800时,showHeight2窗口宽度大于800时
    var url=""//缺省为连接服务器
	//表情代码
	var face=['/::)', '/::~', '/::B', '/::|', '/:8-)', '/::<', '/::$', '/::X', '/::Z', "/::'(", '/::-|', '/::@', '/::P', '/::D',
	 '/::O', '/::(', '/::+', '/:--b', '/::Q', '/::T', '/:,@P', '/:,@-D', '/::d', '/:,@o', '/::g', '/:|-)', '/::!', '/::L', '/::>',
	  '/::,@', '/:,@f', '/::-S', '/:?', '/:,@x', '/:,@@', '/::8', '/:,@!', '/:!!!', '/:xx', '/:bye', '/:wipe', '/:dig', '/:handclap',
	   '/:&-(', '/:B-)', '/:<@', '/:@>', '/::-O', '/:>-|', '/:P-(', "/::'|", '/:X-)', '/::*', '/:@x', '/:8*', '/:pd', '/:<W>',
	    '/:beer', '/:basketb', '/:oo', '/:coffee', '/:eat', '/:pig', '/:rose', '/:fade', '/:showlove', '/:heart', '/:break',
	     '/:cake', '/:li', '/:bome', '/:kn', '/:footb', '/:ladybug', '/:shit', '/:moon', '/:sun', '/:gift', '/:hug', '/:strong',
	      '/:weak', '/:share', '/:v', '/:@)', '/:jj', '/:@@', '/:bad', '/:lvu', '/:no', '/:ok', '/:love', '/:<L>', '/:jump',
	       '/:shake', '/:<O>', '/:circle', '/:kotow', '/:turn', '/:skip', '/:oY', '/:#-0', '/:hiphot', '/:kiss', '/:<&', '/:&>']
	/*****************************配置*********************************/
	//获取企业配置信息
	var eConfig={};
	$.ajax({
		type:"GET",
		url:url+"/epConfig/channelManage/query",
		data:{
			role:"guest",
			configData:"kefuIcon,cs_epname,advertisement,windowColor,advertisementPic,advertisementUrl,advertisementContent,conclusion,satisfaction,no_workingtime_alter,hasRobot"
		},
		cache:false,
		success:function(d){
			debug("企业配置:",d)
			if(d.code==200){
				if(d.data.hasRobot===1){
					robot.is_has_robot=1
				}else {
					// 机器人没有开通，转人工按钮不显示，表情以及图片按钮显示
					$(".switch_position").hide()
				}
				eConfig=d.data
				//刷新本页面就查广告位的设置是否有修改
				parentPostMessage({key:'eConfig',val:eConfig.advertisement});
				$(".enterprise_name").html(eConfig.cs_epname)
				if(eConfig.kefuIcon&&robot.is_has_robot!=1){
					var kefu_icon=url+eConfig.kefuIcon
				}
				$(".ep_logo").attr("src",kefu_icon)
				$(".leave_word_prompting").html(eConfig.no_workingtime_alter.web_context)
				if(terminaltype=="0"){
					$(".session_header,.leave_word_header,#send_message,.wap_reconnect_kefu").css("background",eConfig.windowColor)
					$(".btn_enter").css({color:eConfig.windowColor})
					$("#text_div").css({caretColor:eConfig.windowColor})
				}else{
					$(".session_header,.btn_enter,.leave_word_header,#send_message,.reconnect_kefu").css("background",eConfig.windowColor)
				}
				if(parseInt(eConfig.advertisement)==2&&terminaltype!= "0"){
					$(".session_main_right").show()
					if (self != top || document.body.offsetWidth<=800) { //检测当前页面是否在iframe中
						var cwidth=181;
					}else{
						var cwidth=251;
					}
					$(".session_main").css("width",($(".session_main").width()+cwidth)+"px")
					if(eConfig.advertisementUrl==undefined){
						var advertisement_pic=$('<a href="javascript:void(0)" >\
													<img src="'+url+eConfig.advertisementPic+'">\
												</a>')
					}else{
						if(eConfig.advertisementUrl.indexOf("http://")>=0||eConfig.advertisementUrl.indexOf("https://")>=0){
							var href=eConfig.advertisementUrl
						}else{
							var href="http://"+eConfig.advertisementUrl
						}
						var advertisement_pic=$('<a target="_blank" href="'+href+'">\
											<img src="'+url+eConfig.advertisementPic+'">\
										</a>')
					}
					var image = new Image()
					image.src = url+eConfig.advertisementPic
					image.onload=function(){
						showHeight1 = this.height/(this.width/160)+35;
						showHeight2=this.height/(this.width/230)+35;
						$(".announcement_con").css("height","calc(100% - "+showHeight1+"px)")
					}
					$(".announcement_pic").append(advertisement_pic)
					$(".announcement_con").html(eConfig.advertisementContent)
				}else{
					$(".session_main_right").hide()
				}
			}
		}
	});
	/*****************************配置*********************************/

	debug(emickfEpid)
	var socket = io(url+"/"+emickfEpid);
	
	//var socket = io(url+"/msg");
	//socket连接之后
	socket.on("connect",function(data){
		isConnect=1;
		canLogin=1;
		debug("socket连接状态:"+"socket已连接")
		userlogin()
	})
	//接收新消息
	socket.on('chat_message', function(data) {
		if(data.isAccess==11||data.isAccess==10){
			isswitchPosition(1)
		}
		debug("接收的消息:",data)
		showTime(Date.now())
		var message=data.content
		var time=data.time
		var type=data.type
		var answerType=data.answerType
		var name=data.nickName?data.nickName:''
		if(data.role==2){
			$msgStr(1,"operation","center",message)
			$(".wait_prompting").remove()
		}else if(data.role==1){
			$msgStr(1,type,"left",translationface(message),time,name)
			$(".wait_prompting").remove()
		}else if(data.role==0){
			$msgStr(1,type,"right",translationface(message),time,"")
		}else if(data.role==3){
			var name=robot.robotName?robot.robotName:'易米小超人'
			if(data.answerType==1){//直接回答
				$msgStr(1,"operation","robotscore",data,time,name,1)
			}else if(data.answerType==2){//不确定答案
				$msgStr(1,"operation","answerobj",data,time,name)
			}else if(data.answerType==3){//问题列表
				$msgStr(1,"operation","questionList",message,time,name,1)
			}else if(data.answerType==4){//未知说辞
				$msgStr(1,"operation","switchposition",message,time,name)
			}else if(data.answerType==6){//机器人闲聊
				$msgStr(1,"operation","robotscore",data,time,name,0)
			}
		}
		parentPostMessage({
			key:"openchat"
		})
		if(data.role==3){
			return
		}
		onVisibilityChange({
			msg:translationface(message),
			name:name,
			icon:$(".ep_logo").attr("src"),
			type:type,
			answerType:answerType
		})  
	});
	//客服关闭会话
	socket.on("close_session",function(data){
		debug('关闭会话',data)
		var time=Date.now();
		$(".direct-chat-messages").attr("roomID",getroomID())
		$("#typing_text").hide()
		issession(0)
		if(eConfig&&eConfig.conclusion&&parseInt(eConfig.conclusion.disabled)==0){
			if(data.code==1){
				$msgStr(1,"operation","robotclosesession",data.content,time,data.nickName) 
			}else{
				$msgStr(1,"operation","closesession",data.content,time,data.nickName) 
			}
		}else{
			if(data.code==1){
				$msgStr(1,"operation","robotclosesession","会话已结束,感谢您的咨询",time,data.nickName) 
			}else{
				$msgStr(1,"operation","closesession","会话已结束,感谢您的咨询",time,data.nickName) 
			}
		} 
		if(terminaltype!="0"){
			$(".reconnect_kefu").show()
		}else{
			$(".wap_reconnect_kefu").show()
		}
		canLogin=1;		
	})
	//接收typing事件
	socket.on('typing', function(data) {
		debug("typing事件",data)
		if (data.status=="1"){
			$("#typing_text").show();
		}else{
			$("#typing_text").hide();
		}
	});
	//socket断开连接
	socket.on('disconnect', function() {
		isConnect=0;
		issession(0)
		debug("Disconnected!");
		//socket.connect();
	});
	//socket重新连接
	socket.on("reconnect",function(){
		isConnect=1;
		issession(1)
		location.replace(location.href);
		//debug("reconnect,从客户端拉取页面")
	})
	//socket重新连接失败
	socket.on('reconnect_failed', function() {
		isConnect=0;
		issession(0)
		debug("reconnect_failed");
	});
	//转人工
	$(".switch_position").click(function(){
		socket.emit("switchPosition", {
			roomID: getroomID()
		},function(data){
			debug(data)
			// 自动补全消失
			$(".completeList") && $(".completeList").hide()
			kefuAccess(data,"notgethistory")
		});
	})
	$("body").on("click",".switchPosition",function(){
		socket.emit("switchPosition", {
			roomID: getroomID()
		},function(data){
			debug(data)
			kefuAccess(data,"notgethistory")
		});
	})
	//自动补全选中第一条
	$(".completeList").mouseover(function(){
		$(".activequestion").removeClass("activequestion")
	}) 
	$(".completeList").mouseout(function(){
		$(this).children(".completeEl:first-child").addClass("activequestion")
	}) 
	//点击机器人问题列表
	$("body").on("click",".robot_question",function(){
		if(sessionCode==0){
			return;
		}
		var message= $(this).attr("message")
		sendMsg(message); 
	})
	$("body").on("click",".completeEl",function(){
		var message= $(this).attr("message")
		sendMsg(message); 
		// $(".completeList").hide()
	})
	//自动补全
	$('#text_div').bind('input propertychange', function() {
		if(terminaltype==0||isKefu==1){
			return
		}else{
			var questionstr=$(this).text().replace(/<.*?>/ig,"")
			debug(questionstr)
				autoComplete(questionstr)	
		}
	})
	//机器人回答评分
	$("body").on("click",".evaluation_btn",function(){
		var val=$(this).attr("val")
		var time=$(this).parents(".direct_chat_msg").attr("skipTime")
		var aid=$(this).parents(".direct_chat_msg").attr("aid")
		var roomID=$(this).attr("roomID")
		var question=$(this).parents(".direct-chat-msg").prev(".direct-chat-msg").find(".direct-chat-text").html()
		socket.emit("robotscore",{
			roomID:roomID,
			isHelp:val,
			time:time,
			question:question,
			aid:aid
		},function(data){})
		$(this).parents(".ans_evaluation").hide()
		$(this).parents(".direct-chat-text").find(".fk_jg").show()
	})
	//会话结束评分
	$("body").on("click",".score_btn",function(){
		var val=$(this).attr("val")
		var roomID=$(this).attr("roomID")
		socket.emit("score",{roomID:roomID,score:val},function(data){})
		$(this).parents(".direct-chat-text").find(".evaluation_button_box").hide()
		$(this).parents(".direct-chat-text").find(".fk_jg").show()
	})
	//浮窗缩小
	$('.minimize').click(function(){
		parentPostMessage({
			key:"close"
		})
	})
	//切换成模态窗口
	$('.toggle').click(function(){
		if (self != top) { //检测当前页面是否在iframe中
			parentPostMessage({
				key:"toggle",
				val:1 //模态
			})
		}else{
			var windowstyle = location.href.split("?")[1].split("&&")[0].split("=")[1]
			if(windowstyle=='model'){
				window.close()
				parentPostMessage({
					key:"toggle",
					val:0 //浮窗，谈话继续
				})
			}
		}
	})
	// 粘贴富文本消息
	$("#text_div").on("paste",function () {
		setTimeout(function() {
			$("#text_div").text($("#text_div").text())
		}, 100);
	})
	//发送按钮发送信息
	$(".btn_enter").click(function(){
		if(sessionCode==0){
			return;
		}
		if($(".msg_cont").html().replace('<br>', "").replace(/&nbsp;/g,'')==""){
			return;
		}
		var message= $(".msg_cont").html().replace(/<img [^>]*dataface=["]([^"]+)[^>]*>/gi,function(match,capture){
		    return capture;
		});
		sendMsg(message);
	})
	//回车键发送信息`
	$(".msg_cont").keydown(function(event) {
		if(sessionCode==0){
			return;
		}
		if (event.which == 13||event.keyCode==13) {
			event.cancelBubble=true;
			event.preventDefault();
			event.stopPropagation();
			if ($(".msg_cont").html().replace('<br>', "").replace(/\s+/g, '').replace(/&nbsp;+/g, '') == ""){
				$(this).html("")
				return;
			}
		  var message= $(this).html().replace(/<img [^>]*dataface=["]([^"]+)[^>]*>/gi,function(match,capture){
			  return capture;
			});
			sendMsg(message);
			return;
		}
	});
	var timer=null;
	//聚焦
	$(".msg_cont").focus(function(){
	    // 输入发遮挡问题
	    var u = navigator.userAgent;
	    if(u.indexOf("iphone")>-1){
			setTimeout(function(){
				window.scrollTo(0, $('body')[0].offsetHeight)
				$(".direct-chat-messages").scrollTop($(".direct-chat-messages").get(0).scrollHeight-$(".direct-chat-messages")[0].offsetHeight)
			},500)
	    }
		$(this).removeClass("placeholder")
		socket.emit("typing", {
			status: 1,
			roomID: getroomID()
		});
	});
	//失去焦点
	$(".msg_cont").blur(function(){
		debug("失去焦点")
		if ($(this).html().replace('<br>', "").replace(/\s+/g, '').replace(/&nbsp;+/g, '') == ""){
			$(this).html("")
			$(this).addClass("placeholder")
		}else{
			$(this).removeClass("placeholder")
		}
		socket.emit("typing", {
			status: 0,
			roomID: getroomID()
		});
	})
	$(".msg_cont").mouseleave(function(){
		var selectionC= window.getSelection ? window.getSelection() : document.selection;	
		if(selectionC.focusNode&&selectionC.focusNode.parentNode&&selectionC.focusNode.parentNode.id === 'text_div'){
			selection=selectionC;
			msgRange= selection.createRange ? selection.createRange() : selection.getRangeAt(0);
		}
	})
	//显示表情列表
	$(".web_face").click(function(e){
		e.stopPropagation();
		if(terminaltype!="0"){
			document.getElementById('text_div').focus()
		}else{
			document.getElementById('text_div').blur()
		}
		if($(this).attr("isshow")==0){
			//session_main向上移动
			if(terminaltype=="0"){
				$(".session_main").css({height:"calc(100% - 257px)"});
			}
	     	var face_length= terminaltype=="0" ? 30 : 104 //减少表情
			for(var n=1;n<face_length;n++){
				var i=n-1;
				if(n<10){
					n="0"+n
				}
				var $li=$('<li class="face pull_left" >\
						<img dataface="'+face[i]+'" src="plugins/emoji/face/'+n+'.gif">\
					</li>')
				$(".facelist").append($li)
			}
			$(".facelist").show()
			$(this).attr("isshow","1")
		}else if($(this).attr("isshow")==1){
			if(terminaltype=="0"){
				$(".session_main").css({height:"100%"});
			}
			$(".facelist").hide().html("")
			$(this).attr("isshow","0")
		}
	})
	
	//点击空白处关闭表情
	$("body").click(function(){
		if(terminaltype=="0"){
			$(".session_main").css({height:"100%"});
	   	}
		$(".facelist").hide().html("")
		$(".web_face").attr("isshow","0")
		$(".show_box").hide()
	})
	//重新连接客服
	$(".reconnect_kefu,.wap_reconnect_kefu").click(function(){
		$(this).hide()
		//$(this).parents(".reconnectkefu_prompting").remove()
		if(isConnect==1&&canLogin==1){
			userlogin("notgethistory")
		}else{
			return;
		}
	})
	//跳转到留言
	$("body").on("click",".load_message",function(){
		socket.emit("user_no_wait",function(data){
			debug(data)
			if(data){
				socket.disconnect()
				isConnect=0;
				$(".session_main").hide()
				$(".leave_word_main").show()
				//$("input[name='name']").focus()
				 $(".leave_word_prompting").html("请留言，我们将在第一时间联系您")
				if (self != top) { //检测当前页面是否在iframe中
					parentPostMessage({
						key:"isrefresh",
				 		val:1
					})
				}
			}else{
				return;
			}	
		})
	})
	//表单验证
	$("input[name='name']").bind('input propertychange', function() {
		validationmessage()
		$("input[name='name']").next(".form_tip").remove()
		$("input[name='name']").removeClass("textarea_input_red")
		var name=$("input[name='name']").val()
		if(!$.form.isEmpty(name)){
			$(".name_img").hide()
		}else{
			$(".name_img").show()
		}
		
	})
	$("input[name='name']").blur(function(){
		validationmessage()
		setTimeout(function(){
			var name=$("input[name='name']").val()
			$(".name_img").hide()
			if(!$.form.isEmpty(name)||name.replace(/ /g,'').length===0){
				$("input[name='name']").addClass("textarea_input_red")
				$("input[name='name']").next(".form_tip").remove()
				$("input[name='name']").after("<span class='form_tip' >姓名不可以为空</span>");
			}else{
				$("input[name='name']").next(".form_tip").remove()
				$("input[name='name']").removeClass("textarea_input_red")
			}
		},500)	
	})
	$("input[name='phone']").bind('input propertychange', function() {
		validationmessage()
		$("input[name='phone']").next(".form_tip").remove()
		$("input[name='phone']").removeClass("textarea_input_red")
		var phone=$("input[name='phone']").val()
		if(phone==""){
			$(".phone_img").hide()
		}else{
			$(".phone_img").show()
		}
	})
	$("input[name='phone']").blur(function(){
		validationmessage()
		setTimeout(function(){
			$(".phone_img").hide()
			var phone=$("input[name='phone']").val()
			if(!$.form.isPhone(phone)){
				$("input[name='phone']").addClass("textarea_input_red")
				$("input[name='phone']").next(".form_tip").remove()
				$("input[name='phone']").after("<span class='form_tip' >号码有误</span>");
			}else{
				$("input[name='phone']").next(".form_tip").remove()
				$("input[name='phone']").removeClass("textarea_input_red")
			}
		},500)
		
	})
	$("input[name='email']").bind('input propertychange', function() {
		validationmessage()
		$("input[name='email']").next(".form_tip").remove()
		$("input[name='email']").removeClass("textarea_input_red")
		var email=$("input[name='email']").val()
		if($.form.isEmpty(email)){
			$(".email_img").show()
		}else{
			$(".email_img").hide()
		}
	})
	$("input[name='email']").blur(function(){
		validationmessage()
		setTimeout(function(){
			$(".email_img").hide()
			var email=$("input[name='email']").val()
			if($.form.isEmpty(email)){
				if(!$.form.isEmail(email)){
					$("input[name='email']").addClass("textarea_input_red")
					$("input[name='email']").next(".form_tip").remove()
					$("input[name='email']").after("<span class='form_tip' >邮箱格式不正确</span>");
				}else{
					$("input[name='email']").next(".form_tip").remove()
					$("input[name='email']").removeClass("textarea_input_red")
				}
			}
		},500)
	})
	$("textarea[name='message']").bind('input propertychange', function() {
		validationmessage()
		$("textarea[name='message']").next(".form_tip").remove()
		$(".post_message_main").find("textarea").removeClass("textarea_input_red")
		$(".message_text_num_span").html($(this).val().length)
		if($(this).val()!=""){
			$(this).next("img").show()
		}else{
			$(this).next("img").hide()
		}
		if($(this).val().length>499){
			$(this).val($(this).val().substring(0,500)) 
			$(".message_text_num").css("color","#fd3d39")
		}else{
			$(".message_text_num").css("color","#333")
		}
	})
	$("textarea[name='message']").blur(function(){
		validationmessage()
		setTimeout(function(){
			var message=$("textarea[name='message']").val()
			$(".clear_input_textarea").hide()
			if(!$.form.isEmpty(message)||message.replace(/ /g,'').length===0){
				$(".textarea_box").addClass("textarea_input_red")
				$(".textarea_box").next(".form_tip").remove()
				$(".textarea_box").after("<div class='form_tip' >留言内容不可以为空</div>");
			}else{
				$(".textarea_box").next(".form_tip").remove()
				$(".textarea_box").removeClass("textarea_input_red")
			}
		},500)	
	})
	$(".name_img").click(function(){
		$("input[name='name']").val("")
		$(this).hide()
	})
	$(".phone_img").click(function(){
		$("input[name='phone']").val("")
		$(this).hide()
	})
	$(".email_img").click(function(){
		$("input[name='email']").val("")
		$(this).hide()
	})
	$(".clear_input_textarea").click(function(){
		$(this).prev("textarea").val("")
		$(".message_text_num_span").html(0)
		$(this).hide()
	})
	//提交留言
	$("#send_message").click(function(){
		if($("#send_message").attr("isclick")=="1"){
			return
		}
		var name=$("input[name='name']").val()
		var phone=$("input[name='phone']").val()
		var email=$("input[name='email']").val()
		var message=$("textarea[name='message']").val()
		var userid=getuserID()
		$(".form_tip").remove()
		$(".post_message_main").find("input").removeClass("textarea_input_red")
		$(".post_message_main").find("textarea").removeClass("textarea_input_red")
		if(!$.form.isEmpty(name)){
			$("input[name='name']").addClass("textarea_input_red")
			$("input[name='name']").after("<span class='form_tip' >姓名不可以为空</span>");
		}else if(!$.form.isPhone(phone)){
			$("input[name='phone']").addClass("textarea_input_red")
			$("input[name='phone']").after("<span class='form_tip' >号码有误</span>");
		}else if($.form.isEmpty(email)){
			if(!$.form.isEmail(email)){
				$("input[name='email']").addClass("textarea_input_red")
				$("input[name='email']").after("<span class='form_tip' >邮箱格式不正确</span>");
			}else if(!$.form.isEmpty(message)){
				$("input[name='message']").addClass("textarea_input_red")
				$("textarea[name='message']").after("<span class='form_tip'  style='position:relative;top:20px;' >留言内容不可以为空</span>");
			}else{
				var data={
					name:name,
					mobile:phone,
					email:email,
					content:message,
					userid:userid
				}
				createNoteMessage(data)
			}
		}else if(!$.form.isEmpty(message)||message.replace(/ /g,'').length===0){
			$("input[name='message']").addClass("textarea_input_red")
			$("textarea[name='message']").after("<span class='form_tip' style='position:relative;top:20px;'>留言内容不可以为空</span>");
		}else{
			var data={
				name:name,
				mobile:phone,
				email:email,
				content:message,
				userid:userid
			}
			createNoteMessage(data)
		}		
	})
	
	//查看更多消息
	$("body").on("click",".getMoreMsg",function(){
		if ($(".getMoreMsg").html() == "没有更多消息了") {
			debug("没有更多消息了")
			return
		}
		var userID=getuserID();
		debug("historyTime"+historyTime)
		var skipTime = historyTime//$(".direct_chat_msg")[0].getAttribute("skipTime")
		debug(userID, skipTime)
		$.ajax({
			type:"GET",
			url:url+"/cs/guest/getHistoryMessage",
			data:{
				userid:userID,
				skipTime:skipTime,
				role:'guest'
			},
			cache:false,
			success:function(data){
				debug("历史消息:",data)
				if(data.code==200){
					var messagesList=data.data.messages
					for(var n=0;n<messagesList.length;n++){
						var role=messagesList[n].role
						var time=messagesList[n].time
						var message=messagesList[n].content
						var type=messagesList[n].type
						var name=messagesList[n].from?(messagesList[n].from.uid&&messagesList[n].from.uid.nickName?messagesList[n].from.uid.nickName:(messagesList[n].from.aid&&messagesList[n].from.aid.sender_nickname?messagesList[n].from.aid.sender_nickname:'')):'系统消息'		
						if(role=="1"){
							var direction="left"
						}else if(role=="0"){
							var direction="right"
						}else if(role=="2"){
							type="operation"
							var direction="center"
						}
						if(historyTime){
							historyTime=historyTime
						}else{
							historyTime=time
						}
						var timeDifference=historyTime-time
						if(timeDifference>60000){
							if (is_robot_welcome == 1 && messagesList[n].answerType == 5 || role == 3 && message == '这是会话结束语') {
								// nothing to do
							}else {
								var $time = $msgStr(0, "operation", "timestr", timeFormat(time))
								$(".getMoreMsg").parents(".direct-chat-msg").after($time)
								$($time)[0].scrollIntoView(true);
							}
						}
						if(role=="3"){//判断是不是机器人说的话
							var name=robot.robotName?robot.robotName:"易米小超人"
							if(messagesList[n].answerType==5){//判断是不是机器人问候语
								if(is_robot_welcome==1){
									continue
								}
								var messageObj=JSON.parse(message)
								var $msg1=$msgStr(0,"operation","questionList",messageObj.guideQuestions,time,name,0)
								if(messageObj.guideQuestions.length>0){
									$(".direct-chat-messages").prepend($msg1)
								}
								var $msg2=$msgStr(0,"text","left",messageObj.HelloWord,time,name)
								$(".direct-chat-messages").prepend($msg2)
								is_robot_welcome=1
							}else{
								debug(messagesList[n])
								if(messagesList[n].answerType==1){//直接回答
									var $msg3=$msgStr(0,"operation","robotscore",messagesList[n],time,name,0)
								}else if(messagesList[n].answerType==2){//不确定答案
									var $msg3=$msgStr(0,"operation","answerobj",messagesList[n],time,name)
								}else if(messagesList[n].answerType==3){//问题列表
									var $msg3=$msgStr(0,"operation","questionList",JSON.parse(message),time,name)
								}else if(messagesList[n].answerType==4){//未知说辞
									var $msg3=$msgStr(0,"operation","switchposition",message,time,name)
								}else if(messagesList[n].answerType==6){//直接回答
									var $msg3=$msgStr(0,"operation","robotscore",messagesList[n],time,name,0)
								}
								//var $msg=$msgStr(0,type,"left",message,time,name)
								$(".getMoreMsg").parents(".direct-chat-msg").after($msg3)
								$($msg3)[0] && $($msg3)[0].scrollIntoView(true);
							}
						}else{
							var $msg=$msgStr(0,type,direction,translationface(message),time,name)
							$(".getMoreMsg").parents(".direct-chat-msg").after($msg)
							$($msg)[0].scrollIntoView(true);
						}
						historyTime=time
					}
					$(".getMoreMsg").remove()
					var msg='<a class="getMoreMsg">查看更多</a>'
					var $msg=$msgStr(0,"operation","center",msg)
					$(".direct-chat-messages").prepend($msg)
					if (data.data.messages.length < 12 || (data.data.messages.length == 0) || (is_robot_welcome == 1 && data.data.messages.length == 1)) {
						$(".getMoreMsg").html("没有更多消息了")
					}
					$(".getMoreMsg")[0].scrollIntoView(true);
				}	
			}
		});
	})
	if(terminaltype!=0){
		$(".toolbar>div").hover(function(e){
			$(this).find("img").attr("src",$(this).find("img").attr("movesrc"))
		},function(){
			$(this).find("img").attr("src",$(this).find("img").attr("leavesrc"))
		})
	}
	//图片上传
	 $('#update_img').change(function(e){
	 	if(sessionCode==0){
			return;
		}
	 	var files = $('#update_img').prop('files');
	 	if (!files[0]){
	 		return;
	 	} 
	 	if(files[0].size>(5*1024*1024)){//限制大小5M
	 		$.tip("请发送不超过5MB的图片");
	 		return;
	 	}
		var filename =files[0].name.split('.')
		if (!/(gif|jpg|jpeg|png|bmp)$/.test(filename[filename.length - 1].toLowerCase())) {//限制格式
			$.tip('图片类型必须是.gif,jpeg,jpg,png中的一种')
			return;
		}
		var time = Date.now();
		showTime(time)
		var reader = new FileReader()
		reader.onload=function(e){
			$msgStr(1,"image","right",e.target.result,time)
		}
		reader.readAsDataURL(files[0]); 
	 	var roomID=getroomID()
	    var imgdata = new FormData();
		imgdata.append('file',files[0]);
		imgdata.append('roomID',roomID);
		$.ajax({    
			url: url+"/cs/guest/upload" , 
			type: 'POST',  
			data: imgdata,  
			cache: false,  
			contentType: false, 
			processData: false,  
			success: function (data) {
				debug("文件上传",data)
				if(data.code==200){
					$('#update_img').val("")
					var message=data.path
					socket.emit('chat_message', {
						content:message,  
						type:"image",
						roomID: roomID,
						time: time
					},function(d){
						debug(d)
						if (socket.access) return;
						debug("首次接入");
						kefuAccess(d,"notgethistory");
					}); 
				}  
			}
		});
	 })
	 //查看富文本消息的图片
	 $("body").on("click",".session_win img:not('.notScale')",function(e){
		e.stopPropagation();
		if($(this).parent()[0].className=="face pull_left"){//选择表情
			var $img=$(this).parent('.face').html()
			_insertimg($img,msgRange);
			$(this).removeClass("placeholder")
			return
		}
		var src=$(this).attr("src")
		if (src.indexOf('emoji/face')!=-1) {
			//点击表情符不处理
			return;
		}

		if(terminaltype=="0"){
			$("#img_show").attr("src",src)
			$(".img_plane").show()
			return
		}
		if (self != top) { //检测当前页面是否在iframe中
			parentPostMessage({
				key:"miHuaImgSrc",
				val:src
			})
		}else{
			$(".show_box").show()
			$(".show_img").css("background-image","url("+src+")")
		}
	 })

	 // 手机端  编辑框输入表情
	 if (terminaltype == "0") {
	  $(".facelist").on("click", "img", function (e) {
			e.stopPropagation();
			if ($(this).parent()[0].className == "face pull_left") {//选择表情
				var $img = $(this).parent('.face').html()
				_insertimg($img, msgRange);
				$(this).removeClass("placeholder")
				return
			}
    })
	 }


	
	//  $("body").on("click",".msg_img",function(e){
	//  	e.stopPropagation();
	// 	 var src=$(this).attr("src")
	// 	if(terminaltype=="0"){
	// 		$("#img_show").attr("src",src)
	// 		$(".img_plane").show()
	// 		return
	// 	}
	//  	if (self != top) { //检测当前页面是否在iframe中
	//  		parentPostMessage({
	//  			key:"miHuaImgSrc",
	// 	 		val:src
	//  		})
	// 	}else{
	// 		$(".show_box").show()
	//  		$(".show_img").css("background-image","url("+src+")")
	// 	}
	//  })



	//  手机端
	 $(".plane_close").click(function(){
		$(".img_plane").hide()
	 })
	 $(".img_plane").click(function(e){
           $(this).hide()
	 })
	 $(".show_img_close").click(function(){
	 	$(".show_box").hide()
	 })
	 $(".show_box").click(function(e){
	 	e.stopPropagation();
	 })
	function validationmessage(){
	    if(terminaltype=="0"){
			return
		}  
		var name=$("input[name='name']").val()
		var phone=$("input[name='phone']").val()
		var message=$("textarea[name='message']").val()
		if($.form.isEmpty(name)&&$.form.isPhone(phone)&&message.length>0){
			$("#send_message").css("opacity","1")
		}else{
			$("#send_message").css("opacity","0.6")
		}
	}
	//提交留言
	function createNoteMessage(data){
		$("#send_message").css("opacity","0.6")
		$.post(url+"/cs/guest/createNoteMessage",data,function(){})	
		if(terminaltype!="0"){
			$(".post_success_box").show()
			$(".post_message_main").hide()
			setTimeout(function(){
				parentPostMessage({
					key:"close"
				})
			},2000)
		}else{
			$("#send_message").attr("isclick","1")
			$.tip("提交成功")
			setTimeout(function(){
				history.go(-1)
			},2000)	
		}
	}
	//向父级页面发送数据
	function parentPostMessage(data){
		debug('send parent window:'+JSON.stringify(data))
		var parent = window.opener || window.parent;
		parent.postMessage(data,'*');
	}
	//用户登陆
	function userlogin(notgethistory){
		var roomID=getroomID();
		var userID=getuserID();
		if(roomID===null||roomID==='null'){
			roomID=	null
		}
		if(userID===null||userID==='null'){
			userID=	null
		}
		debug("用户开始登陆","roomID:"+roomID,"userID:"+userID) 
		socket.emit('user_login',{
			browser:navigator.userAgent,
			roomID:roomID,
			userID:userID
		},function(data){
			debug(data)
			if(data.robotName||data.logoUrl){
				robot.is_has_robot=1
			}
			if(data.robotName){
				robot.robotName=data.robotName
			}
			if(data.logoUrl){
				$(".ep_logo").attr("src",data.logoUrl)
			}
			canLogin=0;
			kefuAccess(data,notgethistory)
		})
	}
	//自动补全
	function autoComplete(question){
		$.ajax({
			type:"GET",
			url:url+"/cs/guest/autoComplete",
			data:{
				question:question
			},
			cache:false,
			success:function(data){
				debug("自动补全消息:",data)
				if(data.code==200){
					$(".completeList").show().html("")
					for(var n=0;n<data.message.length;n++){
						var str=data.message[n].question.replace(question, '<span class="colorRed" >'+question+'</span>');
						if(n==0){
							var $question=$('<div message="'+data.message[n].question+'" class="completeEl activequestion">'+str+'</div>')
						}else{
							var $question=$('<div message="'+data.message[n].question+'" class="completeEl">'+str+'</div>')
						}
						$(".completeList").append($question)
					}
				}
			}
    });
	}
	//客服接入
	function kefuAccess(data,notgethistory){
		if(data.access==-2){
			isKefu=1
			debug("已创建房间但未分配客服");
			socket.access = false;
			localStorage.setItem("roomID", data.roomID);
			localStorage.setItem("userID", data.userID);
			if(notgethistory!="notgethistory"){
				getSession(data.userID);
			}
			issession(1);
			return;
		}else if(data.access==0){//非工作时间
			$(".session_main").hide()
			$(".leave_word_main").show();
			if(data.userID){
				localStorage.setItem("userID", data.userID);
			}
			$(".leave_word_prompting").html("当前非工作时间，如需帮助请留言")
			if (self != top) { //检测当前页面是否在iframe中
				parentPostMessage({
					key:"isrefresh",
			 		val:1
				})
			}
			socket.disconnect()
			isConnect=0;
		}else {//1工作时间客服不在线 2有客服在线,需要排队 3机器人 10用户被自动接入  11用户被手动接入 
			issession(1);
			localStorage.setItem("roomID", data.roomID);
			localStorage.setItem("userID", data.userID);
			socket.access = true;
			if(data.access==3){
				socket.access = false;
			}else if(data.access==10){
				$msgStr(1,"operation","access",data.msg)
			}else if(data.access==2){
				$msgStr(1,"operation","leaveword",data.msg) 
			}else if(data.access==1){
				$msgStr(1,"operation","leave_word",data.msg) 
			}
			if(notgethistory!="notgethistory"){
				getSession(data.userID);
			}
		}
		if(data.access==10 ||data.access==11){
			isswitchPosition(1)
		}else{
			isswitchPosition(0)
		}
	}
	//输入框是否可以输入
	function issession(code){
		sessionCode=code
		if(code==0){
			$(".msg_send_mask").show()
			$(".msg_cont").removeAttr("contenteditable")
			$(".msg_cont").html("")
			//$(".btn_enter").css("opacity","0.6")
			debug("输入框不可编辑")
		}else if(code==1){
			$(".msg_send_mask").hide()
			$(".msg_cont").attr("contenteditable",true)
			//$(".btn_enter").css("opacity","1")
			debug("输入框可编辑")
		}
	}
	//发送消息
	function sendMsg(message) {
		//输入框发送光标居中
		var time = Date.now();
		var roomID=getroomID()
		socket.emit('chat_message', {
			content:JSON.stringify(message).substring(1,JSON.stringify(message).length - 1).replace(/\\t/g,""),  
			type:"text",
			roomID: roomID
		},function(data){
			debug(data)
			debug(socket.access)
			if (socket.access) return;
			debug("首次接入");
			kefuAccess(data,"notgethistory");
		});
		showTime(time)
		$msgStr(1,"text","right",translationface(message),time) 
		$(".msg_cont").html("")
		if(terminaltype=="0"){
			$("#text_div").css("bottom","14px")
		}
		setTimeout(function(){
			$(".completeList").hide()
		},100)
	}
	//重置roomID
	function resetRoomID(){
		debug("会话结束，重置roomid");
		window.localStorage.removeItem("roomID"); 
	} 
	//获取roomID
	function getroomID(){
		return window.localStorage.getItem("roomID"); 
	} 
	//获取userID
	function getuserID(){
		return window.localStorage.getItem("userID");
	} 
	//时间格式化
	function timeFormat (t) {
		var date = new Date(t)
		var Y = date.getFullYear()
		if (new Date().getFullYear() === Y) Y = '' 
		var M = date.getMonth() + 1
		var D = date.getDate()
		if (new Date().toDateString() === date.toDateString()) {
			M = ''
			D = ''
		}
		var H = date.getHours()
		var m = date.getMinutes()
		var s = date.getSeconds()
		if (M !== '' && M < 10) {
			M = '0' + M
		}
		if (D !== '' && D < 10) {
			D = '0' + D
		}
		if (H < 10) {
			H = '0' + H
		}
		if (m < 10) {
			m = '0' + m
		}
		if (s < 10) {
			s = '0' + s
		}
		return [Y + Y?' ':'' +M, M?'-':'', D, ' ', H, ':', m, ':', s].join('')
	}
	//会话时间显示
	function showTime(time){
		var timestr=timeFormat(time)
		if($(".timestr").length==0){
			$msgStr(1,"operation","timestr",timestr)
		}else{
			if(lastMsgTime){
				lastMsgTime=lastMsgTime
			}else{
				lastMsgTime=Date.now()
			}
			var timeDifference=time-lastMsgTime
			if(timeDifference>60000){
				$msgStr(1,"operation","timestr",timestr)
			}
		}
		lastMsgTime=time
	}
	//判断时间
	function time_range (beginTime, endTime) {
		var strb = beginTime.split (":");
		if (strb.length != 2) {
			return false;
		}
		var stre = endTime.split (":");
		if (stre.length != 2) {
			return false;
		}
		var b = new Date ();
		var e = new Date ();
		var n = new Date ();
		b.setHours (strb[0]);
		b.setMinutes (strb[1]);
		e.setHours (stre[0]);
		e.setMinutes (stre[1]);
		if (n.getTime () - b.getTime () > 0 && n.getTime () - e.getTime () < 0) {
			return true;
		} else {
			return false;
		}
	}
	//创建以及是否增加消息对象
	function $msgStr(code,type,direction,message,time,name,status){
		if(direction=="right"){
			name=""
		}
		switch(type){
			case "text"://文本消息
				var $msg= $('<div class="direct-chat-msg  direct_chat_msg '+direction+' msg_'+direction+'" skipTime="'+time+'">\
					<div class="direct-chat-info pull-'+direction+' direct-chat-info-name">'+name+'</div>\
					<div class="direct-chat-text">'+message+'</div>\
				</div>')
				break;
			case "file"://文件消息
				var $msg= $('<div class="direct-chat-msg  direct_chat_msg '+direction+' msg_'+direction+'" skipTime="'+time+'">\
						<div class="direct-chat-info pull-'+direction+' direct-chat-info-name">'+name+'</div>\
						<div class="direct-chat-text" dataurl="'+message+'">\
							<img class="msg_file" src="img/photo1.png">\
							<div class="msg_file_des">\
								<div class="file_name">问题集合.text</div>\
								<div class="file_size">1.3M</div>\
							</div>\
						</div>\
					</div>')
				break;
			case "image"://图片消息
				var $msg= $('<div class="direct-chat-msg  direct_chat_msg '+direction+' msg_'+direction+'" skipTime="'+time+'">\
						<div class="direct-chat-info pull-'+direction+' direct-chat-info-name">'+name+'</div>\
						<div class="direct-chat-text"  >\
							<img class="msg_img" src="'+url+message+'">\
						</div>\
					</div>')
				break;
			case "richtext"://富文本消息
				var $msg= $('<div class="direct-chat-msg  direct_chat_msg '+direction+' msg_'+direction+'" skipTime="'+time+'">\
					<div class="direct-chat-info pull-'+direction+' direct-chat-info-name">'+name+'</div>\
					<div class="direct-chat-text">'+message+'</div>\
				</div>')
				break;
			case "operation"://系统消息及操作消息
				switch(direction){
					case "timestr"://消息时间
						var $msg= $('<div class="direct-chat-msg timestr msg_center">\
									<div>\
										<span class="">'+message+'</span>\
									</div>\
								</div>')
						break;
					case "center"://系统消息
						var $msg= $('<div class="direct-chat-msg  msg_center">\
									<div>\
										<span class="">'+message+'</span>\
									</div>\
								</div>')
						break;
					case "access"://用户被接入
						var $msg= $('<div class="direct-chat-msg  access_user msg_center">\
									<div>\
										<span class="">'+message+'</span>\
									</div>\
								</div>')
						break;
					case "leaveword"://客服在线需要排队转留言
						var $msg= $('<div class="direct-chat-msg  msg_center wait_prompting">\
									<div>\
										<span class="">当前排在第 <span style="color:#FD3D39">'+message+'</span> 位 ! 您可以<a class="load_message" href="javascript:void(0)">转为留言</a></span>\
									</div>\
								</div>')
						break;
					case "leave_word"://客服不在线需要转留言
						var $msg= $('<div class="direct-chat-msg  msg_center wait_prompting">\
									<div>\
										<span class="">当前没有客服在线，</span><span class="">你也可以 <a class="load_message" href="javascript:void(0)">转为留言</a>, 客服会在第一时间联系您</span>\
									</div>\
								</div>')
						break;
					case "closesession"://会话结束robotclosesession
						var $msg= $('<div class="direct-chat-msg  direct_chat_msg left msg_left" skipTime="'+time+'">\
									<div class="direct-chat-info pull-left direct-chat-info-name">'+name+'</div>\
									<div class="direct-chat-text">\
										<div>'+message+'</div>\
										<div class="fk_jg" style="display:none;">感谢您的反馈</div>\
										<div class="evaluation_button_box">\
											<span style="font-size: 12px;color: #888888;letter-spacing: -0.6px;">是否解决了您的问题：</span>\
											<div class="score_btn" roomID="'+getroomID()+'"  style="float:left" val="2">\
												<img class="notScale" style="margin-left: 15px;position:relative;top:1px;" src="img/e_up.png">\
												<span>解决</span>\
											</div>\
											<div class="score_btn" roomID="'+getroomID()+'" style="float:right" val="1">\
												<img class="notScale" style="margin-left: 10px;position:relative;top:3px;" src="img/e_down.png">\
												<span>未解决</span>\
											</div>\
										</div>\
									</div>\
								</div>')
						resetRoomID()
						if(message==""){
							$msg.find(".evaluation_button_box").css("margin-top","0px")
						}
						break;
					case "robotclosesession"://会话结束
						var $msg= $('<div class="direct-chat-msg  direct_chat_msg left msg_left" skipTime="'+time+'">\
									<div class="direct-chat-info pull-left direct-chat-info-name">'+name+'</div>\
									<div class="direct-chat-text">\
										<div>'+message+'</div>\
									</div>\
								</div>')
						resetRoomID()
						if(message==""){
							$msg.find(".evaluation_button_box").css("margin-top","0px")
						}
						break;
					case "questionList"://机器人常见问题列表
						if(status==0){
							var title="【热点问题】"
						}else{
							var title="您是否要咨询以下问题"
						}
						var $msg=$('<div class="direct-chat-msg  direct_chat_msg left msg_left" skipTime="'+time+'">\
										<div class="direct-chat-info pull-left direct-chat-info-name">'+name+'</div>\
										<div class="direct-chat-text">\
											<div style="margin-bottom:10px;">'+title+'</div>\
										</div>\
									</div>')
						for(var n=0;n<message.length;n++){
							var StringValue=message[n].question||message[n].StringValue
							var $question='<div class="robot_question" message="'+StringValue+'"  style="color:#36C0FF">'+(n+1)+'. '+StringValue+'</div>'
							$msg.find('.direct-chat-text').append($question)
						}
						if (status != 0) {
							var $afterwords = '<div style="margin-bottom:10px;">点击问题获取答案</div>'
							$msg.find('.direct-chat-text').append($afterwords)
						}
						break;
					case "robotscore"://机器人答案评价
						if(status==1){
							var str='<div class="ans_evaluation" >\
								<div style="background:#36C0FF" class="evaluation_btn" roomID="'+getroomID()+'"   val="1">\
									<img class="notScale" src="img/yijiejue.png">\
									<span style="color:#fff;" >已解决</span>\
								</div>\
								<div style="border: 1px solid #DDDDDD;float:right" class="evaluation_btn" roomID="'+getroomID()+'"  val="0">\
									<img class="notScale" src="img/weijiejue.png">\
									<span  style="color:#838990;">未解决</span>\
								</div>\
							</div>'
						}else{
							var str=''
						}
						var $msg=$('<div style="min-width:170px;" class="direct-chat-msg  direct_chat_msg left msg_left" skipTime="'+time+'" aid="'+message.aId+'">\
									<div class="direct-chat-info pull-left direct-chat-info-name">'+name+'</div>\
									<div class="direct-chat-text">\
										<div style="margin-bottom:0px;">'+message.content+'</div>\
										'+str+'\
										<div class="fk_jg" style="margin-bottom:10px;display:none;">感谢您的反馈</div>\
									</div>\
								</div>')
						break;
					case "switchposition"://转人工
						var $msg=$('<div class="direct-chat-msg  direct_chat_msg left msg_left" skipTime="'+time+'" >\
									<div class="direct-chat-info pull-left direct-chat-info-name">'+name+'</div>\
									<div class="direct-chat-text">\
										<div>\
											<span class="">'+message+'， 您可以<a style="color:#36C0FF;text-decoration:none" class="switchPosition" href="javascript:void(0)">转人工客服</a></span>\
										</div>\
									</div>\
								</div>')
						break;
					case "answerobj"://不确定回答
						var $msg=$('<div style="min-width:170px;" class="direct-chat-msg  direct_chat_msg left msg_left" skipTime="'+time+'">\
								<div class="direct-chat-info pull-left direct-chat-info-name">易米小超人</div>\
								<div class="direct-chat-text">\
									<div style="margin-bottom:10px;">'+message.content+'</div>\
									<div class="ans_evaluation" >\
										<div style="background:#36C0FF" class="evaluation_btn" roomID="'+getroomID()+'"   val="1">\
											<img  class="notScale" src="img/yijiejue.png">\
											<span style="color:#fff;" >已解决</span>\
										</div>\
										<div style="border: 1px solid #DDDDDD;float:right" class="evaluation_btn" roomID="'+getroomID()+'"  val="0">\
											<img  class="notScale" src="img/weijiejue.png">\
											<span  style="color:#838990;">未解决</span>\
										</div>\
									</div>\
									<div class="fk_jg" style="margin-bottom:10px;display:none;">感谢您的反馈</div>\
								</div>\
							</div>')
						var $beforeword = '<div style="margin-bottom:10px;">您是否要咨询以下问题？</div>'
						$msg.find('.ans_evaluation').before($beforeword)
						for(var n=0;n<message.answerList.length;n++){
							var $question = '<div class="robot_question" message="' + message.answerList[n].question +'"  style="color:#36c0ff">'+(n+1)+'. '+message.answerList[n].question+'</div>'
							$msg.find('.ans_evaluation').before($question)
						}
						break;
				default:	
			}
		}
		if(code==1){
			$(".direct-chat-messages").append($msg)
			$($msg)[0].scrollIntoView(true);
			if(type=="file"||type=="image"){
               setTimeout(function(){
				$($msg)[0].scrollIntoView(true)
			   },150)
			} 
		}else{
			// 消息至底
			return $msg
		}
	}
	//获取历史记录
	function getSession(userID){
		$.ajax({
			type:"GET",
			url:url+"/cs/guest/getHistoryMessage",
			data:{
				userid:userID,
				role:'guest'
			},
			cache:false,
			success:function(data){
				debug("历史消息:",data)
				if(data.code==200){
					fillSession(data)
				}
			}
       });
	}
	//填充会话
	function fillSession(data){
		//var messagesList=data.data.messages.reverse()
		var messagesList=data.data.messages
		debug("会话数据:",messagesList)
		for(var n=0;n<messagesList.length;n++){
			var role=messagesList[n].role
			var time=messagesList[n].time
			var type=messagesList[n].type
			var message=messagesList[n].content
			if(role=="1"){
				var direction="left"
				var name=messagesList[n].from?(messagesList[n].from.uid&&messagesList[n].from.uid.nickName?messagesList[n].from.uid.nickName:(messagesList[n].from.aid&&messagesList[n].from.aid.sender_nickname?messagesList[n].from.aid.sender_nickname:'')):'系统消息'
			}else if(role=="0"){
				var direction="right"
			}else if(role=="2"){
				type="operation"
				var direction="center"
			}
			if(historyTime){
				historyTime=historyTime
			}else{
				historyTime=time
			}
			var timeDifference=historyTime-time
			if(timeDifference>60000){
				var $time = $msgStr(0, "operation", "timestr", timeFormat(historyTime))
				if(is_robot_welcome!=1){
					$(".direct-chat-messages").prepend($time)
				}
			}else {
				// 控制第一次时间显示
				if (n == messagesList.length - 1 && n != 0) {
					var $time = $msgStr(0, "operation", "timestr", timeFormat(historyTime))
					if(is_robot_welcome!=1){
						$(".direct-chat-messages").prepend($time)
					}
				}
			}
			if(role=="3"){//判断是不是机器人说的话
				var name=robot.robotName?robot.robotName:"易米小超人"
				if(messagesList[n].answerType==5){//判断是不是机器人问候语
					if(is_robot_welcome!=1){
						var messageObj=JSON.parse(message)
						var $msg1=$msgStr(0,"operation","questionList",messageObj.guideQuestions,time,name,0)
						if(messageObj.guideQuestions.length>0){
							$(".direct-chat-messages").prepend($msg1)
						}
						var $msg2=$msgStr(0,"text","left",messageObj.HelloWord,time,name)
						$(".direct-chat-messages").prepend($msg2)
						is_robot_welcome=1
					}
				}else{
					if(messagesList[n].answerType==1){//直接回答
						var $msg3=$msgStr(0,"operation","robotscore",messagesList[n],time,name,0)
					}else if(messagesList[n].answerType==2){//不确定答案
						var $msg3=$msgStr(0,"operation","answerobj",messagesList[n],time,name)
					}else if(messagesList[n].answerType==3){//问题列表
						var $msg3=$msgStr(0,"operation","questionList",JSON.parse(message),time,name)
					}else if(messagesList[n].answerType==4){//未知说辞
						var $msg3=$msgStr(0,"operation","switchposition",message,time,name)
					}else if(messagesList[n].answerType==6){//直接回答
						var $msg3=$msgStr(0,"operation","robotscore",messagesList[n],time,name,0)
					}
					//var $msg=$msgStr(0,type,"left",message,time,name)
					$(".direct-chat-messages").prepend($msg3)
				}
			}else{
				var $msg=$msgStr(0,type,direction,translationface(message),time,name)
				$(".direct-chat-messages").prepend($msg)
			}
			if(type=="image"){
				var img = new Image();   
				img.src = url+message
				img.onload=function(){
					if($(".access_user")[0]){
						$(".access_user")[0].scrollIntoView(true)
					}else if($(".wait_prompting")[0]){
						$(".wait_prompting")[0].scrollIntoView(true)
					}
				}
			}
			//$msg[0].scrollIntoView(true)
			historyTime=time
		}
		if(messagesList.length>11){
			var msg='<a class="getMoreMsg">查看更多</a>'
			var $msg=$msgStr(0,"operation","center",msg)
			$(".direct-chat-messages").prepend($msg)
		}
		if($(".direct-chat-msg").length>0){
			$(".direct-chat-msg")[$(".direct-chat-msg").length-1].scrollIntoView(true)
		}
	}
	//是否转人工
	function isswitchPosition(code){
		if(code==1){
			isKefu=1
			$(".ep_logo").attr("src",eConfig.kefuIcon)
			$(".web_face,.upload_img").show()
			$(".switchPosition,.switch_position").hide()
		}else{
			isKefu=0
			$(".web_face,.upload_img").hide()
			if(robot.is_has_robot==1){
				$(".switchPosition,.switch_position").show()
			}
		}
	}
	//表情评价选择改变
	function evaluateImgChange($this){
		if($($this).attr("active")==1){
			return;
		}else{
			$($this).attr("src",$($this).attr("active-src"))
			$($this).attr("active","1")
			$(".evaluate_img").not($this).each(function(){
				$(this).attr("active","0")
				$(this).attr("src",$(this).attr("no-src"))
			})
		}
	}
	 //过滤表情 
	function translationface(input){
	    var rFace = new RegExp("(/::\\)|/::~|/::B|/::\\||/:8-\\)|/::<|/::\\$|/::X|/::Z|/::'\\(|/::-\\||/::@|/::P|/::D|/::O|/::\\(|/::\\+|/:--b|/::Q|/::T|/:,@P|/:,@-D|/::d|/:,@o|/::g|/:\\|-\\)|/::!|/::L|/::>|/::,@|/:,@f|/::-S|/:\\?|/:,@x|/:,@@|/::8|/:,@!|/:!!!|/:xx|/:bye|/:wipe|/:dig|/:handclap|/:&-\\(|/:B-\\)|/:<@|/:@>|/::-O|/:>-\\||/:P-\\(|/::'\\||/:X-\\)|/::\\*|/:@x|/:8\\*|/:pd|/:<W>|/:beer|/:basketb|/:oo|/:coffee|/:eat|/:pig|/:rose|/:fade|/:showlove|/:heart|/:break|/:cake|/:li|/:bome|/:kn|/:footb|/:ladybug|/:shit|/:moon|/:sun|/:gift|/:hug|/:strong|/:weak|/:share|/:v|/:@\\)|/:jj|/:@@|/:bad|/:lvu|/:no|/:ok|/:love|/:<L>|/:jump|/:shake|/:<O>|/:circle|/:kotow|/:turn|/:skip|/:oY|/:#-0|/:hiphot|/:kiss|/:<&|/:&>)", 'g')
	    var str = input.replace(/&amp;/g, '&')
	            .replace(/&quot;/g, '"')
	            .replace(/&#39;/g, '\'')
	            .replace(/&lt;/g, '<')
	            .replace(/&gt;/g, '>')
	    return str.replace(rFace, function(match, text){
	        var num = face.indexOf(match) + 1
	        if (num < 10) num = '0' + num
	        return '\<img src="plugins/emoji/face/' + num + '\.gif"\>'
	    })
	}
	//检测屏幕尺寸变化
	window.onresize=function(){
		var $htmlWidth=$("html").width()
		if(eConfig.advertisement==2 && terminaltype!="0"){
			$(".session_main_right").show()
			if($htmlWidth<800){
				$(".announcement_con").css("height","calc(100% - "+showHeight1+"px)")
				$(".session_main").css("width","540px")
			}else if($htmlWidth>800 && $htmlWidth<1075){
				$(".announcement_con").css("height","calc(100% - "+showHeight2+"px)")
				$(".session_main").css("width","840px")
			}else if($htmlWidth>1075){
				$(".announcement_con").css("height","calc(100% - "+showHeight2+"px)")
				$(".session_main").css("width","1075px")
			}
		}else if(eConfig.advertisement==1 && terminaltype!="0"){
			$(".session_main_right").hide()
			if($htmlWidth<800){
				$(".session_main").css("width","360px")
			}else if($htmlWidth>800 && $htmlWidth<1075){
				$(".session_main").css("width","590px")
			}else if($htmlWidth>1075){
				$(".session_main").css("width","825px")
			}
		}
	}
	//锁定编辑器中鼠标光标位置(用于插入图片)
	function _insertimg(str){
		if (!msgRange){
			$("#text_div").append(str)
		}else{
			if (!window.getSelection){
				if(terminaltype!="0")document.getElementById('text_div').focus();
				msgRange.pasteHTML(str);
				msgRange.collapse(false);
				msgRange.select();
			}else{
				if(terminaltype!="0")document.getElementById('text_div').focus();
				msgRange.collapse(false);
				var hasR = msgRange.createContextualFragment(str);
				var hasR_lastChild = hasR.lastChild;
				while (hasR_lastChild && hasR_lastChild.nodeName.toLowerCase() == "br" && hasR_lastChild.previousSibling && hasR_lastChild.previousSibling.nodeName.toLowerCase() == "br") {
					var e = hasR_lastChild;
					hasR_lastChild = hasR_lastChild.previousSibling;
					hasR.removeChild(e);
				}                                
				msgRange.insertNode(hasR);
				if (hasR_lastChild) {
					msgRange.setEndAfter(hasR_lastChild);
					msgRange.setStartAfter(hasR_lastChild)
				}
				selection.removeAllRanges();
				selection.addRange(msgRange)
			}
		}
		$(".msg_cont").removeClass("placeholder")
		//解决图片插入聊天框显示问题
		if(terminaltype=="0"){
			if($("#text_div").height()>24){
				$("#text_div").css("bottom","6px")
			}
			$("#text_div").scrollTop($("#text_div")[0].scrollHeight)
		    $("#text_div").blur()
		}
	}
	//判断是不是当前窗口
	var hiddenProperty = 'hidden' in document ? 'hidden' :    
	    'webkitHidden' in document ? 'webkitHidden' :    
	    'mozHidden' in document ? 'mozHidden' :  null;
	var visibilityChangeEvent = hiddenProperty.replace(/hidden/i, 'visibilitychange');
	var onVisibilityChange=function(msgObj){
	    if (!document[hiddenProperty]) {
        	parentPostMessage({
        		key:"endroasting"
        	})
	    }else{
    		parentPostMessage({
    			key:"startroasting",
    			val:msgObj
    		})
	    }
	}
	var onVisibilityChange1=function(data){
	    if (!document[hiddenProperty]) {
        	onVisibilityChange()
	    }
	}
	document.addEventListener(visibilityChangeEvent, onVisibilityChange1);	
})