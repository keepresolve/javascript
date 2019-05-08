(function($){
	$.tip = function(text){
        var panel = $("<div style='width:296px!important;height:50px;position:fixed;top:66%;left:33px;text-align:center;width:100%;z-index:10002;'>"
                +"<span style='border-radius:6px;background:rgba(0,0,0,0.7);color:#FFFFFF;padding:17px 35px;font-size:12px;'>"+text+"</span>"
                +"</div>").appendTo(document.body);
        setTimeout(function(){
            panel.fadeOut(800,function(){
                panel.remove();
            });
        },3000);
    };
    $.fn.scrollToBottom = function(){
        var nScrollHight = this[0].scrollHeight;
        if(nScrollHight > 0){
            this[0].scrollTop = nScrollHight;
        }
    };
    $.form = {
        isID:function(str){
            str = str.toUpperCase();
            //身份证号码为18位,18位前17位为数字，最后一位是校验位，可能为数字或字符X。
            if (!(/(^\d{17}([0-9]|X)$)/.test(str)))
            {
                return false;
            }
            else
                return true;
        },
        isQQ : function(str){
            if(str.search(/^[1-9]\d{4,8}$/) !=-1){ 
                return true;
            } 
            if(str.length == 0){
                return true;  
            }
            else
                return false;
        },
        isTel : function(str){
             return (/^(([0\+]\d{2,3})?(0\d{2,3}))(\d{7,8})((\d{3,}))?$/.test(str)); 
        },
        hasBlank : function(str) {
            return str.indexOf(" ") == -1?true:false;
        },
        delBlank : function(str) {
            return str.replace(/(^\s+)|(\s+$)/g, "");
        },
        //密码校验
        isSame : function(str1,str2){
            return str1 === str2?true:false; 
        },
        // 是否为空
        isEmpty : function(str){
            /*if(!str && str !== 0) return true;
            if(str.replace(/(^s*)|(s*$)/g, "").length ==0) return true;
            return fals*/
            if(!str) return false;
            return str.length == 0?false:true;
        },
        // email是否正确
        isEmail : function(str){
            if(/^[A-Za-z\d]+([-_\.][A-Za-z\d]+)*@([A-Za-z\d]+[-\.])+[A-Za-z\d]{2,5}$/.test(str)){
                return true;
            }
            else{
                return false;
            }
        },
        // 手机验证
        isPhone : function(str){
            var reg = /^1\d{10}$/;
            if (reg.test(str)) {
                return true;
            }
            /*if(str.length == 0){
                return true;  
            }*/
            return false;
            
        },//手机号码验证
        isAdmin : function(str){
            var reg = /^[\u4e00-\u9fa5A-Za-z0-9-_]*$/;
            return reg.test(str)?true : false;
        }//用户名验证，只能中英文，数字，下划线，减号
    }
})(jQuery);