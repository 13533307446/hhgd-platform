var util = require('./utils/util.js');
var api = require('./config/api.js');
var user = require('./services/user.js');
var wxApi = require('./utils/wxApi.js');

App({
  onLaunch: function() {
    console.log("onlaunch")
    let that=this;
    //获取用户的登录信息   
    user.checkSession().then(function ok(res) {
      console.log('checkSession return  true')
      },function  fail(error)  {
        console.log(error)
        console.log('checkSession  return  false')
        wx.redirectTo({
          url: '/pages/auth/wxLogin/wxLogin',
        })
      }
    ).catch(() => {
      console.log('checkSession  error')
    });
  },
  globalData: {
    userInfo: {
      nickName: 'Hi,游客',
      userName: '点击去登录',
      avatarUrl: 'http://imgph.kumanju.com/20180802/1153433158bb1f.png'
    },
    token: ''
  }
})