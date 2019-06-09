// 首字母排序
export default function pySort(arrList,empty) {
    // var self = this;
    if(!String.prototype.localeCompare) return null

    var letters ="ABCDEFGHIJKLMNOPQRSTUVWXYZ#".split('');
    // self.letters = letters;

    var zh ="啊把测大额发噶哈*级卡啦吗那哦爬器然撒他**瓦西呀咋".split('');     //*占位没有i,u,v拼音开头的汉字

    var result = []
    var curr

    letters.map((i,i_index) => {
        curr = {letter: i, data:[]}
        if(i_index!=26) {
            arrList.map(j => {
                var initial = j.label.charAt(0)     //截取第一个字符
                if(initial.toLowerCase() == i.toLowerCase()) {   //首字符是英文的
                    curr.data.push(j)
                }else if(zh[i_index]!='*' && isChinese(initial)) {
                    //判断是否是无汉字,是否是中文
                    if (initial.localeCompare(zh[i_index]) >= 0) {
                        //判断中文字符在哪一个类别
                        if(!zh[i_index + 1]) {
                            curr.data.push(j)
                        }else {
                            if(zh[i_index + 1] == '*') {
                                if(zh[i_index + 2] == '*') {
                                    if(initial.localeCompare(zh[i_index + 3]) < 0) {
                                        curr.data.push(j)
                                    }
                                }else {
                                    if(initial.localeCompare(zh[i_index + 2]) < 0) {
                                        curr.data.push(j)
                                    }
                                }
                            }else {
                                if(initial.localeCompare(zh[i_index + 1]) < 0) {
                                    curr.data.push(j)
                                }
                            }
                        }
                    }
                }
            })
        }else {
            arrList.map(k => {
                var ini = k.label.charAt(0)           //截取第一个字符
                if(!isChar(ini) && !isChinese(ini)){
                    curr.data.push(k)
                }
            })
        }

        if(empty || curr.data.length) {
            result.push(curr);
            curr.data.sort(function(a,b){
                return a.label.localeCompare(b.label);       //排序,英文排序,汉字排在英文后面 (有问题)
            })
        }

    })

    return result


}

function isChinese(temp) {
        var re=/[^\u4E00-\u9FA5]/;
        if (re.test(temp)){return false  }
        return true 
}

function isChar(char) {
    var reg = /[A-Za-z]/;
    if (!reg.test(char)){ return false }
    return true         
}