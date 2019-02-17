/*
 Navicat Premium Data Transfer

 Source Server         : missevan_local
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : 172.16.10.10:3306
 Source Schema         : mini_shop

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 11/01/2019 14:59:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gf_address
-- ----------------------------
DROP TABLE IF EXISTS `gf_address`;
CREATE TABLE `gf_address`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipient` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '收件人',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '收货地址',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机号',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否是默认地址',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户 ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '收货地址表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gf_address
-- ----------------------------
INSERT INTO `gf_address` VALUES (13, 'chenhao111', 'dizhi', '15611605850', 0, 2);
INSERT INTO `gf_address` VALUES (14, '1111', '222', '12312', 1, 12);
INSERT INTO `gf_address` VALUES (15, '3131', '5454', '2132', 0, 2);
INSERT INTO `gf_address` VALUES (16, '12', '31231', '1231', 0, 0);
INSERT INTO `gf_address` VALUES (17, '213123', '12312', '4124124', 0, 0);
INSERT INTO `gf_address` VALUES (18, '212', '121', '12', 0, 9);

-- ----------------------------
-- Table structure for gf_admin
-- ----------------------------
DROP TABLE IF EXISTS `gf_admin`;
CREATE TABLE `gf_admin`  (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '后台登录用户名',
  `password` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '后台登录密码',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户表\r\n默认密码123456' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gf_admin
-- ----------------------------
INSERT INTO `gf_admin` VALUES (1, 'admin', '7fef6171469e80d32c0559f88b377245');

-- ----------------------------
-- Table structure for gf_category
-- ----------------------------
DROP TABLE IF EXISTS `gf_category`;
CREATE TABLE `gf_category`  (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '栏目名称',
  `pid` int(11) NOT NULL DEFAULT 0 COMMENT '父级栏目的id',
  PRIMARY KEY (`cid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 73 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '栏目表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gf_category
-- ----------------------------
INSERT INTO `gf_category` VALUES (1, '海报', 0);
INSERT INTO `gf_category` VALUES (3, '明信片', 0);
INSERT INTO `gf_category` VALUES (4, '文件袋', 0);
INSERT INTO `gf_category` VALUES (5, '书签', 0);
INSERT INTO `gf_category` VALUES (6, '数码', 0);
INSERT INTO `gf_category` VALUES (7, '鼠标垫', 0);
INSERT INTO `gf_category` VALUES (10, '默读限量海报', 1);
INSERT INTO `gf_category` VALUES (13, '撒野限量海报', 1);
INSERT INTO `gf_category` VALUES (15, '破云限量海报', 1);
INSERT INTO `gf_category` VALUES (25, '默读明信片', 3);
INSERT INTO `gf_category` VALUES (26, '撒野明信片', 3);
INSERT INTO `gf_category` VALUES (27, '破云明信片', 3);
INSERT INTO `gf_category` VALUES (31, '默读文件袋', 4);
INSERT INTO `gf_category` VALUES (32, '撒野文件袋', 4);
INSERT INTO `gf_category` VALUES (33, '破云文件袋', 4);
INSERT INTO `gf_category` VALUES (47, '宅喵卡通书签', 5);
INSERT INTO `gf_category` VALUES (49, '宅喵定制耳机', 6);
INSERT INTO `gf_category` VALUES (58, '宅喵超长款珍藏鼠标垫', 7);

-- ----------------------------
-- Table structure for gf_goods
-- ----------------------------
DROP TABLE IF EXISTS `gf_goods`;
CREATE TABLE `gf_goods`  (
  `gid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品名称商品名称',
  `cate_id` int(11) NOT NULL DEFAULT 0 COMMENT '商品所属栏目',
  `market_price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '市场价',
  `shop_price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '商城价',
  `slogan` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品宣传语',
  `details` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '商品详情',
  `preview` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详情图册',
  `list_pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列表页展示图',
  `is_hot` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否热门',
  `is_onsale` enum('1','0') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否优惠',
  `click` int(11) NOT NULL DEFAULT 0 COMMENT '查看次数',
  `is_recommended` enum('1','0') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否推荐',
  `is_cover` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '首页中的栏目下的长条大图显示部分',
  `slide` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '首页轮播图',
  PRIMARY KEY (`gid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 56 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gf_goods
-- ----------------------------
INSERT INTO `gf_goods` VALUES (48, '撒野文件袋', 32, 15.00, 15.00, '', '<p><img src=\"goods/details/201901/11/d9e19b10cf68b874ff34eedfc50eafe7115133.png\"/></p>', '[\"goods\\/preview\\/201901\\/11\\/cce0576b9484ceb550934edcfcbcb876115132.png\"]', 'goods/list_pic/201901/11/76007e95dbb7d6e6f78d19b612a5dbfe115133.png', '1', '1', 20, '0', '0', '');
INSERT INTO `gf_goods` VALUES (49, '破云文件袋', 33, 15.00, 15.00, '', '<p><img src=\"goods/details/201901/11/01182624a2660bf994704e8057dcbf40115252.png\"/></p>', '[\"goods\\/preview\\/201901\\/11\\/48d3a6e9d6168b9e35a73b8d3d0d0c2f115251.png\"]', 'goods/list_pic/201901/11/33703d54c5d067184d9c0a52ebbb7ceb115252.png', '1', '1', 13, '0', '0', '');
INSERT INTO `gf_goods` VALUES (50, '宅喵卡通书签', 47, 30.00, 30.00, '', '<p><img src=\"goods/details/201901/11/ffd6bb41a5ba9d12933fe021ec52dbab115350.png\"/></p>', '[\"goods\\/preview\\/201901\\/11\\/4e028d6c492650fe77aebdb435c79b62115349.jpg\"]', 'goods/list_pic/201901/11/cabb544d94e8dd60acd961a422632f3c115350.jpg', '1', '1', 189, '0', '0', '');
INSERT INTO `gf_goods` VALUES (51, '宅喵定制耳机', 49, 300.00, 300.00, '', '<p><img src=\"goods/details/201901/11/e8438ad8ca3f4ade6ff2633a1cb3458d115453.png\"/></p>', '[\"goods\\/preview\\/201901\\/11\\/8a78c5471659df887c40e099f119849c115452.png\"]', 'goods/list_pic/201901/11/2325f9e3502a82f49e767238e03a1b2c115453.png', '1', '1', 10, '0', '0', '');
INSERT INTO `gf_goods` VALUES (52, '宅喵超长款珍藏鼠标垫', 58, 50.00, 50.00, '', '<p><img src=\"goods/details/201901/11/c1132e0f2d049c1baa5ab2efc416456f115810.png\"/></p>', '[\"goods\\/preview\\/201901\\/11\\/dc06dbe7a544de6dde706c45fe5989fa115809.png\"]', 'goods/list_pic/201901/11/b5032484b2b141f4a1264a5e64ea8954115810.png', '1', '1', 46, '1', '1', 'goods/slide/201901/11/7c0423662035857ef0ff9f707b9cfb31115810.jpg');
INSERT INTO `gf_goods` VALUES (47, '默读文件袋', 31, 15.00, 15.00, '', '<p><img src=\"goods/details/201901/11/4c3acc7d43942e572a2f7fb61ac05515114855.png\"/></p>', '[\"goods\\/preview\\/201901\\/11\\/e4252aad838fdd01e7b1b8c772156064114851.png\"]', 'goods/list_pic/201901/11/45153baaaf61c93d21fdf53fc9cd9ac9114855.png', '1', '0', 3, '0', '0', '');
INSERT INTO `gf_goods` VALUES (45, '撒野明信片', 26, 10.00, 10.00, '', '<p><img src=\"goods/details/201901/10/400e87c6d6a7f1ccea4d2a58ddc535ac185716.png\"/></p>', '[\"goods\\/preview\\/201901\\/10\\/e5f81ad6799fd2fd60853d06e27a063a185715.png\"]', 'goods/list_pic/201901/10/d8419f6c7c06f644e6269bcf27786227185716.png', '1', '0', 2, '0', '0', '');
INSERT INTO `gf_goods` VALUES (46, '破云明信片', 27, 10.00, 10.00, '', '<p><img src=\"goods/details/201901/10/ea45d92f09066fed52ff0087e6bbcd9f185847.png\"/></p>', '[\"goods\\/preview\\/201901\\/10\\/bba2fa3fc9d9562677375f36d2257ec3185846.png\"]', 'goods/list_pic/201901/10/ebb92d156107128ff1e1a3cc8c06f6d1185846.png', '1', '0', 2, '0', '0', '');
INSERT INTO `gf_goods` VALUES (44, '默读明信片', 25, 10.00, 10.00, '', '<p><img src=\"goods/details/201901/10/e1b00fa4955aa2254c43c62f7fa94940182731.png\"/></p>', '[\"goods\\/preview\\/201901\\/10\\/694308c46c9a16d4971aa48c06cbdd6a182730.png\"]', 'goods/list_pic/201901/10/c7c0c60a4ad8bb276e25b058960e2ef1182731.png', '1', '0', 2, '0', '0', '');
INSERT INTO `gf_goods` VALUES (42, '撒野限量海报', 13, 10.00, 10.00, '', '<p><img src=\"goods/details/201901/10/530d3f41ca1d028c07f971c85bb192f5182528.png\"/></p>', '[\"goods\\/preview\\/201901\\/10\\/5bf047f3e4771fe36a0dc7fedde30bff182526.png\"]', 'goods/list_pic/201901/10/327352e47a1982a9054972862ceaaa91182527.png', '1', '1', 3, '0', '0', '');
INSERT INTO `gf_goods` VALUES (43, '破云限量海报', 15, 10.00, 10.00, '', '<p><img src=\"goods/details/201901/10/a8aa9647fe876b5bb1a276ac60a07862182635.png\"/></p>', '[\"goods\\/preview\\/201901\\/10\\/d8657798a23b28e8a1caff92c67543e3182629.png\"]', 'goods/list_pic/201901/10/d6a06b8b82cc42e10651e50ea0affbe6182634.png', '1', '1', 3, '1', '1', 'goods/slide/201901/10/e54af9950d1cd41919f33b1d36df1365182635.jpg');
INSERT INTO `gf_goods` VALUES (40, '默读限量海报', 1, 10.00, 10.00, '', '', '[\"\\/node_modules\\/hdjs\\/images\\/nopic.jpg\",\"\\/node_modules\\/hdjs\\/images\\/nopic.jpg\",\"\\/node_modules\\/hdjs\\/images\\/nopic.jpg\"]', '/uploads/20190103\\6521a749ec301f12028735a04e9c9d80.png', '1', '0', 0, '0', '0', '');
INSERT INTO `gf_goods` VALUES (41, '默读限量海报', 10, 10.00, 10.00, '', '<p><img src=\"goods/details/201901/10/cf8076cecb8d529719ceba3d2fe330a4182021.png\"/></p>', '[\"goods\\/preview\\/201901\\/10\\/f7c9fb0f13cb164d393119acba811de2182013.png\"]', 'goods/list_pic/201901/10/ddd57c100306e6c2401d9e05d171b08e182019.png', '1', '1', 9, '1', '1', 'goods/slide/201901/10/352be6cb00a9d94123406e3da55b68da182020.jpg');

-- ----------------------------
-- Table structure for gf_goods_comment
-- ----------------------------
DROP TABLE IF EXISTS `gf_goods_comment`;
CREATE TABLE `gf_goods_comment`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论内容',
  `goods_id` int(11) UNSIGNED NOT NULL COMMENT '所属商品 ID',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户 ID',
  `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间',
  `star` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '满意度',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 268 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '货品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gf_goods_comment
-- ----------------------------
INSERT INTO `gf_goods_comment` VALUES (267, '好好好好好好好好好好', 48, 2, 1547186052, 5);
INSERT INTO `gf_goods_comment` VALUES (266, 'kkkkkkkkkkk', 50, 2, 1547182176, 5);
INSERT INTO `gf_goods_comment` VALUES (265, 'kkkkkkkkkkk', 49, 2, 1547182176, 5);
INSERT INTO `gf_goods_comment` VALUES (264, '好评', 48, 2, 1547181339, 5);

-- ----------------------------
-- Table structure for gf_goods_sort
-- ----------------------------
DROP TABLE IF EXISTS `gf_goods_sort`;
CREATE TABLE `gf_goods_sort`  (
  `gsid` int(11) NOT NULL AUTO_INCREMENT,
  `property` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '组合属性',
  `storage` int(11) NOT NULL DEFAULT 0 COMMENT '库存量',
  `goods_id` int(11) NOT NULL COMMENT '所属商品id',
  PRIMARY KEY (`gsid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 232 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '货品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gf_goods_sort
-- ----------------------------
INSERT INTO `gf_goods_sort` VALUES (219, '10', 5, 53);
INSERT INTO `gf_goods_sort` VALUES (212, '15', 5, 54);
INSERT INTO `gf_goods_sort` VALUES (231, '1', 5, 52);
INSERT INTO `gf_goods_sort` VALUES (230, '1', 5, 51);
INSERT INTO `gf_goods_sort` VALUES (229, '1', 4, 50);
INSERT INTO `gf_goods_sort` VALUES (228, '1', 4, 49);
INSERT INTO `gf_goods_sort` VALUES (227, '1', 2, 48);
INSERT INTO `gf_goods_sort` VALUES (226, '1', 5, 47);
INSERT INTO `gf_goods_sort` VALUES (225, '1', 5, 46);
INSERT INTO `gf_goods_sort` VALUES (224, '1', 5, 45);
INSERT INTO `gf_goods_sort` VALUES (223, '1', 5, 44);
INSERT INTO `gf_goods_sort` VALUES (222, '1', 5, 43);
INSERT INTO `gf_goods_sort` VALUES (221, '1', 5, 42);
INSERT INTO `gf_goods_sort` VALUES (220, '1', 5, 41);

-- ----------------------------
-- Table structure for gf_migrations
-- ----------------------------
DROP TABLE IF EXISTS `gf_migrations`;
CREATE TABLE `gf_migrations`  (
  `version` bigint(20) NOT NULL,
  `migration_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `start_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  `end_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `breakpoint` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`version`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gf_migrations
-- ----------------------------
INSERT INTO `gf_migrations` VALUES (20170817131555, 'Users', '2017-08-17 21:58:16', '2017-08-17 21:58:16', 0);
INSERT INTO `gf_migrations` VALUES (20170820152923, 'Address', '2017-08-20 23:46:26', '2017-08-20 23:46:26', 0);

-- ----------------------------
-- Table structure for gf_order
-- ----------------------------
DROP TABLE IF EXISTS `gf_order`;
CREATE TABLE `gf_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `order_num` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '订单号',
  `total_price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '价格总计',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '待付款' COMMENT '订单状态（取消，删除，其它是一般状态）',
  `address_id` int(11) NOT NULL DEFAULT 0 COMMENT '收货地址id',
  `user_id` int(11) NOT NULL COMMENT '所属用户id',
  `order_time` int(11) NOT NULL DEFAULT 0 COMMENT '下单时间',
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注说明',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gf_order
-- ----------------------------
INSERT INTO `gf_order` VALUES (9, 'I0111807171', 15.00, '已付款，未发货', 13, 2, 1547180717, '');
INSERT INTO `gf_order` VALUES (10, 'I0111810705', 45.00, '已完成', 13, 2, 1547181070, '');
INSERT INTO `gf_order` VALUES (11, 'I0111821186', 30.00, '已完成', 15, 2, 1547182118, '');
INSERT INTO `gf_order` VALUES (12, 'I0111859120', 15.00, '待付款', 13, 2, 1547185912, '');

-- ----------------------------
-- Table structure for gf_order_items
-- ----------------------------
DROP TABLE IF EXISTS `gf_order_items`;
CREATE TABLE `gf_order_items`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NULL DEFAULT NULL COMMENT '所属订单id',
  `total_sub_price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '价格小计',
  `num` int(11) NULL DEFAULT 1 COMMENT '购买数量',
  `goods_sort_id` int(11) NULL DEFAULT NULL COMMENT '所属货品款式id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单列表项' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of gf_order_items
-- ----------------------------
INSERT INTO `gf_order_items` VALUES (17, 10, 30.00, 1, 229);
INSERT INTO `gf_order_items` VALUES (16, 9, 15.00, 1, 227);
INSERT INTO `gf_order_items` VALUES (18, 10, 15.00, 1, 228);
INSERT INTO `gf_order_items` VALUES (19, 11, 30.00, 2, 227);
INSERT INTO `gf_order_items` VALUES (20, 12, 15.00, 1, 227);

-- ----------------------------
-- Table structure for gf_search_words
-- ----------------------------
DROP TABLE IF EXISTS `gf_search_words`;
CREATE TABLE `gf_search_words`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `search_word` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '搜索关键词',
  `times` int(11) NOT NULL DEFAULT 1 COMMENT '搜索次数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gf_users
-- ----------------------------
DROP TABLE IF EXISTS `gf_users`;
CREATE TABLE `gf_users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '前台用户名',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '前台用户密码',
  `mail` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '邮箱地址',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '头像地址',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '前台用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gf_users
-- ----------------------------
INSERT INTO `gf_users` VALUES (2, 'chenhao', 'fcea920f7412b5da7be0cf42b8c93759', 'chenhao_apple@163.com', 'avatars/201901/11/cb4b957a4d4a719fa1d94b510cd2e07f121750.jpg');
INSERT INTO `gf_users` VALUES (8, 'chenhao4', 'e10adc3949ba59abbe56e057f20f883e', '', '');
INSERT INTO `gf_users` VALUES (9, '7777777', 'e10adc3949ba59abbe56e057f20f883e', '', '');
INSERT INTO `gf_users` VALUES (10, 'chenhao9', 'e10adc3949ba59abbe56e057f20f883e', '', '');
INSERT INTO `gf_users` VALUES (11, '123456', 'e10adc3949ba59abbe56e057f20f883e', '', '');
INSERT INTO `gf_users` VALUES (12, 'chenhao2', 'e10adc3949ba59abbe56e057f20f883e', '464344458@163.com', '');

-- ----------------------------
-- Table structure for gf_view_times
-- ----------------------------
DROP TABLE IF EXISTS `gf_view_times`;
CREATE TABLE `gf_view_times`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户id',
  `gid` int(11) NOT NULL COMMENT '浏览商品的id',
  `times` int(11) NOT NULL DEFAULT 1 COMMENT '浏览次数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of gf_view_times
-- ----------------------------
INSERT INTO `gf_view_times` VALUES (21, 9, 41, 5);
INSERT INTO `gf_view_times` VALUES (20, 9, 42, 1);
INSERT INTO `gf_view_times` VALUES (19, 2, 51, 7);
INSERT INTO `gf_view_times` VALUES (18, 2, 49, 10);
INSERT INTO `gf_view_times` VALUES (17, 2, 50, 129);
INSERT INTO `gf_view_times` VALUES (16, 2, 43, 1);
INSERT INTO `gf_view_times` VALUES (15, 2, 53, 1);
INSERT INTO `gf_view_times` VALUES (14, 2, 52, 7);
INSERT INTO `gf_view_times` VALUES (22, 2, 47, 1);
INSERT INTO `gf_view_times` VALUES (23, 2, 48, 19);

SET FOREIGN_KEY_CHECKS = 1;
