/*
Date: 2018-07-30
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `nideshop_ad`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_ad`;
CREATE TABLE `nideshop_ad` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ad_position_id` int(11) unsigned NOT NULL DEFAULT '0',
  `media_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `name` varchar(60) DEFAULT '',
  `link` varchar(255) DEFAULT '',
  `image_url` text,
  `content` varchar(255) DEFAULT '',
  `end_time` datetime DEFAULT NULL,
  `enabled` tinyint(3) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `position_id` (`ad_position_id`),
  KEY `enabled` (`enabled`)
) ENGINE=INNODB  DEFAULT CHARSET=utf8;



-- ----------------------------
-- Table structure for `nideshop_address`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_address`;
CREATE TABLE `nideshop_address` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned DEFAULT '0' COMMENT '会员ID',
  `user_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '收货人姓名',
  `tel_number` varchar(60) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '手机',
  `postal_Code` varchar(50) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '邮编',
  `national_Code` varchar(50) COLLATE utf8_unicode_ci DEFAULT '0' COMMENT '收货地址国家码',
  `province_Name` varchar(50) COLLATE utf8_unicode_ci DEFAULT '0' COMMENT '省',
  `city_Name` varchar(50) COLLATE utf8_unicode_ci DEFAULT '0' COMMENT '市',
  `county_Name` varchar(50) COLLATE utf8_unicode_ci DEFAULT '0' COMMENT '区',
  `detail_Info` varchar(120) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '详细收货地址信息',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- ----------------------------
-- Table structure for `nideshop_ad_position`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_ad_position`;
CREATE TABLE `nideshop_ad_position` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL DEFAULT '''',
  `width` smallint(5) unsigned NOT NULL DEFAULT '0',
  `height` smallint(5) unsigned NOT NULL DEFAULT '0',
  `desc` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=INNODB  DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `nideshop_attribute`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_attribute`;
CREATE TABLE `nideshop_attribute` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `attribute_category_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品类型',
  `name` varchar(60) NOT NULL DEFAULT '' COMMENT '属性名称',
  `input_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '当添加商品时,该属性的添加类别; 0为手功输入;1为选择输入;2为多行文本输入',
  `value` text NOT NULL COMMENT '即选择输入,则attr_name对应的值的取值就是该这字段值 ',
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cat_id` (`attribute_category_id`)
) ENGINE=INNODB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `nideshop_attribute_category`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_attribute_category`;
CREATE TABLE `nideshop_attribute_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(60) NOT NULL DEFAULT '',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1开启; 0关闭;',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1036002 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `nideshop_brand`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_brand`;
CREATE TABLE `nideshop_brand` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '品牌名称',
  `list_pic_url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片',
  `simple_desc` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `pic_url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片',
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '50' COMMENT '排序',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '显示',
  `floor_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `app_list_pic_url` varchar(255) NOT NULL DEFAULT '' COMMENT 'app显示图片',
  `is_new` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '新品牌',
  `new_pic_url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片',
  `new_sort_order` tinyint(2) unsigned NOT NULL DEFAULT '10' COMMENT '排序',
  PRIMARY KEY (`id`),
  KEY `is_show` (`is_show`)
) ENGINE=INNODB AUTO_INCREMENT=1046011 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `nideshop_cart`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_cart`;
CREATE TABLE `nideshop_cart` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '会员Id',
  `session_id` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'sessionId',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品Id',
  `goods_sn` varchar(60) NOT NULL DEFAULT '' COMMENT '商品序列号',
  `product_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '产品Id',
  `goods_name` varchar(120) NOT NULL DEFAULT '' COMMENT '产品名称',
  `market_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '市场价',
  `retail_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '零售价格',
  `number` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '数量',
  `goods_specifition_name_value` text COMMENT '规格属性组成的字符串，用来显示用',
  `goods_specifition_ids` varchar(60) DEFAULT '' COMMENT 'product表对应的goods_specifition_ids',
  `checked` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `list_pic_url` varchar(255) NOT NULL DEFAULT '' COMMENT '商品图片',
  PRIMARY KEY (`id`),
  KEY `session_id` (`session_id`)
) ENGINE=INNODB  DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `nideshop_category`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_category`;
CREATE TABLE `nideshop_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(90) NOT NULL DEFAULT '',
  `keywords` varchar(255) DEFAULT '',
  `front_desc` varchar(255) DEFAULT '',
  `parent_id` int(11) unsigned DEFAULT '0',
  `sort_order` tinyint(1) unsigned DEFAULT '50',
  `show_index` tinyint(1) DEFAULT '0',
  `is_show` tinyint(1) unsigned DEFAULT '1',
  `banner_url` varchar(255) DEFAULT '',
  `icon_url` varchar(255) DEFAULT NULL,
  `img_url` varchar(255) DEFAULT NULL,
  `wap_banner_url` varchar(255) DEFAULT NULL,
  `level` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT '0',
  `front_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=INNODB AUTO_INCREMENT=1036007 DEFAULT CHARSET=utf8;



-- ----------------------------
-- Table structure for `nideshop_channel`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_channel`;
CREATE TABLE `nideshop_channel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `icon_url` varchar(255) NOT NULL DEFAULT '',
  `sort_order` int(4) unsigned NOT NULL DEFAULT '10',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;



-- ----------------------------
-- Table structure for `nideshop_collect`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_collect`;
CREATE TABLE `nideshop_collect` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户Id',
  `value_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '产品Id',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `is_attention` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否提醒',
  `type_id` int(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `goods_id` (`value_id`),
  KEY `is_attention` (`is_attention`)
) ENGINE=INNODB  DEFAULT CHARSET=utf8;



-- ----------------------------
-- Table structure for `nideshop_comment`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_comment`;
CREATE TABLE `nideshop_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '类型',
  `value_id` int(11) DEFAULT '0',
  `content` varchar(6550) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '储存为base64编码',
  `add_time` bigint(12) unsigned DEFAULT '0' COMMENT '记录时间',
  `status` tinyint(3) unsigned DEFAULT '0' COMMENT '状态',
  `user_id` int(11) DEFAULT '0' COMMENT '会员Id',
  PRIMARY KEY (`id`),
  KEY `id_value` (`value_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ----------------------------
-- Table structure for `nideshop_comment_picture`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_comment_picture`;
CREATE TABLE `nideshop_comment_picture` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `comment_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '评价Id',
  `pic_url` varchar(255) NOT NULL DEFAULT '' COMMENT '评价图片',
  `sort_order` tinyint(1) unsigned NOT NULL DEFAULT '5' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nideshop_comment_picture
-- ----------------------------

-- ----------------------------
-- Table structure for `nideshop_coupon`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_coupon`;
CREATE TABLE `nideshop_coupon` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT '',
  `type_money` decimal(10,2) DEFAULT '0.00',
  `send_type` tinyint(3) unsigned DEFAULT '0',
  `min_amount` decimal(10,2) unsigned DEFAULT '0.00',
  `max_amount` decimal(10,2) unsigned DEFAULT '0.00',
  `send_start_date` datetime DEFAULT NULL,
  `send_end_date` datetime DEFAULT NULL,
  `use_start_date` datetime DEFAULT NULL,
  `use_end_date` datetime DEFAULT NULL,
  `min_goods_amount` decimal(10,2) unsigned DEFAULT '0.00',
  `min_transmit_num` int(4) DEFAULT NULL COMMENT '转发次数',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `nideshop_coupon_goods`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_coupon_goods`;
CREATE TABLE `nideshop_coupon_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `coupon_id` int(11) NOT NULL COMMENT '优惠券Id',
  `goods_id` int(11) NOT NULL COMMENT '商品id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='优惠券关联商品';



-- ----------------------------
-- Table structure for `nideshop_feedback`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_feedback`;
CREATE TABLE `nideshop_feedback` (
  `msg_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '会员Id',
  `user_name` varchar(60) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '会员会员名称',
  `mobile` varchar(60) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '手机',
  `feed_Type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '反馈类型',
  `content` text COLLATE utf8_unicode_ci NOT NULL COMMENT '详细内容',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `add_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '反馈时间',
  PRIMARY KEY (`msg_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



-- ----------------------------
-- Table structure for `nideshop_footprint`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_footprint`;
CREATE TABLE `nideshop_footprint` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '会员Id',
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品id',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '记录时间',
  `referrer` int(11) DEFAULT NULL COMMENT '转发人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nideshop_footprint
-- ----------------------------

-- ----------------------------
-- Table structure for `nideshop_goods`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_goods`;
CREATE TABLE `nideshop_goods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(11) unsigned DEFAULT '0',
  `goods_sn` varchar(60) DEFAULT '',
  `name` varchar(120) NOT NULL DEFAULT '',
  `brand_id` int(11) unsigned DEFAULT '0',
  `goods_number` int(11) unsigned DEFAULT '0',
  `keywords` varchar(255) DEFAULT '',
  `goods_brief` varchar(255) DEFAULT '',
  `goods_desc` text,
  `is_on_sale` tinyint(1) unsigned DEFAULT '1',
  `add_time` datetime DEFAULT NULL,
  `sort_order` smallint(4) unsigned DEFAULT '100',
  `is_delete` tinyint(1) unsigned DEFAULT '0',
  `attribute_category` int(11) unsigned DEFAULT '0',
  `counter_price` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '专柜价格',
  `extra_price` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '附加价格',
  `is_new` tinyint(1) unsigned DEFAULT '0',
  `goods_unit` varchar(45) DEFAULT NULL COMMENT '商品单位',
  `primary_pic_url` varchar(255) DEFAULT NULL COMMENT '商品主图',
  `list_pic_url` varchar(255) DEFAULT NULL COMMENT '商品列表图',
  `retail_price` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '零售价格',
  `sell_volume` int(11) unsigned DEFAULT '0' COMMENT '销售量',
  `primary_product_id` int(11) unsigned DEFAULT '0' COMMENT '主sku　product_id',
  `unit_price` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '单位价格，单价',
  `promotion_desc` varchar(255) DEFAULT NULL,
  `promotion_tag` varchar(45) DEFAULT NULL,
  `app_exclusive_price` decimal(10,2) unsigned DEFAULT NULL COMMENT 'APP专享价',
  `is_app_exclusive` tinyint(1) unsigned DEFAULT NULL COMMENT '是否是APP专属',
  `is_limited` tinyint(1) unsigned DEFAULT NULL,
  `is_hot` tinyint(1) unsigned DEFAULT '0',
  `market_price` decimal(10,2) DEFAULT '0.00',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人ID',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '修改人ID',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_user_dept_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_sn` (`goods_sn`),
  KEY `cat_id` (`category_id`),
  KEY `brand_id` (`brand_id`),
  KEY `goods_number` (`goods_number`),
  KEY `sort_order` (`sort_order`)
) ENGINE=INNODB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `nideshop_goods_attribute`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_goods_attribute`;
CREATE TABLE `nideshop_goods_attribute` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品Id',
  `attribute_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '属性Id',
  `value` text NOT NULL COMMENT '属性值',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`),
  KEY `attr_id` (`attribute_id`)
) ENGINE=INNODB  DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `nideshop_goods_bargain`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_goods_bargain`;
CREATE TABLE `nideshop_goods_bargain` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '砍价大图',
  `item_pic_url` varchar(255) NOT NULL DEFAULT '' COMMENT '活动条例图片',
  `goods_id` int(11) NOT NULL,
  `sort_order` int(11) unsigned zerofill NOT NULL,
  `subtitle` varchar(255) NOT NULL,
  `assist_count` int(4) NOT NULL DEFAULT '0' COMMENT '最低拉取几人',
  KEY `topic_id` (`id`)
) ENGINE=INNODB  DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `nideshop_goods_crash`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_goods_crash`;
CREATE TABLE `nideshop_goods_crash` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` int(11) NOT NULL COMMENT '商品Id',
  `goods_crash_id` int(11) NOT NULL COMMENT '搭配商品Id',
  `product_crash_id` int(11) NOT NULL COMMENT '搭配产品Id',
  `retail_crash_price` decimal(10,2) NOT NULL COMMENT '搭配商品价格，需要小于原始价格',
  PRIMARY KEY (`id`)
) ENGINE=INNODB  DEFAULT CHARSET=gbk COMMENT='商品搭配减';



-- ----------------------------
-- Table structure for `nideshop_goods_gallery`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_goods_gallery`;
CREATE TABLE `nideshop_goods_gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` int(11) DEFAULT '0' COMMENT '商品id',
  `img_url` longblob COMMENT '图片',
  `img_desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '描述',
  `sort_order` int(11) DEFAULT '5' COMMENT '排序',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=700 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for `nideshop_goods_group`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_goods_group`;
CREATE TABLE `nideshop_goods_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '团购大图',
  `item_pic_url` varchar(255) NOT NULL DEFAULT '' COMMENT '活动条例图片',
  `read_count` int(11) DEFAULT NULL,
  `goods_id` int(11) NOT NULL,
  `sort_order` int(11) unsigned zerofill NOT NULL,
  `subtitle` varchar(255) NOT NULL,
  KEY `topic_id` (`id`)
) ENGINE=INNODB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `nideshop_goods_issue`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_goods_issue`;
CREATE TABLE `nideshop_goods_issue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(500) DEFAULT NULL,
  `answer` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `nideshop_goods_specification`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_goods_specification`;
CREATE TABLE `nideshop_goods_specification` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0',
  `specification_id` int(11) unsigned NOT NULL DEFAULT '0',
  `value` varchar(50) DEFAULT '',
  `pic_url` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`),
  KEY `specification_id` (`specification_id`)
) ENGINE=INNODB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='商品对应规格表值表';


-- ----------------------------
-- Table structure for `nideshop_keywords`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_keywords`;
CREATE TABLE `nideshop_keywords` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `keyword` varchar(90) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '关键字',
  `is_hot` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '热销',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '默认',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '显示',
  `sort_order` int(11) NOT NULL DEFAULT '100' COMMENT '排序',
  `scheme_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '关键词的跳转链接',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='热闹关键词表';

-- ----------------------------
-- Records of nideshop_keywords
-- ----------------------------

-- ----------------------------
-- Table structure for `nideshop_order`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_order`;
CREATE TABLE `nideshop_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(32) DEFAULT '',
  `user_id` int(11) unsigned DEFAULT '0',
  `order_status` int(3) unsigned DEFAULT '0',
  `shipping_status` tinyint(1) unsigned DEFAULT '0',
  `pay_status` tinyint(1) unsigned DEFAULT '0',
  `consignee` varchar(60) DEFAULT '',
  `country` varchar(50) DEFAULT NULL,
  `province` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `district` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT '',
  `mobile` varchar(60) DEFAULT '',
  `postscript` varchar(255) DEFAULT '',
  `shipping_id` tinyint(3) DEFAULT '0',
  `shipping_name` varchar(120) DEFAULT '',
  `pay_id` varchar(64) DEFAULT '0',
  `pay_name` varchar(120) DEFAULT '',
  `shipping_fee` decimal(10,2) DEFAULT '0.00',
  `actual_price` decimal(10,2) DEFAULT '0.00' COMMENT '实际需要支付的金额',
  `integral` int(10) unsigned DEFAULT '0',
  `integral_money` decimal(10,2) DEFAULT '0.00',
  `order_price` decimal(10,2) DEFAULT '0.00' COMMENT '订单总价',
  `goods_price` decimal(10,2) DEFAULT '0.00' COMMENT '商品总价',
  `add_time` datetime DEFAULT NULL,
  `confirm_time` datetime DEFAULT NULL,
  `pay_time` datetime DEFAULT NULL,
  `freight_price` int(10) unsigned DEFAULT '0' COMMENT '配送费用',
  `coupon_id` int(11) unsigned DEFAULT '0' COMMENT '使用的优惠券id',
  `parent_id` int(11) unsigned DEFAULT '0',
  `coupon_price` decimal(10,2) DEFAULT NULL,
  `callback_status` enum('true','false') DEFAULT 'true',
  `shipping_no` varchar(32) DEFAULT NULL,
  `full_cut_price` decimal(10,2) DEFAULT NULL,
  `order_type` varchar(1) DEFAULT NULL,
  `progress` varchar(200) DEFAULT NULL COMMENT '订单进度描述',
  `shipping_time` datetime DEFAULT NULL COMMENT '发货时间',
  `pay_type` tinyint(1) unsigned DEFAULT '1' COMMENT '支付类型；1：微信支付',
  `transaction_no` varchar(50) DEFAULT NULL COMMENT '流水号',
  `handler` varchar(50) DEFAULT NULL COMMENT '订单跟进人，关联sys_user.username',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_sn` (`order_sn`),
  KEY `user_id` (`user_id`),
  KEY `order_status` (`order_status`),
  KEY `shipping_status` (`shipping_status`),
  KEY `pay_status` (`pay_status`),
  KEY `shipping_id` (`shipping_id`),
  KEY `pay_id` (`pay_id`)
) ENGINE=INNODB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `nideshop_order_goods`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_order_goods`;
CREATE TABLE `nideshop_order_goods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单Id',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `goods_name` varchar(120) NOT NULL DEFAULT '' COMMENT '商品名称',
  `goods_sn` varchar(60) NOT NULL DEFAULT '' COMMENT '商品序列号',
  `product_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '产品Id',
  `number` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT '商品数量',
  `market_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '市场价',
  `retail_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '零售价格',
  `goods_specifition_name_value` text COMMENT '商品规格详情',
  `is_real` tinyint(1) unsigned DEFAULT '0' COMMENT '虚拟商品',
  `goods_specifition_ids` varchar(255) DEFAULT '' COMMENT '商品规格Ids',
  `list_pic_url` varchar(255) DEFAULT '' COMMENT '图片链接',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=INNODB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `nideshop_product`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_product`;
CREATE TABLE `nideshop_product` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` int(11) unsigned DEFAULT '0' COMMENT '商品Id',
  `goods_specification_ids` varchar(50) DEFAULT '' COMMENT '商品规格ids',
  `goods_sn` varchar(60) DEFAULT '' COMMENT '商品序列号',
  `goods_number` int(11) unsigned DEFAULT '0' COMMENT '商品编码',
  `retail_price` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '零售价格',
  `market_price` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '团购价格',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=290 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `nideshop_related_goods`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_related_goods`;
CREATE TABLE `nideshop_related_goods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品Id',
  `related_goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '关联商品id',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nideshop_related_goods
-- ----------------------------

-- ----------------------------
-- Table structure for `nideshop_search_history`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_search_history`;
CREATE TABLE `nideshop_search_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `keyword` char(50) NOT NULL COMMENT '关键字',
  `from` varchar(45) DEFAULT '' COMMENT '搜索来源，如PC、小程序、APP等',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '搜索时间',
  `user_id` varchar(45) DEFAULT NULL COMMENT '会员Id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;



-- ----------------------------
-- Table structure for `nideshop_shipping`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_shipping`;
CREATE TABLE `nideshop_shipping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `status` int(1) unsigned zerofill NOT NULL DEFAULT '0' COMMENT '状态 0正常 1删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `nideshop_sms_log`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_sms_log`;
CREATE TABLE `nideshop_sms_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) NOT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `log_date` bigint(20) DEFAULT NULL,
  `sms_code` varchar(12) DEFAULT NULL,
  `send_status` bigint(20) DEFAULT NULL,
  `sms_text` varchar(255) DEFAULT NULL COMMENT '1成功 0失败',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `nideshop_specification`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_specification`;
CREATE TABLE `nideshop_specification` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(60) NOT NULL DEFAULT '' COMMENT '规范名称',
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='规格表';


-- ----------------------------
-- Table structure for `nideshop_topic`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_topic`;
CREATE TABLE `nideshop_topic` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) NOT NULL DEFAULT '''''' COMMENT '活动主题',
  `content` text COMMENT '活动内容',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '化名',
  `item_pic_url` varchar(255) NOT NULL DEFAULT '' COMMENT '活动条例图片',
  `subtitle` varchar(255) NOT NULL DEFAULT '''' COMMENT '子标题',
  `topic_category_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '活动类别',
  `price_info` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '活动价格',
  `read_count` varchar(255) NOT NULL DEFAULT '0',
  `scene_pic_url` varchar(255) NOT NULL DEFAULT '' COMMENT '场景图片链接',
  `topic_template_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '活动模板Id',
  `topic_tag_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '活动标签Id',
  KEY `topic_id` (`id`)
) ENGINE=INNODB AUTO_INCREMENT=316 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for `nideshop_topic_category`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_topic_category`;
CREATE TABLE `nideshop_topic_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '活动类别主题',
  `pic_url` varchar(255) NOT NULL DEFAULT '' COMMENT '活动类别图片链接',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `nideshop_user`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_user`;
CREATE TABLE `nideshop_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(60) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT '',
  `gender` tinyint(1) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `register_time` datetime DEFAULT NULL,
  `last_login_time` datetime DEFAULT NULL,
  `last_login_ip` varchar(15) DEFAULT '',
  `user_level_id` tinyint(3) DEFAULT NULL,
  `nickname` varchar(60) DEFAULT '',
  `mobile` varchar(20) DEFAULT '',
  `register_ip` varchar(45) DEFAULT '',
  `avatar` varchar(255) DEFAULT '',
  `weixin_openid` varchar(50) DEFAULT '',
  `weixin_unionId` varchar(50) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`username`),
  INDEX `idx_weixin_unionId` (`weixin_unionId`)
) ENGINE=INNODB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `nideshop_user_coupon`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_user_coupon`;
CREATE TABLE `nideshop_user_coupon` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `coupon_id` tinyint(3) unsigned DEFAULT '0',
  `coupon_number` varchar(20) DEFAULT '',
  `user_id` int(11) unsigned DEFAULT '0',
  `used_time` datetime DEFAULT NULL,
  `add_time` datetime DEFAULT NULL,
  `order_id` int(11) unsigned DEFAULT '0',
  `source_key` varchar(64) DEFAULT NULL COMMENT '来源key',
  `referrer` int(32) DEFAULT NULL COMMENT '发券人',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nideshop_user_coupon
-- ----------------------------

-- ----------------------------
-- Table structure for `nideshop_user_level`
-- ----------------------------
DROP TABLE IF EXISTS `nideshop_user_level`;
CREATE TABLE `nideshop_user_level` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `QRTZ_BLOB_TRIGGERS`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for `QRTZ_CALENDARS`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------

-- ----------------------------
-- Table structure for `QRTZ_CRON_TRIGGERS`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(120) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `QRTZ_FIRED_TRIGGERS`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`),
  KEY `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`),
  KEY `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for `QRTZ_JOB_DETAILS`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_NONCONCURRENT` varchar(1) NOT NULL,
  `IS_UPDATE_DATA` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `QRTZ_LOCKS`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `QRTZ_PAUSED_TRIGGER_GRPS`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------

-- ----------------------------
-- Table structure for `QRTZ_SCHEDULER_STATE`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- ----------------------------
-- Table structure for `QRTZ_SIMPLE_TRIGGERS`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for `QRTZ_SIMPROP_TRIGGERS`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for `QRTZ_TRIGGERS`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`),
  KEY `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for `schedule_job`
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job`;
CREATE TABLE `schedule_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `bean_name` varchar(200) DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(100) DEFAULT NULL COMMENT '方法名',
  `params` varchar(2000) DEFAULT NULL COMMENT '参数',
  `cron_expression` varchar(100) DEFAULT NULL COMMENT 'cron表达式',
  `status` tinyint(4) DEFAULT NULL COMMENT '任务状态',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='定时任务';


-- ----------------------------
-- Table structure for `schedule_job_log`
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job_log`;
CREATE TABLE `schedule_job_log` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志id',
  `job_id` bigint(20) NOT NULL COMMENT '任务id',
  `bean_name` varchar(200) DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(100) DEFAULT NULL COMMENT '方法名',
  `params` varchar(2000) DEFAULT NULL COMMENT '参数',
  `status` tinyint(4) NOT NULL COMMENT '任务状态    0：成功    1：失败',
  `error` varchar(2000) DEFAULT NULL COMMENT '失败信息',
  `times` int(11) NOT NULL COMMENT '耗时(单位：毫秒)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`log_id`),
  KEY `job_id` (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='定时任务日志';

-- ----------------------------
-- Records of schedule_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_config`
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `key` varchar(50) DEFAULT NULL COMMENT 'key',
  `value` varchar(2000) DEFAULT NULL COMMENT 'value',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态   0：隐藏   1：显示',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='系统配置信息表';


-- ----------------------------
-- Table structure for `sys_dept`
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT '上级部门ID，一级部门为0',
  `name` varchar(50) DEFAULT NULL COMMENT '部门名称',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否删除  -1：已删除  0：正常',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='部门管理';




-- ----------------------------
-- Table structure for `sys_log`
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) DEFAULT NULL COMMENT '用户操作',
  `method` varchar(200) DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) DEFAULT NULL COMMENT '请求参数',
  `ip` varchar(64) DEFAULT NULL COMMENT 'IP地址',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统日志';


-- ----------------------------
-- Table structure for `sys_macro`
-- ----------------------------
DROP TABLE IF EXISTS `sys_macro`;
CREATE TABLE `sys_macro` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(255) DEFAULT NULL COMMENT '父级id',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `value` varchar(2000) DEFAULT NULL COMMENT '值',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态，0：隐藏   1：显示',
  `type` tinyint(20) DEFAULT NULL COMMENT '类型,0:目录，1:参数配置',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `gmt_create` date DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` date DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=8 DEFAULT CHARSET=gbk COMMENT='通用字典表';


-- ----------------------------
-- Table structure for `sys_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(50) DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(200) DEFAULT NULL COMMENT '菜单URL',
  `perms` varchar(500) DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `type` int(11) DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) DEFAULT NULL COMMENT '菜单图标',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  `status` int(1) DEFAULT NULL,
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=383 DEFAULT CHARSET=utf8 COMMENT='菜单管理';


-- ----------------------------
-- Table structure for `sys_oss`
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE `sys_oss` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) DEFAULT NULL COMMENT 'URL地址',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COMMENT='文件上传';

-- ----------------------------
-- Records of sys_oss
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) DEFAULT NULL COMMENT '角色名称',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建者ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='角色';



-- ----------------------------
-- Table structure for `sys_role_dept`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='角色与部门对应关系';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COMMENT='角色与菜单对应关系';



-- ----------------------------
-- Table structure for `sys_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(100) DEFAULT NULL COMMENT '手机号',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态  0：禁用   1：正常',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建者ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='系统用户';


-- ----------------------------
-- Table structure for `sys_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='用户与角色对应关系';


-- ----------------------------
-- Table structure for `tb_token`
-- ----------------------------
DROP TABLE IF EXISTS `tb_token`;
CREATE TABLE `tb_token` (
  `user_id` bigint(20) NOT NULL,
  `token` varchar(100) NOT NULL COMMENT 'token',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='用户Token';

DROP TABLE IF EXISTS sys_region;
create table sys_region
(
  id smallint auto_increment
    primary key,
  parent_id smallint default '0' ,
  name varchar(120) default '' not null,
  type tinyint(1) default '2' not null,
  agency_id smallint default '0'
)
;

create index agency_id
  on sys_region (agency_id)
;

create index parent_id
  on sys_region (parent_id)
;

create index region_type
  on sys_region (type)
;

DROP TABLE IF EXISTS `sys_sms_log`;
CREATE TABLE `sys_sms_log` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `user_id` bigint(20) COMMENT '操作人',
  `content` text COMMENT '必填参数。发送内容（1-500 个汉字）UTF-8编码',
  `mobile` text COMMENT '必填参数。手机号码。多个以英文逗号隔开',
  `stime` datetime COMMENT '可选参数。发送时间，填写时已填写的时间发送，不填时为当前时间发送',
  `sign` varchar(32) COMMENT '必填参数。用户签名',
  `type` varchar(32) COMMENT '必填参数。固定值 pt',
  `extno` varchar(255) COMMENT '可选参数。扩展码，用户定义扩展码，只能为数字',
  `send_status` int(11) COMMENT '1成功 0失败',
  `send_id` varchar(32) COMMENT '发送编号',
  `invalid_num` int(11) COMMENT '无效号码数',
  `success_num` int(11) COMMENT '成功提交数',
  `black_num` int(11) COMMENT '黑名单数',
  `return_msg` varchar(50) COMMENT '返回消息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- 20180123
ALTER TABLE nideshop_address ADD is_default INT(1) DEFAULT 0 NULL;


DROP TABLE IF EXISTS `nideshop_order_process`;
CREATE TABLE `nideshop_order_process` (
	`id` INT (11) NOT NULL AUTO_INCREMENT,
	`order_id` int(11) NOT NULL,
	`add_time` datetime NOT NULL COMMENT '添加时间',
	`desc` VARCHAR (255) NOT NULL COMMENT '进度描述',
	`sys_username` VARCHAR (50) NOT NULL COMMENT '记录人',
	PRIMARY KEY (`id`)
) ENGINE = INNODB DEFAULT CHARSET = utf8;

alter table nideshop_goods_gallery add type TINYINT(4) not null DEFAULT 1 comment '类型：1图片；2视频';
