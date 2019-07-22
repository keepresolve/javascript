
function A_Emoji($box,fn){
	var _box = $box;
	
	
//	this.init = function(fn){//参数为点击发送之后执行的函数
		var html = '';
		html += '<div class="InputBox">';
		html += '<div class="input">';     
		html += '<div contenteditable="true" class="text"></div>';                      
		html += '<div class="btnGroup">';
//		html += '<button data="emoji" class="btn" style="bottom: 0;right: 30px;">表情</button>';
		html += '<div data="emoji" class="btn" style="left:0"><img src="img/biaoqing.png"/></div>'
//		html += '<button data="confirm" class="btn" style="bottom: 0;right: 0px;">确定</button>';
		html += '<div data="confirm" class="btn" style="right:8px"><img src="img/huiche.png"/></div>'
		html += '</div>';       
		html += '</div>'; 
		html += '<div class="emojiBox">';
		html += '<section class="emoji_container">';
		html += '</section>';
		html += '</div>';    
		html += '</div>';		
		
		_box.append($(html));
//	}
	
	
	
	
	
	var defaults = {
		emojiconfig: {
			tieba: {
				name: "贴吧表情",
				path: "img/tieba/",
				maxNum: 50,
				file: ".jpg",
				placeholder: ":{alias}:",
				alias: {
					1: "hehe",
					2: "haha",
					3: "tushe",
					4: "a",
					5: "ku",
					6: "lu",
					7: "kaixin",
					8: "han",
					9: "lei",
					10: "heixian",
					11: "bishi",
					12: "bugaoxing",
					13: "zhenbang",
					14: "qian",
					15: "yiwen",
					16: "yinxian",
					17: "tu",
					18: "yi",
					19: "weiqu",
					20: "huaxin",
					21: "hu",
					22: "xiaonian",
					23: "neng",
					24: "taikaixin",
					25: "huaji",
					26: "mianqiang",
					27: "kuanghan",
					28: "guai",
					29: "shuijiao",
					30: "jinku",
					31: "shengqi",
					32: "jinya",
					33: "pen",
					34: "aixin",
					35: "xinsui",
					36: "meigui",
					37: "liwu",
					38: "caihong",
					39: "xxyl",
					40: "taiyang",
					41: "qianbi",
					42: "dnegpao",
					43: "chabei",
					44: "dangao",
					45: "yinyue",
					46: "haha2",
					47: "shenli",
					48: "damuzhi",
					49: "ruo",
					50: "OK"
				},
				title: {
					1: "呵呵",
					2: "哈哈",
					3: "吐舌",
					4: "啊",
					5: "酷",
					6: "怒",
					7: "开心",
					8: "汗",
					9: "泪",
					10: "黑线",
					11: "鄙视",
					12: "不高兴",
					13: "真棒",
					14: "钱",
					15: "疑问",
					16: "阴脸",
					17: "吐",
					18: "咦",
					19: "委屈",
					20: "花心",
					21: "呼~",
					22: "笑脸",
					23: "冷",
					24: "太开心",
					25: "滑稽",
					26: "勉强",
					27: "狂汗",
					28: "乖",
					29: "睡觉",
					30: "惊哭",
					31: "生气",
					32: "惊讶",
					33: "喷",
					34: "爱心",
					35: "心碎",
					36: "玫瑰",
					37: "礼物",
					38: "彩虹",
					39: "星星月亮",
					40: "太阳",
					41: "钱币",
					42: "灯泡",
					43: "茶杯",
					44: "蛋糕",
					45: "音乐",
					46: "haha",
					47: "胜利",
					48: "大拇指",
					49: "弱",
					50: "OK"
				}
			}
			//, AcFun: {
			// 	name: "AcFun表情",
			// 	path: "img/AcFun/",
			// 	maxNum: 54,
			// 	file: ".png"
			// }
		},
//		postFunction: function() {
//			alert(InputText.html());
//			console.log(InputText.html());
//		}
	};
		
	var _emojiBox = _box.find('.emojiBox');
//	var opts = $.extend(defaults, options);
	var emojiconfig = defaults.emojiconfig;
//	var plBox = $(this);
//	var InputBox = plBox.find('.Input_Box');
//	var faceDiv = plBox.find('.faceDiv');
	var InputText = _box.find('.text');
	var emojiBox = _box.find('.emojiBox');
//		var imgBtn = InputFoot.find('.imgBtn');
	var imgBtn = _box.find('[data="emoji"]');
//	console.log('box',_box);
//	console.log('imgBtn',imgBtn);
	imgBtn.click(
		function() {
			var emojiContainer = _emojiBox.find('.emoji_container');
			if (emojiContainer.children().length <= 0) {
				_emojiBox.css({
//						width: Math.floor(InputText.width() / 30) * 30 + 'px',
					display: 'block'
				});
				for (var emojilist in emojiconfig) {
					emojiContainer.append('<section class="for_' + emojilist + '"></section>');
//						faceDiv.find('.emoji_tab').append('<a href="#!" data-target="for_' + emojilist + '">' + emojiconfig[emojilist].name + '</a>');
					for (var i = 1; i <= emojiconfig[emojilist].maxNum; i++) {
						if (emojiContainer.find('.for_' + emojilist) !== undefined) {
							emojiContainer.find('.for_' + emojilist).append('<a href="#!" class="_img"><img src="' + emojiconfig[emojilist].path + i + emojiconfig[emojilist].file + '" alt="" data-alias="'+(emojiconfig[emojilist].alias == undefined ? (i+emojiconfig[emojilist].file) : emojiconfig[emojilist].alias[i])+'" title="' + (emojiconfig[emojilist].title == undefined ? '' : emojiconfig[emojilist].title[i]) + '" /></a>');
						}
					}
				}
				_emojiBox.find('.emoji_container section')[0].style.display = 'block';
//					faceDiv.find('.emoji_tab a')[0].className += 'active';
				_emojiBox.find('.emoji_container ._img').on('click', function() {
					if (InputText[0].nodeName === 'DIV') {
						InputText.append(this.innerHTML);
					} else {
						InputText.append('[' + $(this).find('img').attr('data-alias')+']');
					}

				});

			} else {
				_emojiBox.toggle();
			}
		}
	);

	_box.find('[data="confirm"]').on('click', function(){
//			alert(InputText.html());
//		$('#display').empty();
//		$('#display').html(InputText.html());
		addRow({detail:InputText.html()});
		if(fn){fn();}
		
	});
	
	$(document).on('click', function(e) {
		if ((_emojiBox.find($(e.target)).length) <= 0 && (_box.find($(e.target)).length <= 0)) {
			_emojiBox.hide();
		}
	});
		
}




