var util = require('../../../utils/util.js');
var api = require('../../../config/api.js');

Page({
  data:{
    orderList: [],
    countSum:0,
    pageNum:1,
    windowHeight:0
  },
  onShareAppMessage: function () {
    return util.shareAppMessage();
  },
  onLoad:function(options){
    // 页面初始化 options为页面跳转所带来的参数
  },
  getOrderList(page){
    let that = this;
    let orderLists=[];
    if (page > 1) { orderLists = that.data.orderList}
    wx.showLoading({
      title: '加载中...'
    });
    util.request(api.OrderList, { page: page}).then(function (res) {
      if (res.errno === 0) {
        for (let i = 0; i < res.data.data.length;i++){
          orderLists.push(res.data.data[i])
        }
        that.setData({
          countSum:res.data.count,
          orderList: orderLists,
          pageNum: res.data.currentPage + 1
        });
        wx.hideLoading();
      }
    });
  },
  payOrder:function(e){
    let orderInfo = e.currentTarget.dataset;
    wx.navigateTo({
      url: '../../pay/pay?orderId=' + orderInfo.orderId + '&actualPrice=' + orderInfo.orderPrice,
    })
  },
  onReady:function(){
    let that=this;
    // 页面渲染完成
    wx.getSystemInfo({
      success: function(res) {
        that.setData({
          windowHeight: res.windowHeight
        })
      },
    })
  },
  onShow:function(){
    // 页面显示
    this.getOrderList(1);
  },
  onHide:function(){
    // 页面隐藏
  },
  onUnload:function(){
    // 页面关闭
  },
  loadMore:function(e){
    if (this.data.orderList.length < this.data.countSum){
      this.getOrderList(this.data.pageNum);
    }
  }
})