/**
 * 用户相关服务
 */

const util = require('../utils/util.js');
const api = require('../config/api.js');
const wxApi = require('../utils/wxApi.js');
let app = getApp();

/**
 * 调用微信登录
 */
function loginByWeixin() {

  let code = null;
  return new Promise(function (resolve, reject) {
    return wx.login().then((res) => {
      code = res.code;
      return wx.getUserInfo();
    }).then((userInfo) => {
      //登录远程服务器
      /*
      util.request(api.AuthLoginByWeixin, { code: code, userInfo: userInfo }, 'POST').then(res => {
        if (res.errno === 0) {
          //存储用户信息
          wx.setStorageSync('userInfo', res.data.userInfo);
          wx.setStorageSync('token', res.data.token);

          resolve(res);
        } else {
          reject(res);
        }
      }).catch((err) => {
        reject(err);
      });
      */

      wx.setStorageSync('userInfo', { weixin_openid: "o9nEe0dE37H7pFnCdSGgcX3TrFpc"});
      wx.setStorageSync('token',"abcd");
    }).catch((err) => {
      reject(err);
    })
  });
}

/**
 * 判断用户是否登录
 */
function checkSession() {
  return new Promise(function (resolve, reject) {
    if (wx.getStorageSync('userInfo') && wx.getStorageSync('token')) {
      wxApi.wxCheckSession().then(() => {
        resolve(true);
      }).catch(() => {
        reject(false);
      });
    } else {
      reject(false);
    }
  });
}

/**
 * 调用微信登录  必须在授权之后进行
 */

function login() {
  return new Promise(function (resolve, reject) {
    wx.login({
      success: function (res) {
        if (res.code) {
          //登录远程服务器
          console.log(res)
          resolve(res);
        } else {
          reject(res);
        }
      },
      fail: function (err) {
        reject(err);
      }
    });
  });
}

// function getUserInfo() {
//   return new Promise(function (resolve, reject) {
//     wx.getUserInfo({
//       withCredentials: true,
//       success: function (res) {
//         console.log(res)
//         resolve(res);
//       },
//       fail: function (err) {
//         reject(err);
//       }
//     })
//   });
// }




module.exports = {
  loginByWeixin,
  checkSession,
  login,
  // getUserInfo,
};











