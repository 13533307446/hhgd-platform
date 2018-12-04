var util = require('../../../utils/util.js');
var api = require('../../../config/api.js');
const pay = require('../../../services/pay.js');
var app = getApp();
Page({
  data: {
    checkedGoodsList: [],
    checkedAddress: {},
    checkedCoupon: [],
    couponList: [],
    goodsTotalPrice: 0.00, //商品总价
    freightPrice: 0.00,    //快递费
    couponPrice: 0.00,     //优惠券的价格
    orderTotalPrice: 0.00,  //订单总价
    actualPrice: 0.00,     //实际需要支付的总价
    addressId: 0,
    couponId: 0,
    orderRemark:"",
    toPayDisabled:false
  },
  onShareAppMessage: function () {
    return util.shareAppMessage();
  },
  onLoad: function (options) {
    // 页面初始化 options为页面跳转所带来的参数
    try {
      var addressId = wx.getStorageSync('addressId');
      console.log("get addressid  from  storage="+addressId);
      if (addressId) {
        this.setData({
          'addressId': addressId
        });
      }

      var couponId = wx.getStorageSync('couponId');
      if (couponId) {
        this.setData({
          'couponId': couponId
        });
      }
    } catch (e) {
      // Do something when catch error
    }


  },
  getCheckoutInfo: function () {
    let that = this;

    let selectedAdrress = wx.getStorageSync('selectedAdrress');
    let currentAddress = null;
    if(selectedAdrress.id)  {
      currentAddress = selectedAdrress;
    }
    // addressId: that.data.addressId,
    util.request(api.CartCheckout, {  couponId: that.data.couponId }).then(function (res) {
      if (res.errno === 0) {
        console.log(res.data);
        let tmpAddressId = -1;
        if (currentAddress) {
          tmpAddressId = currentAddress.id;
        }
        that.setData({
          checkedGoodsList: res.data.checkedGoodsList,
          addressId: tmpAddressId ||  res.data.checkedAddress.id,
          checkedAddress: currentAddress ||  res.data.checkedAddress,
          actualPrice: res.data.actualPrice,
          checkedCoupon: res.data.checkedCoupon,
          couponList: res.data.couponList,
          couponPrice: res.data.couponPrice,
          freightPrice: res.data.freightPrice,
          goodsTotalPrice: res.data.goodsTotalPrice,
          orderTotalPrice: res.data.orderTotalPrice
        });
      }
      wx.hideLoading();
    });
  },
  selectAddress() {
    wx.navigateTo({
      url: '/pages/shopping/address/address',
    })
  },
  addAddress() {
    wx.navigateTo({
      url: '/pages/shopping/addressAdd/addressAdd',
    })
  },
  onReady: function () {
    // 页面渲染完成

  },
  onShow: function () {
    // 页面显示
    wx.showLoading({
      title: '加载中...',
    })
    this.getCheckoutInfo();

  },
  onHide: function () {
    // 页面隐藏

  },
  onUnload: function () {
    // 页面关闭

  },
  orderComment:function(e){
    this.setData({
      orderRemark: e.detail.value
    })
  },
  submitOrder: function () {
    let  that =   this;
    if (that.data.checkedAddress.id <= 0) {
      util.showErrorToast('请选择收货地址');
      return false;
    }
    that.setData({
      toPayDisabled: true
    })
    wx.showLoading({
      title: '加载中...',
      mask: true,
      success: function (res) {
        if (res.errMsg) {
          util.showLoading('加载中...', 'true', function () {
            util.request(api.OrderSubmit, { addressId: that.data.checkedAddress.id, couponId: that.data.couponId, postscript: that.data.orderRemark }, 'POST').then(res => {
              if (res.errno === 0) {
                try {
                  wx.removeStorageSync('selectedAdrress');
                  wx.removeStorageSync('addressId');
                } catch (error) {
                  console.log(error)
                }
                const orderId = res.data.orderInfo.id;
                pay.payOrder(parseInt(orderId)).then(res => {
                  wx.redirectTo({
                    url: '/pages/payResult/payResult?status=1&orderId=' + orderId,
                    success:function(){
                      that.setData({
                        toPayDisabled: false
                      })
                    }
                  });
                }).catch(res => {
                  wx.redirectTo({
                    url: '/pages/payResult/payResult?status=0&orderId=' + orderId,
                    success: function () {
                      that.setData({
                        toPayDisabled: false
                      })
                    }
                  });
                });
                wx.hideLoading();
              } else {
                util.showErrorToast('下单失败');
              }
            });
          })
        }
      }
    })
  }
})