function addRow(o){
	var html = '';
	html += '<div class="li">';
	html += '<div class="icon">';
	html += '<img src="img/AcFun/1.png"/>';
	html += '</div>';
	html += '<div class="content">';
	html += '<div class="name">';
	html += 'adrian';
	html += '</div>';
	html += '<div class="time">';
	html += '一小时前';
	html += '</div>';
	html += '<div class="text">';
	html += 'UISDGUIGV我就偶尔开发票【qweko-fqwekoifhwejhfiwejfo就我破防奇偶未交卡佛尔';
	html += '</div>';
	html += '</div>';
	html += '</div>';
	
	$('.commentBox').append($(html));
}




	function addRow(o){
		console.log();
		var html = '';
		html += '<div class="li">';
		html += '<div class="icon">';
		html += '<img src="';
		html += 'img/AcFun/1.png';
//		html += o.photo;
		html += '"/>';
		html += '</div>';
		html += '<div class="content">';
		html += '<div class="name">';
		html += 'adrian';
//		html += o.username;
		html += '</div>';
		html += '<div class="time">';
		html += '一小时前';
//		html += o.dateline;
		html += '</div>';
		html += '<div class="text">';
//		html += 'UISDGUIGV我就偶尔开发票【qweko-fqwekoifhwejhfiwejfo就我破防奇偶未交卡佛尔';
		html += o.detail;
		html += '</div>';
		html += '</div>';
		html += '</div>';
		
		
		var li = $(html);
		console.log(o.detail);
//		li.find('.text').html(o.detail);
		$('.commentBox').append(li);
	}