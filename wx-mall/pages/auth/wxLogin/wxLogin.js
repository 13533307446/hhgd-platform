var util = require('../../../utils/util.js');
var api = require('../../../config/api.js');
var user = require('../../../services/user.js');
var wxRequest = require('../../../utils/wxRequest.js');
let app = getApp();
Page({
  data: {
    title:"酷漫居好妈优选",

  },
  onLoad: function (options) {
    // 页面初始化 options为页面跳转所带来的参数

  },
  confirmLogin: function(e)  {
    console.log('confirm login ')
    this.setData({
      disabled: !this.data.disabled
    })
    wx.showLoading({
      title: '加载中...',
    })
  },

  onGotUserInfo: function (e) {
    console.log(e.detail.errMsg);
    console.log(e);
    console.log(e.detail.rawData);
    console.log(e.detail.encryptedData);
    console.log(e.detail.iv);
    //wx.setStorageSync('userInfo', e.detail.userInfo);
    //app.globalData.userInfo = wx.getStorageInfoSync('userInfo')
    
    
    let code = null
    user.login().then((res) => {
      console.log('call  user.login success')
      code = res.code
      return e.detail
    })
    .then(fullUserInfo => {
        console.log('call  getUserInfo success')
        return wxRequest.request(api.AuthLoginByWeixinV2, {
          code: code,
          userInfo: fullUserInfo
        }, 'POST')
      })
      .then((res) => {
        console.log(JSON.stringify('res===='+res))
        var  resData =  res.data;
        if (resData.errno === 0) {
          //存储用户信息
          console.log(resData)
          
          console.log("get response token=" + resData.data.token);

          wx.setStorageSync('userInfo', resData.data.userInfo);
          getApp().globalData.userInfo = resData.data.userInfo;

          wx.setStorageSync('token', resData.data.token);
          getApp().globalData.token = resData.data.token;

          console.log("token=" + resData.data.token);
           //按下按钮时显示loading画面，返回后取消画面
          wx.hideLoading()
          wx.switchTab({ url: '../../../pages/index/index' })
        } else {
          // reject(res);
          console.log(JSON.stringify(resData))
          console.log("onGotUserInfo  error")
        }
      })
  },
  onReady: function () {

  },
  onShow: function () {
    // 页面显示

  },
  onHide: function () {
    // 页面隐藏

  },
  onUnload: function () {
    // 页面关闭

  }
})




