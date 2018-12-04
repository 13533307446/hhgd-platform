// let WxParse = require('../../lib/wxParse/wxParse.js');
const util = require('../../utils/util.js');
const api = require('../../config/api.js');
const user = require('../../services/user.js');

//获取应用实例
const app = getApp() 
Page({
  data: {
    id: 0,
    goods: {},
    retail_price:0,
    market_price:0,
    list_pic_url:"",
    gallery: [],
    attribute: [],
    issueList: [],
    comment: [],
    brand: {},
    specificationList: [],
    productList: [],
    cartGoodsCount: 0,
    userHasCollect: 0,
    number: 1,
    checkedSpecText: '请选择规格数量',
    openBack: false,
    addToCarBtnWidth:"100%",
    noCollectImage: "/static/images/icon_collect.png",
    hasCollectImage: "/static/images/icon_collect_checked.png",
    collectBackImage: "/static/images/icon_collect.png",
    marketStatus:true
    // bannerImgHeights: [],
    // current:0,
    // winWidth:0,
    // winHeight:0
  },
  onShareAppMessage: function () {
    return util.shareAppMessage();
  },
  getGoodsInfo: function () {
    let that = this;
    util.request(api.GoodsDetail, { id: that.data.id }).then(function (res) {
      console.log(res)
      
      if (res.errno === 0) {
        res.data.info.retail_price = '4999-7999';
        that.setData({
          goods: res.data.info,
          gallery: res.data.gallery,
          attribute: res.data.attribute,
          issueList: res.data.issue,
          comment: res.data.comment,
          brand: res.data.brand,
          specificationList: res.data.specificationList,
          productList: res.data.productList,
          userHasCollect: res.data.userHasCollect
        });
        if (res.data.userHasCollect == 1) {
          that.setData({
            'collectBackImage': that.data.hasCollectImage
          });
        } else {
          that.setData({
            'collectBackImage': that.data.noCollectImage
          });
        }

        // WxParse.wxParse('goodsDetail', 'html', res.data.info.goods_desc, that);

        // that.getGoodsRelated();
      }
    });

  },
  // bannerImageLoad: function (e) {
  //   //获取图片真实宽度
  //   var imgwidth = e.detail.width,
  //     imgheight = e.detail.height,
  //     //宽高比
  //     ratio = imgwidth / imgheight;
  //   //计算的高度值
  //   var viewHeight = 750 / ratio;
  //   var imgheight = viewHeight
  //   var imgheights = this.data.bannerImgHeights
  //   //把每一张图片的高度记录到数组里
  //   imgheights.push(imgheight)
  //   this.setData({
  //     bannerImgHeights: imgheights,
  //   })
  // },
  // bannerImgChange: function (e) {
  //   this.setData({ 
  //     current: e.detail.current 
  //   })
  // },
  // getGoodsRelated: function () {
  //   let that = this;
  //   util.request(api.GoodsRelated, { id: that.data.id }).then(function (res) {
  //     if (res.errno === 0) {
  //       that.setData({
  //         relatedGoods: res.data.goodsList,
  //       });
  //     }
  //   });

  // },
  clickSkuValue: function (event) {
    let that = this;
    let specNameId = event.currentTarget.dataset.nameId;
    let specValueId = event.currentTarget.dataset.valueId;

    //判断是否可以点击

    //TODO 性能优化，可在wx:for中添加index，可以直接获取点击的属性名和属性值，不用循环
    let _specificationList = this.data.specificationList;
    for (let i = 0; i < _specificationList.length; i++) {
      if (_specificationList[i].specification_id == specNameId) {
        for (let j = 0; j < _specificationList[i].valueList.length; j++) {
          if (_specificationList[i].valueList[j].id == specValueId) {
            //如果已经选中，则反选
            if (_specificationList[i].valueList[j].checked) {
              _specificationList[i].valueList[j].checked = false;
            } else {
              _specificationList[i].valueList[j].checked = true;
            }
          } else {
            _specificationList[i].valueList[j].checked = false;
          }
        }
      }
    }
    this.setData({
      'specificationList': _specificationList
    });
    //重新计算spec改变后的信息
    this.changeSpecInfo();

    //重新计算哪些值不可以点击
  },

  //获取选中的规格信息
  getCheckedSpecValue: function () {
    let checkedValues = [];
    let _specificationList = this.data.specificationList;
    for (let i = 0; i < _specificationList.length; i++) {
      let _checkedObj = {
        nameId: _specificationList[i].specification_id,
        valueId: 0,
        valueText: ''
      };
      for (let j = 0; j < _specificationList[i].valueList.length; j++) {
        if (_specificationList[i].valueList[j].checked) {
          _checkedObj.valueId = _specificationList[i].valueList[j].id;
          _checkedObj.valueText = _specificationList[i].valueList[j].value;         
        }
      }
      checkedValues.push(_checkedObj);
    }
    return checkedValues;
  },
  //根据已选的值，计算其它值的状态
  setSpecValueStatus: function () {

  },
  //判断规格是否选择完整
  // isCheckedAllSpec: function () {
  //   return !this.getCheckedSpecValue().some(function (v) {
  //     console.log(v)
  //     if (v.valueId == 0) {
  //       return true;
  //     }
  //   });
  // },
  getCheckedSpecKey: function () {
    let checkedValue = this.getCheckedSpecValue().map(function (v) {
      return v.valueId;
    });
    // 判断规格是否完整
    for (let i = 0; i < checkedValue.length;i++){
      if (checkedValue[i] == 0){
        util.showNoIconErrorToast('请选择' + this.data.specificationList[i].name);
        break;
      } else if (checkedValue[i] != 0 && i==checkedValue.length-1){
        return checkedValue.join('_');
      }
    }  
  },
  changeSpecInfo: function () {
    let goods_specification_id="";
    let goods_specification_ids=[];
    let checkedNameValue = this.getCheckedSpecValue();
    let productList = this.data.productList;
    let _specificationList=this.data.specificationList;
    //设置选择的信息
    let checkedValue = checkedNameValue.filter(function (v) {
      if (v.valueId != 0) {
        goods_specification_ids.push(v.valueId);
        goods_specification_id = goods_specification_ids.join("_");
        return true;
      } else {
        return false;
      }
    }).map(function (v) {
      return v.valueText;
    });
    if (checkedValue.length > 0) {
      this.setData({
        'checkedSpecText': checkedValue.join('\n')
      });
    } else {
      this.setData({
        'checkedSpecText': '请选择规格数量'
      });
    }
    // 规格全选
    if (goods_specification_ids.length == _specificationList.length) {
      for (let p = 0; p < productList.length; p++) {
        if (goods_specification_id == productList[p].goods_specification_ids) {
          this.setData({
            retail_price: productList[p].retail_price,
            market_price: productList[p].market_price,
            marketStatus:false
          })
          break;
        }
      }
    }else{
      this.setData({
        marketStatus: true,
        retail_price: this.data.goods.retail_price               
      })
    }
    // 规格选择大于0
    for (let y = 0; y < checkedNameValue.length;y++){
      // 找出点击的类型
      if (_specificationList[y].valueList[0].pic_url != null) {
        // 点击的类型是否带有图片切换
        if (checkedNameValue[y].valueText != "") {
          for (let a = 0; a < _specificationList[y].valueList.length; a++) {
            for (let b = 0; b < goods_specification_ids.length; b++) {
              if (_specificationList[y].valueList[a].id == goods_specification_ids[b]) {
                this.setData({
                  list_pic_url: _specificationList[y].valueList[a].pic_url
                })
                return;
              }
            }
          }
        }else{
          this.setData({
            list_pic_url: this.data.goods.list_pic_url
          })
        }
      }
    }
  },
  getCheckedProductItem: function (key) {
    console.log(key)
    if(key){
      return this.data.productList.filter(function (v) {
        if (v.goods_specification_ids == key) {
          return true;
        } else {
          return false;
        }
      });
    }
  },
  getIndexData: function () {
    let that = this;
    wx.showLoading({
      title: '加载中...',
    })
    util.request(api.CartGoodsCount).then(function (res) {
      if (res.errno === 0) {
        that.setData({
          cartGoodsCount: res.data.cartTotal.goodsCount
        });
        wx.hideLoading();
        if (res.data.cartTotal.goodsCount>0){
          wx.setTabBarBadge({
            index: 2,
            text: res.data.cartTotal.goodsCount.toString(),
          })
        } else {
          wx.removeTabBarBadge({
            index: 2,
          })
        }
      }
    });
  },
  onLoad: function (options) {
    // let that=this;
    // wx.getSystemInfo({
    //   success: function(res) {
    //     console.log(res)
    //     that.setData({
    //       winWidth:res.windowWidth,
    //       winHeight:res.windowHeight
    //     })
    //   },
    // })
    if (wx.getStorageSync('token') && wx.getStorageSync('userInfo')) {
      getApp().globalData.userInfo = wx.getStorageSync('userInfo');
      getApp().globalData.token = wx.getStorageSync('token');
    }
    let ID;
    // 页面初始化 options为页面跳转所带来的参数
    if(options.id){
      ID = parseInt(options.id);
    }else{
      // ID = 1181001;
      ID = 2;
    }
    this.setData({
      id: ID
    });
  },
  onReady: function () {
    // 页面渲染完成
    this.getGoodsInfo();
  },
  onShow: function () {
    // 页面显示
    if (app.globalData.token) {
      this.getIndexData();
    } else {
      util.redirect('/pages/auth/wxLogin/wxLogin')
    }
  },
  onHide: function () {
    // 页面隐藏
  },
  onUnload: function () {
    // 页面关闭
  },
  switchAttrPop: function () {
    if (this.data.openBack == false) {
      this.setData({
        openBack: !this.data.openBack,
        // collectBackImage: "/static/images/detail_back.png"
      });
    }
  },
  closeAttrOrCollect: function () {
    let that = this;
    if (this.data.openBack) {
      this.setData({
        openBack: !this.data.openBack,
        addToCarBtnWidth:"100%"
      });
      if (that.data.userHasCollect == 1) {
        that.setData({
          'collectBackImage': that.data.hasCollectImage
        });
      } else {
        that.setData({
          'collectBackImage': that.data.noCollectImage
        });
      }
    } else {
      //添加或是取消收藏
      util.request(api.CollectAddOrDelete, { typeId: 0, valueId: this.data.id }, "POST")
        .then(function (res) {
          let _res = res;
          if (_res.errno == 0) {
            if (_res.data.type == 'add') {
              that.setData({
                'collectBackImage': that.data.hasCollectImage
              });
            } else {
              that.setData({
                'collectBackImage': that.data.noCollectImage
              });
            }

          } else {
            wx.showToast({
              image: '/static/images/icon_error.png',
              title: _res.errmsg,
              mask: true
            });
          }

        });
    }

  },
  openCartPage: function () {
    wx.switchTab({
      url: '/pages/cart/cart',
    });
  },
  addToCart: function () {
    var that = this;
    let specificationList = this.data.specificationList;
    if (this.data.openBack == false) {
      //打开规格选择窗口
      this.setData({
        openBack: !this.data.openBack,
        addToCarBtnWidth:"auto",
        // collectBackImage: "/static/images/detail_back.png"
      });
    } else {

      //提示选择完整规格
      // if (!this.isCheckedAllSpec()) {
      //   console.log('规格不完整')
      //   return false;
      // }

      //根据选中的规格，判断是否有对应的sku信息
      let checkedProduct = this.getCheckedProductItem(this.getCheckedSpecKey());
      console.log(checkedProduct)
      if (!checkedProduct){
        return false;
      }else if (checkedProduct.length <= 0) {
        //找不到对应的product信息，提示没有库存
        console.log('找不到对应的sku信息')
        util.showErrorToast('这款暂时没定价');        
        return false;
      }

      //验证库存
      if (checkedProduct.goods_number < this.data.number) {
        //找不到对应的product信息，提示没有库存
        console.log('找不到对应的product信息')
        util.showErrorToast('产品库存不足哦')
        return false;
      }

      //添加到购物车
      util.request(api.CartAdd, { goodsId: this.data.goods.id, number: this.data.number, productId: checkedProduct[0].id, goodsPicUrl: this.data.list_pic_url }, "POST")
        .then(function (res) {
          let _res = res;
          if (_res.errno == 0) {
            wx.showToast({
              title: '添加成功',
              success:()=>{
                if(res){
                  for (let i = 0; i < specificationList.length; i++) {
                    for (let y = 0; y < specificationList[i].valueList.length;y++){
                      if (specificationList[i].valueList[y].checked) {
                        specificationList[i].valueList[y].checked = false;
                      }
                    }
                  }
                }
                that.setData({
                  specificationList: specificationList,
                  number:1
                })
                // wx.switchTab({
                //   url: '../cart/cart',
                // })
              }
            });
            that.setData({
              openBack: !that.data.openBack,
              // cartGoodsCount: _res.data.cartTotal.goodsCount
            });
            if (res.data.cartTotal.goodsCount > 0) {
              wx.setTabBarBadge({
                index: 2,
                text: _res.data.cartTotal.goodsCount.toString(),
              })
            } else {
              wx.removeTabBarBadge({
                index: 2,
              })
            }
            if (that.data.userHasCollect == 1) {
              that.setData({
                'collectBackImage': that.data.hasCollectImage
              });
            } else {
              that.setData({
                'collectBackImage': that.data.noCollectImage
              });
            }
          } else {
            wx.showToast({
              image: '/static/images/icon_error.png',
              title: _res.errmsg,
              mask: true
            });
          }

        });
    }

  },
  cutNumber: function () {
    this.setData({
      number: (this.data.number - 1 > 1) ? this.data.number - 1 : 1
    });
  },
  addNumber: function () {
    this.setData({
      number: this.data.number + 1
    });
  }
})
