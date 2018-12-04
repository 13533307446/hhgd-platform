var util = require('../../../utils/util.js');
var api = require('../../../config/api.js');
let str = /^(((13[0-9]{1})|(14[579]{1})|(15[0-3,5-9]{1})|(16[6])|(17[0135678]{1})|(18[0-9]{1})|(19[89]))+\d{8})$/;//手机号码验证


var app = getApp();

Page({
  data: {
    array: ['请选择反馈类型', '商品相关', '物流状况', '客户服务', '优惠活动', '功能异常', '产品建议', '其他'],
    index: 0,
    content:'',
    contentLength:0,
    mobile:''
  },
  bindPickerChange: function (e) {
    console.log('picker发送选择改变，携带值为', e.detail.value);
    this.setData({
      index: e.detail.value
    });
  },
  onShareAppMessage: function () {
    return util.shareAppMessage();
  },
  mobileInput: function (e) {
    let that = this;
    this.setData({
      mobile: e.detail.value,
    });
    if (e.detail.value.length == 11 && !str.test(e.detail.value)) {
      util.showNoIconErrorToast('请输入正确的手机号码');
      return;
    }
    console.log(that.data.mobile);
  },
  contentInput: function (e) {
   
    let that = this;
    this.setData({
      contentLength: e.detail.cursor,
      content: e.detail.value,
    });
    console.log(that.data.content);
  },
  cleanMobile:function(){
    let that = this;

  },
  sbmitFeedback : function(e){
    let that = this;
    if (that.data.index == 0){
      util.showNoIconErrorToast('请选择反馈类型');
      return false;
    }

    if (that.data.content == '') {
      util.showNoIconErrorToast('请输入反馈内容');
      return false;
    }

    if (that.data.mobile == '' || that.data.mobile.length < 11) {
      util.showNoIconErrorToast('请输入正确的手机号码');
      return false;
    }

    if (that.data.mobile.length == 11 && !str.test(that.data.mobile)) {
      util.showNoIconErrorToast('请输入正确的手机号码');
      return false;
    }

    wx.showLoading({
      title: '提交中...',
      mask:true,
      success: function () {

      }
    });

    console.log(that.data);

    util.request(api.FeedbackAdd, { mobile: that.data.mobile, index: that.data.index, content: that.data.content},'POST').then(function (res) {
      if (res.errno === 0) {
        console.log(res.data);
      
        wx.hideLoading();

        wx.showToast({
          title: res.data,
          icon: 'success',
          duration: 2000,
          complete: function () {
            console.log('重新加载');
            that.setData({
              index: 0,
              content: '',
              contentLength: 0,
              mobile: ''
            });
          }
        });
      } else {
        util.showNoIconErrorToast(res.data);
      }
      
    });
  },
  onLoad: function (options) {
  },
  onReady: function () {

  },
  onShow: function () {

  },
  onHide: function () {
    // 页面隐藏

  },
  onUnload: function () {
    // 页面关闭
  }
})