// pages/orderStatus/orderStatus.js
let util=require("../../utils/util.js");
let api=require("../../config/api.js");
Page({

  /**
   * 页面的初始数据
   */
  data: {
    orderStatus:[],
    orderQueryList:{
      orderId: '',
      logisticsNum:'',
      shippingTime:'',
      shippingName:''
    }
    
  },
  onShareAppMessage: function () {
    return util.shareAppMessage();
  },
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    let orderStatus = JSON.parse(options.orderStatus);
    this.setData({
      "orderQueryList.logisticsNum": orderStatus.shippingNum == null ? '' :orderStatus.shippingNum,
      "orderQueryList.shippingTime": orderStatus.shippingTime == null ? '' :orderStatus.shippingTime,
      "orderQueryList.shippingName": orderStatus.shippingName == null ? '' :orderStatus.shippingName,
      "orderQueryList.orderId": orderStatus.orderId
    })
    this.queryList();
  },
  queryList:function(){
    let that=this;
    util.request(api.OrderQuerylist, {
      orderId: that.data.orderQueryList.orderId
    }).then(function (res) {
      if (res.errno === 0) {
        that.setData({
          orderStatus: res.data.orderProcess
        });
      }
    });
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
  
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
  
  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {
  
  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {
  
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {
  
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
  
  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {
  
  }
})