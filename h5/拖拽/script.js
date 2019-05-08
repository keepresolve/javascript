(function () {
	// 获取url
	// var tmp = document.getElementById("emickf_ee549f8c0be21546").src.match(/(http.*)\/script/)
	var hasParams = document.getElementById("emickf_ee549f8c0be21546").src.match(/\?.+/)? document.getElementById("emickf_ee549f8c0be21546").src.match(/\?.+/)[0]:undefined
	var target = hasParams ? hasParams.substring(1).split("=")[1] : undefined
	// var target=(params[0].substring(1)).split("=")[1]
	var url = "http://demo.emickf.com"
	// 引入jQuery, 用CDN ！！
	var script = document.createElement("script");
	script.src = 'https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js';
	script.type = 'text/javascript';
	document.getElementsByTagName("head")[0].appendChild(script);
	var debug = console.log

	script.onload = function () {
		var $ = window.jQuery;
		//获取企业配置信息
		var eConfig = {};
		//是否需要刷新iframe
		var isrefresh;//1需要刷新,0不需要刷新,为了留言与聊天界面的切换
		var msgTitle;//title轮播提示定时器
		var pagetitle = document.title;//原页面title
		var isDeskProPermission;//是否询问过用户授权桌面通知
		var $window = $(window);//当前浏览器窗口
		var terminaltype = /Android|iPhone|iPad/i.test(navigator.userAgent) ? 0 : 1;//0是移动端，1是PC端
		var sessionwindowstyle = localStorage.sessionwindowstyle == 1 ? 1 : 0 //窗口模式0浮窗 1模态框
		target = $("#"+target).length>0?target:undefined
		//var url=""//本地
		//获取配置创建入口图标
		$.ajax({
			type: "GET",
			url: url + "/epConfig/channelManage/query",
			data: {
				role: "guest",
				configData: "kefuIcon,advertisement,enterStyle,mainColor,domain"
			},
			cache: false,
			success: function (d) {
				debug("企业配置:")
				debug(d)
				if (d.code == 200) {
					localStorage.setItem("emickfEpid", d.data.epid);
					adjustADWidth(d.data.advertisement == 2 ? 1 : 0)
					var icon = $('<div id="c-ENTRY-0" style="position: fixed;right: 30px;bottom: 30px;width: 90px;height: 40px;background-color: ' + d.data.mainColor + ';border-radius: 20px;box-shadow: 0px 6px 10px 0px rgba(0,0,0,0.25);cursor: pointer;">\
						<img src="'+ url + '/user/img/chaticon.png" alt="" style="width: 22px;height: auto;margin-left:15px;margin-top:10px;">\
						<div style="float:right;margin-top:10px;margin-right:5px;padding: 0 10px;font-size: 14px;text-align: center;color: #fff">咨询</div>\
					</div>')
					var icon1 = $('<div id="YSF-CUSTOM-ENTRY-0" style="position: fixed;right: 30px;bottom: 30px;width: 40px;height: 85px;background-color: ' + d.data.mainColor + ';border-radius: 20px;box-shadow: 0px 6px 10px 0px rgba(0,0,0,0.25);cursor: pointer;">\
						<img src="'+ url + '/user/img/chaticon.png" alt="" style="width: 22px;height: auto;margin-left:9px;margin-top:13px;">\
						<div style="padding: 0 10px;font-size: 14px;text-align: center;color: #fff">咨询</div>\
					</div>')
					if (d.data.enterStyle == 2 && !target) {
						$("body").append(icon)
					} else if (d.data.enterStyle == 1 && !target) {
						$("body").append(icon1)
					}
				}
			}
		});
				// div.onmousedown=function(event){
				// 	console.log(11111)
				// 	var e=event||window.event
				// 	 var x=e.offsetX
				// 	 var y=e.offsetY
				//   document.onmousemove=function(event){
				// 	  var e=event||window.event
				// 	 div.style.left=e.clientX-x+"px"
				// 	 div.style.top=e.clientY-y+"px"
				//   }
				// 	  div.onmouseup=function(){
				// 			document.onmousemove=""
				// 		}
				// 	 return false
					 
				// }
		$("html").on("mousedown","#YSF-PANEL-INFO",function(ev){
			    // ev.stopPropagation()
			    // this.style.cursor = "move";
				// var divx = e.clientX-this.offsetLeft;
				// var divy = e.clientY-this.offsetTop;
				// var that=this
				// document.onmousemove = function(e){//鼠标悬浮事件
				// 	var left = e.clientX-divx;
				// 	var top = e.clientY-divy;
				// 	that.style.left = left+"px";
				//     that.style.top = top+"px";
				// }
				// document.onmouseup = function(){//鼠标松开事件
				// 	document.onmousemove="";
				// 	document.onmouseup="";
				// 	that.style.cursor = "pointer";
				// }
			
				// oDiv2.onmousedown = function(ev) {
					var oEvent = ev || event;
					var that=this
					var disX = oEvent.clientX - this.offsetLeft;
					var disY = oEvent.clientY - this.offsetTop;
					this.style.cursor = "move";
					document.onmousemove = function(ev) {
					 var oEvent = ev || event;
					 var l = oEvent.clientX - disX;
					 var t = oEvent.clientY - disY;
				 
					if(l<=20){
						l=20
					}
					if(l>=document.body.clientWidth-that.offsetWidth-20){
						l=document.body.clientWidth-that.offsetWidth-20
					}
					if(t<=20){
						t=20
					}
					console.log(l,t)
					// if(t>=document.body.clientHeight-that.offsetHeight){
					// 	t=document.body.clientHeight-that.offsetHeight
					// }
					if(t>=document.body.clientHeight+200){
						t=document.body.clientHeight+200
					}
					 that.style.left = l + 'px';
					 that.style.top = t + 'px';
					};
				 
				 
					document.onmouseup = function() {
					 document.onmousemove = null;//如果不取消，鼠标弹起div依旧会随着鼠标移动
					 document.onmouseup = null;
					 that.style.cursor = "pointer";
					};
				//    };
				   return false;
		})
		$("#" + target).click(function () {
			if (terminaltype == 0) {//移动端
				window.location.href = url + '/user/mobile.html?epid=' + localStorage.getItem("emickfEpid")
			} else {//PC端
				PromptNewMessage(false)
			}
		})
		//打开浮窗
		$("html").on("click", "#YSF-CUSTOM-ENTRY-0", function () {
			if (terminaltype == 0) {//移动端
				window.location.href = url + '/user/mobile.html?epid=' + localStorage.getItem("emickfEpid")
			} else {//PC端
				PromptNewMessage(false)
			}
		})
		//关闭图片
		$("html").on("click", ".show_img_close", function () {
			$(".show_box").remove()
		})
		//接收子级页面传递的信息
		window.addEventListener('message', function (e) {
			debug("key:" + e.data.key + " source:" + e.origin)
			switch (e.data.key) {
				case "close":
					debug('关闭浮窗')
					$("#YSF-PANEL-INFO").animate({ bottom: "-600px" }, 0.5)
					setTimeout(function () {
						$("#YSF-CUSTOM-ENTRY-0").show();
					}, 500)
					break;
				case "toggle":
					var style = e.data.val
					debug('切换为模态窗:' + style)
					sessionwindowstyle = localStorage.sessionwindowstyle = style
					//sessionwindowstyle = style
					if (style == 1) {
						$("#YSF-PANEL-INFO").animate({ bottom: "-600px" }, 0.5)
						setTimeout(function () {
							$("#YSF-CUSTOM-ENTRY-0").show();
						}, 500)
						openModelChat()
						break;
					}
					if (style == 0) {
						isrefresh = 1
						openChat()
					}
					break;
				case "miHuaImgSrc":
					debug('查看图片')
					var src = e.data.val
					if (src.indexOf('data:image') > -1) {
						// base64 图片操作
						imgUrl = src
					} else {
						//path 图片操作
						debug(src.replace(/\\/g, '/'))
						imgUrl = url + src.replace(/\\/g, '/');
						if (src.indexOf('http://') > -1 || src.indexOf('https://') > -1) {
							imgUrl = src.replace(/\\/g, '/');
						} else {
							imgUrl = url + src.replace(/\\/g, '/');
						}
					}
					debug(src)
					$(".show_box").remove()
					var $img = $('<div class="show_box"  scale="1" style="position: absolute;width:800px;height: 600px;top: calc(50% - 300px);left: calc(50% - 400px);z-index: 1000;background:#ffffff;border:1px solid #eeeeee;box-shadow:0 2px 5px 0 rgba(50,50,50,0.50);border-radius:2px;">\
						<img src="'+ url + '/user/img/Shapeclose.png" class="show_img_close" style="z-index:1000;position: absolute;top: 10px;right: 10px;">\
						<div class="show_img "  style="background-image:url('+ imgUrl + ');width: 760px;height: 560px;margin-top: 19px;margin-left:19px; background-repeat:no-repeat;background-position: center center;background-size: contain;background-color: #eee;background-origin: content-box;">\
						</div>\
					</div>')
					$($img).appendTo('body');
					break;
				case "isrefresh":
					debug('需要刷新页面')
					isrefresh = 1
					$("#YSF-PANEL-INFO").css("width", "360px")
					break;
				case "startroasting":
					debug('提示新消息')
					if ('Notification' in window) {
						debug("支持桌面提醒")
						debug(Notification.permission)
						if (Notification.permission == "default") {//default 用户没有接收或拒绝授权 不能显示通知
							if (isDeskProPermission != 1) {
								NotificationHandler.requestPermission();
							}
							PromptNewMessage(true)
						} else if (Notification.permission == "granted") {//granted 用户接受授权 允许显示通知 
							NotificationHandler.showNotification(e.data.val)
						} else if (Notification.permission == "denied") {//denied  用户拒绝授权 不允许显示通知
							document.title = "您有一条新消息，请注意查看"
							PromptNewMessage(true)
						} else {
							PromptNewMessage(true)
						}
					} else {
						debug("不支持桌面提醒")
						PromptNewMessage(true)
					}
					break;
				case "endroasting":
					debug('停止提示消息')
					window.clearInterval(msgTitle)
					document.title = pagetitle;
					break;
				case "openchat":
					debug('打开窗口')
					PromptNewMessage(false, true)
					break;
				case "eConfig":
					//目前只判断广告位是不是更新
					debug('更改配置')
					adjustADWidth(e.data.val == 2 ? 1 : 0)
					break;
				default:
			}
		}, false);
		//提示新消息
		function PromptNewMessage(code, type) {
			if (code) {
				pageTitleScroll()
			}
			if (sessionwindowstyle == 0) {//浮层
				openChat()
			} else {
				if (type) {
					return
				}
				openModelChat()
			}
		}
		//打开浮窗页面
		function openChat() {
			//debug(sessionwindowstyle)
			if (eConfig.isshow == 1) {
				var chat_width = "540px"
			} else {
				var chat_width = "360px"
			}
			if ($("#YSF-PANEL-INFO").length == 1) {
				if (isrefresh == 1) {
					//查这种情况的window.opener
					window.open(document.all.mihuaiframe.src, 'mihuaiframe', '')
					isrefresh = 0
				}
				$("#YSF-CUSTOM-ENTRY-0").hide();
				$("#YSF-PANEL-INFO").css("width", chat_width)
				setTimeout(function () {
					$("#YSF-PANEL-INFO").animate({ bottom: "-40px" }, 0.5)
				}, 500)
			} else if ($("#YSF-PANEL-INFO").length == 0) {
				// localStorage is domain based! We are facing 2 different domains here.
				//First we run inside user's domain but when the user opens the following windows
				//that window's localStorage domain is set back to us (as the url below sets)!
				var chat = $('<div id="YSF-PANEL-INFO"  class="ysf-chat-layer"  style="max-width:' + chat_width + ';width:' + chat_width + ';height: 600px;box-shadow: 0 0 20px 0 rgba(0, 0, 0, .15);position: fixed;bottom: -600px;right: 10px;transition: bottom 0.5s;">\
				  <div id="YSF-PANEL-INFO-DROP" style="width:inhert;height:20px;"></div>\
				<iframe id="YSF-PANEL-IFRAME" scrolling="no" name="mihuaiframe" src="'+ url + '/user/index.html?emickfEpid=' + localStorage.getItem("emickfEpid") + '" frameborder="0" style="width: 100%; height: 100%;"><style>.minimize{display: block!important;}</style></iframe>\
			</div>')	
				$('body').append(chat);
				$("#YSF-CUSTOM-ENTRY-0").hide();
				setTimeout(function () {
					$("#YSF-PANEL-INFO").animate({ bottom: "-40px" }, 0.5)
				}, 500)
			}
		}
		//打开模态窗页面
		function openModelChat() {
			//获得窗口的垂直位置 
			var iTop = (window.screen.availHeight - 30 - 800) / 2;
			var chat_width = 1080
			if (eConfig.isshow == 1) {
				//获得窗口的水平位置 
				var iLeft = (window.screen.availWidth - 10 - 1075) / 2;
			} else {
				//获得窗口的水平位置 
				var iLeft = (window.screen.availWidth - 10 - 825) / 2;
			}
			window.open(url + "/user/index.html?toggle=model&&emickfEpid=" + localStorage.getItem('emickfEpid'), "name=view_window', 'target=view_window", 'height=' + 800 + ',width=' + chat_width + ',top=' + iTop + ',left=' + iLeft + ',location=no');
		}

		//创建页签滚动
		function pageTitleScroll() {
			document.title = "您有一条新消息，请注意查看"
			if (msgTitle) {
				window.clearInterval(msgTitle)
			}
			msgTitle = setInterval(function () {
				var title = document.title;
				var firstch = title.charAt(0);
				var leftstar = title.substring(1, title.length);
				document.title = leftstar + firstch;
			}, 500)
		}
		//桌面提示对象
		var NotificationHandler = {
			//请求用户授权
			requestPermission: function () {
				Notification.requestPermission(function (status) {
					//default 用户没有接收或拒绝授权 不能显示通知  
					//granted 用户接受授权 允许显示通知  
					//denied  用户拒绝授权 不允许显示通知  
					debug('status: ' + status);
					isDeskProPermission = 1;
					debug("已经向用户询问桌面提示授权");
				});
			},
			showNotification: function (msgObj) {
				if (msgObj.icon == "img/eplogo.png") {
					msgObj.icon = "user/img/eplogo.png"
				}
				// 截取字符串，控制飘窗的内容一行显示
				if (msgObj.type == "text") {
					var msg = msgObj.msg.replace(/<img [^>]*>/gi, "[表情]").replace(/\&nbsp/g, ' ')
					var body
					if (msg.length > 15) {
						body = msgObj.name + " : " + msg.substring(0, 15) + "..."
					} else {
						body = msgObj.name + " : " + msg
					}
				} else if (msgObj.type == "image") {
					var body = msgObj.name + " : [图片]"
				}
				var DesktopPrompt = new Notification("您有一条新消息，请注意查看", {
					icon: url + msgObj.icon,
					body: body
				});
				//onshow函数在消息框显示时会被调用  
				//可以做一些数据记录及定时操作等 
				DesktopPrompt.onshow = function () {
					debug('显示桌面通知');
					//10秒后关闭消息框  
					setTimeout(function () {
						DesktopPrompt.close();
					}, 10000);
				};
				//消息框被点击时被调用  
				//可以打开相关的视图，同时关闭该消息框等操作  
				DesktopPrompt.onclick = function () {
					$window.focus();
					//opening the view...  
					DesktopPrompt.close();
				};
				//当有错误发生时会onerror函数会被调用  
				//如果没有granted授权，创建Notification对象实例时，也会执行onerror函数  
				DesktopPrompt.onerror = function () {
					debug('调用桌面通知时遇到错误');
					//do something useful  
				};

				//一个消息框关闭时onclose函数会被调用  
				DesktopPrompt.onclose = function () {
					debug('关闭桌面通知');
					//do something useful  
				};
			}
		};

		function adjustADWidth(ad) {
			if (ad == eConfig.isshow) return
			if (ad == 1) {
				eConfig.isshow = 1
				$("#YSF-PANEL-INFO").css("width", "540px")
			} else {
				eConfig.isshow = 0
				$("#YSF-PANEL-INFO").css("width", "360px")
			}
		}
	}
})()