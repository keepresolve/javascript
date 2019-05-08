import axios from 'axios'
import { Message, MessageBox } from 'element-ui'
import { randomString } from '@/util/randomString'
import { errCode } from '@/util/errCode'

let requestArr = new Map([])
let pedding = new Promise(() => {})  /* do nothing, pending forever*/
let axiosBase=axios.create({baseURL:config.base})
let request = (option)=> axiosBase(option)
let mBoxIsShow = false
let dalay = 300 //300ms不能重复请求
window.requestArr = requestArr
axios.defaults.withCredentials = true

// axios.defaults.timeout = 5000;

// 响应异常处理
axios.interceptors.response.use(
    response => {
        if(ReqInterceptor(response)) return pedding
        return response
    },
    err => {
        console.error(`请求出错接口${err.config.url}`, err.message)
        err.data = {
            //后台返回数据可能通用2层data
            code: 9999,
            info: '网络出错'
        }
        return err
    }
)
/**
 * get/delete 请求
 * @param method 默认为 get
 * @param url
 * @param param
 * @param headerObj
 * @returns {Promise}
 */
// 300ms 可能不会触发渲染
//只是走第一次的请求 存在一个问题就是如果在delay 时间段中重复请求 比如loading 设置为true 响应后false  重复点击响应一次loading永远为true
export const gdRequest = (method, url, param, headerObj) => {
    // url = `${config.base}${url}`
    let key = JSON.stringify({
        method,
        url,
        param
    }).toLowerCase()
    let option = {
        method: method || 'GET',
        url,
        data: param,
        params: param,
        headers: headerObj || {
            source: 'client.web',
            token: sessionStorage.getItem('user-token'),
            nonce: randomString(32)
        }
    }
    let result = requestArr.has(key) ? pedding : request(option)
    if (requestArr.has(key)) clearTimeout(requestArr.get(key))
    let timer = setTimeout(() => requestArr.delete(key), dalay)
    requestArr.set(key, timer)
    return result
}

async function is_update_menu() {
    // 获取用户列表
    let res = await gdRequest('GET', '/user/details')
    if (res.data.code == 200) {
        let result
        let is_avalil_role
        let is_avalil_ep

        if (res.data.data.data_access_level == 1) {
            // 超级企业管理员 or 超级企业角色
            if (res.data.data.roles.length) {
                is_avalil_role = res.data.data.roles.find(v => {
                    return v.disabled == 0
                })
            }
            result =
                res.data.data.roles.length &&
                is_avalil_role != undefined &&
                res.data.data.super_enterprise.enterprise_count.opened
        } else {
            // 企业管理员 or 普通用户
            if (res.data.data.enterprises.length) {
                is_avalil_ep = res.data.data.enterprises.find(v => {
                    return v.status == 1
                })
            }
            result =
                res.data.data.roles.length &&
                res.data.data.enterprises.length &&
                is_avalil_ep != undefined
        }
        return result
    } else {
        return false
    }
}

function getMenu() {
    //获取侧栏菜单列表
    gdRequest('GET', '/menu').then(res => {
        if (res.data.code == 200) {
            let array = res.data.data
            let newArray = []
            for (let value of array) {
                if (value.children.length == 0) {
                    let obj = {
                        path: '/',
                        name: '',
                        iconCls: value.icon,
                        children: [
                            {
                                path: value.frontend_route,
                                name: value.menu_name
                            }
                        ]
                    }
                    newArray.push(obj)
                } else if (value.children.length > 0) {
                    var obj1 = {
                        path: '/',
                        name: value.menu_name,
                        iconCls: value.icon,
                        children: []
                    }
                    newArray.push(obj1)
                    for (let value1 of value.children) {
                        obj1.children.push({
                            path: value1.frontend_route,
                            name: value1.menu_name
                        })
                    }
                }
            }
            sessionStorage.setItem('menu', JSON.stringify(newArray))
            // 页面刷新
            router.go(0)
        }
    })
}

function ReqInterceptor(response) {
    if (
        (Object.keys(errCode).indexOf(response.data.code.toString()) > -1 &&
            sessionStorage.getItem('systemType') != 0 &&
            router.currentRoute.fullPath != '/login') ||
        (response.data.code == 12000008 &&
            sessionStorage.getItem('systemType') == 0)
    ) {
        if (mBoxIsShow) return true
        mBoxIsShow = true
        if (response.data.code == 12000008) {
            Message.error(response.data.info)
            sessionStorage.clear()
            // 记录当前路由
            // 重新登录后跳转至该路由界面，若不存在则默认回到有权限的首个页面
            sessionStorage.setItem('currentPath', router.currentRoute.fullPath)
            router.push('/login')
            mBoxIsShow = false
        } else {
            let msg = errCode[response.data.code]
            MessageBox.confirm(msg, '提示', {
                showCancelButton: false,
                showClose: false,
                closeOnClickModal: false,
                closeOnPressEscape: false,
                confirmButtonText: '确定',
                type: 'warning'
            }).then(async () => {
                mBoxIsShow = false
                if (response.data.code == 12010010) {
                    let is_update = await is_update_menu()
                    if (is_update) {
                        getMenu()
                    } else {
                        sessionStorage.clear()
                        router.push('/login')
                    }
                } else {
                    sessionStorage.clear()
                    router.push('/login')
                }
            })
        }
        return true
    }
    return false
}
