var util = require('../../utils/util.js');
var api = require('../../config/api.js');
var app = getApp();
Page({
  data: {
    cartGoods: [],
    cartTotal: {
      "goodsCount": 0,
      "goodsAmount": 0.00,
      "checkedGoodsCount": 0,
      "checkedGoodsAmount": 0.00
    },
    isEditCart: false,
    checkedAllStatus: true,
    editCartList: [],
    startX: 0, //开始触摸的坐标
    startY: 0
  },
  //手指触摸动作开始 记录起点X坐标
  carTouchstart:function(e){
    this.setData({
      startX: e.changedTouches[0].clientX,
      startY: e.changedTouches[0].clientY,
    })
  },
  //手指滑动事件处理
  carTouchmove: function (e) {
    let that = this,
      index = e.currentTarget.dataset.itemIndex,//当前索引
      startX = that.data.startX,//开始X坐标
      startY = that.data.startY,//开始Y坐标
      touchMoveX = e.changedTouches[0].clientX,//滑动变化坐标
      touchMoveY = e.changedTouches[0].clientY,//滑动变化坐标
      //获取滑动角度
      angle = that.angle({ X: startX, Y: startY }, { X: touchMoveX, Y: touchMoveY });
    that.data.cartGoods.forEach(function (v, i) {
        v.isTouchMove = false
        //滑动超过30度角 return
        if (Math.abs(angle) > 30) return;
        if (i == index) {
          if (touchMoveX > startX) //右滑
            v.isTouchMove = false
          else //左滑
            v.isTouchMove = true
        }
    })
    //更新数据
    that.setData({
      cartGoods: that.data.cartGoods
    })
  },
  /**
   * 计算滑动角度
   * @param {Object} start 起点坐标
   * @param {Object} end 终点坐标
   */
  angle: function (start, end) {
    let _X = end.X - start.X,
      _Y = end.Y - start.Y
    //返回角度 /Math.atan()返回数字的反正切值
    return 360 * Math.atan(_Y / _X) / (2 * Math.PI);
  },
  //左滑删除事件
  cartDelete: function (e) {
    let that=this,
      index = e.currentTarget.dataset.itemIndex,
        productId=this.data.cartGoods[index].product_id;
    wx.showModal({
      title: '',
      content: '是否确认删除？',
      success: function (res) {
        if (res.confirm) {
          util.request(api.CartDelete, {
            productIds: productId
          }, 'POST').then(function (res) {
            if (res.errno === 0) {
              console.log(res.data);
              if (res.data.cartTotal.goodsCount > 0) {
                wx.setTabBarBadge({
                  index: 2,
                  text: res.data.cartTotal.goodsCount.toString(),
                })
              } else {
                wx.removeTabBarBadge({
                  index: 2,
                })
              }
              that.setData({
                cartGoods: res.data.cartList,
                cartTotal: res.data.cartTotal
              });
            }
            that.setData({
              checkedAllStatus: that.isCheckedAll()
            });
          });
        }
      }
    })
  },
  onShareAppMessage: function () {
    return util.shareAppMessage();
  },
  onLoad: function (options) {
    // 页面初始化 options为页面跳转所带来的参数

  },
  onReady: function () {
    // 页面渲染完成

  },
  onShow: function () {
    // 页面显示
    this.getCartList();
  },
  onHide: function () {
    // 页面隐藏

  },
  onUnload: function () {
    // 页面关闭

  },
  navigateToIndex:function(){
    wx.switchTab({
      url: '../index/index',
    })
  },
  getCartList: function () {
    let that = this;
    let cartListArr=[];
    util.request(api.CartList).then(function (res) {
      if (res.errno === 0) {
        res.data.cartList.forEach(function (v, i) {
          v.isTouchMove = false;//默认全隐藏删除
        })
        that.setData({
          cartGoods: res.data.cartList,
          cartTotal: res.data.cartTotal
        });
      if (res.data.cartTotal.goodsCount > 0) {
        wx.setTabBarBadge({
          index: 2,
          text: res.data.cartTotal.goodsCount.toString(),
        })
      }else{
        wx.removeTabBarBadge({
          index: 2,
        })
      }
      }
      that.setData({
        checkedAllStatus: that.isCheckedAll(),
        isEditCart:false
      });
    });
  },
  isCheckedAll: function () {
    //判断购物车商品已全选
    return this.data.cartGoods.every(function (element, index, array) {
      if (element.checked == true) {
        return true;
      } else {
        return false;
      }
    });
  },
  checkedItem: function (event) {
    let itemIndex = event.target.dataset.itemIndex;
    let that = this;
    if (!this.data.isEditCart) {
      util.request(api.CartChecked, { productIds: that.data.cartGoods[itemIndex].product_id, isChecked: that.data.cartGoods[itemIndex].checked ? 0 : 1 }, 'POST').then(function (res) {
        if (res.errno === 0) {
          console.log(res.data);
          that.setData({
            cartGoods: res.data.cartList,
            cartTotal: res.data.cartTotal
          });
        }
        that.setData({
          checkedAllStatus: that.isCheckedAll()
        });
      });
    } else {
      //编辑状态
      let tmpCartData = this.data.cartGoods.map(function (element, index, array) {
        if (index == itemIndex){
          element.checked = !element.checked;
        }
        
        return element;
      });
      that.setData({
        cartGoods: tmpCartData,
        checkedAllStatus: that.isCheckedAll(),
        'cartTotal.checkedGoodsCount': that.getCheckedGoodsCount()
      });
    }
  },
  getCheckedGoodsCount: function(){
    let checkedGoodsCount = 0;
    this.data.cartGoods.forEach(function (v) {
      if (v.checked === true) {
        checkedGoodsCount += v.number;
      }
    });
    console.log(checkedGoodsCount);
    return checkedGoodsCount;
  },
  checkedAll: function () {
    let that = this;
    if (!this.data.isEditCart) {
      let productIds = this.data.cartGoods.map(function (v) {
        return v.product_id;
      });
      util.request(api.CartChecked, { productIds: productIds.join(','), isChecked: that.isCheckedAll() ? 0 : 1 }, 'POST').then(function (res) {
        if (res.errno === 0) {
          console.log(res.data);
          that.setData({
            cartGoods: res.data.cartList,
            cartTotal: res.data.cartTotal
          });
        }
        that.setData({
          checkedAllStatus: that.isCheckedAll()
        });
      });
    } else {
      //编辑状态
      let checkedAllStatus = that.isCheckedAll();
      let tmpCartData = this.data.cartGoods.map(function (v) {
        v.checked = !checkedAllStatus;
        return v;
      });
      that.setData({
        cartGoods: tmpCartData,
        checkedAllStatus: that.isCheckedAll(),
        'cartTotal.checkedGoodsCount': that.getCheckedGoodsCount()
      });
    }
  },
  editCart: function () {
    let that = this;
    if (this.data.isEditCart) {
      this.getCartList();
      this.setData({
        isEditCart: !this.data.isEditCart
      });
    } else {
      //编辑状态
      let tmpCartList = this.data.cartGoods.map(function (v) {
        v.checked = false;
        return v;
      });
      this.setData({
        editCartList: this.data.cartGoods,
        cartGoods: tmpCartList,
        isEditCart: !this.data.isEditCart,
        checkedAllStatus: that.isCheckedAll(),
        'cartTotal.checkedGoodsCount': that.getCheckedGoodsCount()
      });
    }
  },
  updateCart: function (productId, goodsId, number, id) {
    let that = this;
    util.request(api.CartUpdate, {
      productId: productId,
      goodsId: goodsId,
      number: number,
      id: id
    }, 'POST').then(function (res) {
      if (res.errno === 0) {
        that.setData({
          checkedAllStatus: that.isCheckedAll()
        });
      }
    });
  },
  cutNumber: function (event) {
    let itemIndex = event.target.dataset.itemIndex;
    let cartItem = this.data.cartGoods[itemIndex];
    let number = (cartItem.number - 1 > 1) ? cartItem.number - 1 : 1;
    cartItem.number = number;
    this.setData({
      cartGoods: this.data.cartGoods
    });
    this.updateCart(cartItem.product_id, cartItem.goods_id, number, cartItem.id);
  },
  addNumber: function (event) {
    let itemIndex = event.target.dataset.itemIndex;
    let cartItem = this.data.cartGoods[itemIndex];
    let number = cartItem.number + 1;
    cartItem.number = number;
    this.setData({
      cartGoods: this.data.cartGoods
    });
    this.updateCart(cartItem.product_id, cartItem.goods_id, number, cartItem.id);
  },
  checkoutOrder: function () {
    //获取已选择的商品
    let that = this;
    let checkedGoods = this.data.cartGoods.filter(function (element, index, array) {
      if (element.checked == true) {
        return true;
      } else {
        return false;
      }
    });
    if (checkedGoods.length <= 0) {
      return false;
    }
    wx.navigateTo({
      url: '../shopping/checkout/checkout'
    })
  },
  // 编辑删除购物车
  deleteCart: function () {
    //获取已选择的商品
    let that = this;
    let productIds = this.data.cartGoods.filter(function (element, index, array) {
      if (element.checked == true) {
        return true;
      } else {
        return false;
      }
    });
    if (productIds.length <= 0) {
      return false;
    }
    productIds = productIds.map(function (element, index, array) {
      if (element.checked == true) {
        return element.product_id;
      }
    });
    wx.showModal({
      title: '',
      content: '是否确认删除？',
      success:function(res){
        if(res.confirm){
          util.request(api.CartDelete, {
            productIds: productIds.join(',')
          }, 'POST').then(function (res) {
            if (res.errno === 0) {
              console.log(res.data);
              let cartList = res.data.cartList.map(v => {
                console.log(v);
                v.checked = false;
                return v;
              });
              if (res.data.cartTotal.goodsCount > 0) {
                wx.setTabBarBadge({
                  index: 2,
                  text: res.data.cartTotal.goodsCount.toString(),
                })
              } else {
                wx.removeTabBarBadge({
                  index: 2,
                })
              }
              that.setData({
                cartGoods: cartList,
                cartTotal: res.data.cartTotal
              });
            }
            that.setData({
              checkedAllStatus: that.isCheckedAll()
            });
          });
        }
      }
    })
  }
})