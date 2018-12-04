var api = require('../config/api.js');
var wxRequest = require('wxRequest.js');
var wxApi = require('wxApi.js');


/**
 * 封装微信的的request
 */
function request(url, data = {}, method = "GET") {
  return new Promise(function(resolve, reject) {
    wxRequest.request(url, data, method)
      .then((res) => {
       // console.log(JSON.stringify(res))
        if (res.statusCode == 200) {
          if (res.data.errno == 401) {
            console.log("server  return  401")
            //TODO
            redirect('/pages/auth/wxLogin/wxLogin')
           /*
            let code = null
            return login().then((res) => {
             
                console.log('call  wxApi.wxLogin success')
             
                code = res.code
                return getUserInfo()
              })
              .then(userInfo => {
                console.log('call  getUserInfo success')
                request(api.AuthLoginByWeixin, {
                  code: code,
                  userInfo: userInfo
                }, 'POST')
              })
              .then(res => {
                if (res.errno === 0) {
                  //存储用户信息
                  console.log("get response token=" + res.data.token);
                  wx.setStorageSync('userInfo', res.data.userInfo);
                  wx.setStorageSync('token', res.data.token);
                  return resolve(res);
                } else {
                  reject(res);
                }
              })
              */
          } else {
            resolve(res.data);
            console.log("server  return !=  401")
          }
        }
      })
  });
}

function redirect(url) {
  //判断页面是否需要登录
  if (false) {
    wx.redirectTo({
      url: '/pages/auth/login/login'
    });
    return false;
  } else {
    console.log("redirect to called")
    wx.redirectTo({
      url: url
    });
  }
}

function showErrorToast(msg) {
  wx.showToast({
    title: msg,
    image: '/static/images/icon_error.png'
  })
}

function showNoIconErrorToast(msg) {
  wx.showToast({
    title: msg,
    icon: 'none',
    mask: true
  })
}

function shareAppMessage(){
  return {
    path: '/pages/index/index',
    imageUrl:'/static/images/share_img.jpg'
  }
}

function showLoading(title,mask,success){
  wx.showLoading({
    title: title,
    mask: mask,
    success:success
  })
}

function formatTime(date) {
  var year = date.getFullYear()
  var month = date.getMonth() + 1
  var day = date.getDate()

  var hour = date.getHours()
  var minute = date.getMinutes()
  var second = date.getSeconds()


  return [year, month, day].map(formatNumber).join('-') + ' ' + [hour, minute, second].map(formatNumber).join(':')
}

function formatNumber(n) {
  n = n.toString()
  return n[1] ? n : '0' + n
}
function printJson(obj) {
  console.log(JSON.stringify(obj))
}
module.exports = {
  formatTime,
  request,
  redirect,
  showErrorToast,
  printJson,
  showNoIconErrorToast,
  shareAppMessage,
  showLoading
}