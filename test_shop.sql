/*
 Navicat Premium Data Transfer

 Source Server         : missevan_local
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : 172.16.10.10:3306
 Source Schema         : test_shop

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 03/01/2019 10:26:22
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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '收货地址表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gf_address
-- ----------------------------
INSERT INTO `gf_address` VALUES (2, '陈浩', '福建省福清市', '15611605850', 0);
INSERT INTO `gf_address` VALUES (12, '习某平', '中南海007', '1123456789', 0);

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
) ENGINE = MyISAM AUTO_INCREMENT = 72 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '栏目表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gf_category
-- ----------------------------
INSERT INTO `gf_category` VALUES (1, '手机通讯', 0);
INSERT INTO `gf_category` VALUES (2, '苹果专区', 0);
INSERT INTO `gf_category` VALUES (3, '手机配件', 0);
INSERT INTO `gf_category` VALUES (4, '视听/数码配件', 0);
INSERT INTO `gf_category` VALUES (5, '电脑办公', 0);
INSERT INTO `gf_category` VALUES (6, '智能/生活', 0);
INSERT INTO `gf_category` VALUES (7, '摄影摄像', 0);
INSERT INTO `gf_category` VALUES (8, '游戏/周边', 0);
INSERT INTO `gf_category` VALUES (9, '华为', 1);
INSERT INTO `gf_category` VALUES (10, '魅族', 1);
INSERT INTO `gf_category` VALUES (11, '小米', 1);
INSERT INTO `gf_category` VALUES (12, '三星', 1);
INSERT INTO `gf_category` VALUES (13, 'oppo', 1);
INSERT INTO `gf_category` VALUES (14, '乐视', 1);
INSERT INTO `gf_category` VALUES (15, '诺基亚', 1);
INSERT INTO `gf_category` VALUES (16, '联想', 1);
INSERT INTO `gf_category` VALUES (17, 'vivo', 1);
INSERT INTO `gf_category` VALUES (18, 'iPhone', 2);
INSERT INTO `gf_category` VALUES (19, 'iPad', 2);
INSERT INTO `gf_category` VALUES (20, 'iPod', 2);
INSERT INTO `gf_category` VALUES (21, 'Mac', 2);
INSERT INTO `gf_category` VALUES (22, '苹果贴膜', 2);
INSERT INTO `gf_category` VALUES (23, '苹果保护壳', 2);
INSERT INTO `gf_category` VALUES (24, '苹果原装配件', 2);
INSERT INTO `gf_category` VALUES (25, '保护套/壳', 3);
INSERT INTO `gf_category` VALUES (26, '手机贴膜', 3);
INSERT INTO `gf_category` VALUES (27, '充电器/数据线', 3);
INSERT INTO `gf_category` VALUES (28, '移动电源', 3);
INSERT INTO `gf_category` VALUES (29, '蓝牙耳机', 3);
INSERT INTO `gf_category` VALUES (30, '创意配件', 3);
INSERT INTO `gf_category` VALUES (31, '平板/笔记本', 4);
INSERT INTO `gf_category` VALUES (32, '一体机', 4);
INSERT INTO `gf_category` VALUES (33, '打印机/耗材', 4);
INSERT INTO `gf_category` VALUES (34, '鼠标', 4);
INSERT INTO `gf_category` VALUES (35, '键盘/套装', 4);
INSERT INTO `gf_category` VALUES (36, '移动硬盘', 4);
INSERT INTO `gf_category` VALUES (37, 'U盘', 4);
INSERT INTO `gf_category` VALUES (38, '路由器', 4);
INSERT INTO `gf_category` VALUES (39, '散热器', 4);
INSERT INTO `gf_category` VALUES (40, '电源插座', 4);
INSERT INTO `gf_category` VALUES (41, '电脑工具', 4);
INSERT INTO `gf_category` VALUES (42, '耳机耳麦', 5);
INSERT INTO `gf_category` VALUES (43, '音响/音箱', 5);
INSERT INTO `gf_category` VALUES (44, '投影仪', 5);
INSERT INTO `gf_category` VALUES (45, '影音播放器', 5);
INSERT INTO `gf_category` VALUES (46, '网络盒子', 5);
INSERT INTO `gf_category` VALUES (47, '存储卡', 5);
INSERT INTO `gf_category` VALUES (48, '影音配件', 5);
INSERT INTO `gf_category` VALUES (49, '智能穿戴', 6);
INSERT INTO `gf_category` VALUES (50, '智能家居', 6);
INSERT INTO `gf_category` VALUES (51, '小家电', 6);
INSERT INTO `gf_category` VALUES (52, '健康监测', 6);
INSERT INTO `gf_category` VALUES (53, '户外运动', 6);
INSERT INTO `gf_category` VALUES (54, '无人机', 6);
INSERT INTO `gf_category` VALUES (55, '汽车用品', 6);
INSERT INTO `gf_category` VALUES (56, '智能机器人', 6);
INSERT INTO `gf_category` VALUES (57, '益智玩具', 6);
INSERT INTO `gf_category` VALUES (58, '摄像机', 7);
INSERT INTO `gf_category` VALUES (59, '单反相机', 7);
INSERT INTO `gf_category` VALUES (60, '单电/微单相机', 7);
INSERT INTO `gf_category` VALUES (61, '数码相机', 7);
INSERT INTO `gf_category` VALUES (62, '运动相机', 7);
INSERT INTO `gf_category` VALUES (63, '拍立得', 7);
INSERT INTO `gf_category` VALUES (64, '镜头', 7);
INSERT INTO `gf_category` VALUES (65, '摄像配件', 7);
INSERT INTO `gf_category` VALUES (66, '游戏主机', 8);
INSERT INTO `gf_category` VALUES (67, '游戏手柄', 8);
INSERT INTO `gf_category` VALUES (68, '游戏控制器', 8);
INSERT INTO `gf_category` VALUES (69, '游戏软件', 8);
INSERT INTO `gf_category` VALUES (70, '配件/其他', 8);
INSERT INTO `gf_category` VALUES (71, '美图', 1);

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
) ENGINE = MyISAM AUTO_INCREMENT = 40 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gf_goods
-- ----------------------------
INSERT INTO `gf_goods` VALUES (1, 'I7 128G四色同价', 18, 6199.00, 5288.00, '直降200，全民疯抢！', '<p><img src=\"http://img10.hqbcdn.com/thumbs/product/f7/db/f7db37dae3524a24c878d0da8ac4c4b4.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img7.hqbcdn.com/thumbs/product/12/f9/12f9749d734d2da2a39352e367192acd.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img6.hqbcdn.com/thumbs/product/23/48/2348b637bfd3b9cc8a201dd42da9f2d7.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img9.hqbcdn.com/thumbs/product/61/eb/61eb692d7830712b8233e8522c94ee02.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img3.hqbcdn.com/thumbs/product/ae/df/aedf7c4be6c71ecca9975014e9c2b753.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img4.hqbcdn.com/thumbs/product/f5/90/f590949427628fc37a6c96065f91808d.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img5.hqbcdn.com/thumbs/product/cf/6f/cf6f6d2406fbca09a05676e133c6545e.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img8.hqbcdn.com/thumbs/product/71/83/71838b4b11c543a72f956fc0f89d1f8a.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img6.hqbcdn.com/thumbs/product/52/2f/522f2e0f905a3f849cffd80100446c13.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img12.hqbcdn.com/thumbs/product/86/7f/867f719c42956820926c708054e5a981.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/></p><p><br/></p>', '[\"\\/uploads\\/20170818\\\\8c467d4694985826e873f57191e161b7.png\",\"\\/uploads\\/20170818\\\\c867df1280055a496c8452682171955b.png\",\"\\/uploads\\/20170818\\\\73c0bfc5497c5338f73bb0c891b1a7e1.png\"]', '/uploads/20170821\\d34ffd60f739ce4780007329b87a44b4.png', '1', '1', 25, '1', '0', '');
INSERT INTO `gf_goods` VALUES (2, 'Apple/苹果 MacBook Air 13.3英寸 2016款 MMGF2CH/A 128GB', 21, 5999.00, 7288.00, '7Plus 128G低至5888', '<p><img src=\"http://img10.hqbcdn.com/thumbs/product/f7/db/f7db37dae3524a24c878d0da8ac4c4b4.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img13.hqbcdn.com/thumbs/product/75/57/7557931b64a0133ba1df717f8ff3e6ef.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img10.hqbcdn.com/thumbs/product/0a/b0/0ab0b3fbb5aac92644a2184f06b3eb65.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img7.hqbcdn.com/thumbs/product/d4/cb/d4cba2dc6e28b1d0c09edd90cc1e1551.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img3.hqbcdn.com/thumbs/product/af/ea/afeaa0cdd2994603b00a3a210241ea44.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img13.hqbcdn.com/thumbs/product/99/8c/998ca7352a748972ca305a3b1e189da3.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img3.hqbcdn.com/thumbs/product/d7/71/d771eb5b435e7b6ffa5ed6ba70eef571.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img8.hqbcdn.com/thumbs/product/04/3d/043da112ef9de54b8cd6a8df2bff83af.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img8.hqbcdn.com/thumbs/product/7f/ed/7fedb992e037ac6c3ae2ca966382358a.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img7.hqbcdn.com/thumbs/product/8d/bf/8dbf0f4f38517a611ee1449be64630bb.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img16.hqbcdn.com/thumbs/product/74/4e/744e4e94f09930df7d7b87d9c3fc6fdf.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img16.hqbcdn.com/thumbs/product/21/5f/215fee67b92f9258cd7fa70d11a72b0d.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img6.hqbcdn.com/thumbs/product/29/c0/29c01589bbe677432a3d741bfb304996.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img7.hqbcdn.com/thumbs/product/f0/05/f005dd2faf155c55cbd071e8d2d62fc0.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img3.hqbcdn.com/thumbs/product/ad/dc/addc7f3c7975ebca639f4a7c9e5c9ce1.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/></p><p><br/></p>', '[\"\\/uploads\\/20170818\\\\0dd3962a69575de6a357416af02f378e.jpg\",\"\\/uploads\\/20170818\\\\5ffa911896a7eb727bb3e7cc350b82b2.jpg\",\"\\/uploads\\/20170818\\\\fa480cf60d641bcb01fa7a36cd599974.jpg\"]', '/uploads/20170821\\0501d4a30420a9751dc211120497bef8.jpg', '1', '0', 11, '0', '0', '');
INSERT INTO `gf_goods` VALUES (6, 'Apple/苹果 iPhone 6s Plus HK 海淘手机 银色 32GB', 18, 3999.00, 5288.00, '最新IOS10系统，3Dtouch按压传感操', '<p><img src=\"http://img11.hqbcdn.com/thumbs/product/e6/b6/e6b6e0670d352e75e63fec20fb1fd0df.jpg\"/></p><p><br/></p>', '[\"\\/uploads\\/20170821\\\\bea04491123251d44d9b4da159ce0ad0.jpg\",\"\\/uploads\\/20170821\\\\dcc8779924529c3d76f3cfa30d7d5100.jpg\",\"\\/uploads\\/20170821\\\\8c4cb9ebfcbadcd54d782391369359ec.jpg\"]', '/uploads/20170821\\0a404dc3575cd4b4e2a48d9468c86a8c.png', '1', '0', 39, '1', '0', '');
INSERT INTO `gf_goods` VALUES (7, 'Apple/苹果 iPhone 7 Plus A1661 全网通 国行手机 亮黑色 256G', 18, 7499.00, 11888.00, '『2016年度秋季新品』苹果原封机，大陆行货全球联保，国内享有440家服务网点优质保修服务！国外凭机器系列号无忧保修！', '<p style=\"text-align: center;\"><img src=\"http://img12.hqbcdn.com/thumbs/product/86/7f/867f719c42956820926c708054e5a981.jpg\"/></p>', '[\"\\/uploads\\/20170821\\\\b0dbb120c56166dc8072b1170dc9fcb9.png\",\"\\/uploads\\/20170821\\\\eae72c886f4e405cf7f73e87f7ae026e.png\",\"\\/uploads\\/20170821\\\\848620e7fee96b331f53d052491fc92f.png\"]', '/uploads/20170821\\403b5568bde163681078d4add2205193.png', '1', '0', 64, '1', '0', '/uploads/20170823/6b7405e9623a0a9059629a20361e1993.jpg');
INSERT INTO `gf_goods` VALUES (8, 'Apple/苹果 iPhone SE (A1723) 全网通4G 深空灰色 16GB', 18, 3488.00, 2299.00, '『国行正品 全球联保』大陆行货苹果原封机，国内享有440家服务网点优质保修服务！国外凭机器序列号无忧保修！更无需承担系统升级、刷机等繁琐操作所带来的风险！', '<p><img src=\"http://img3.hqbcdn.com/thumbs/product/43/da/43dac9b62b0b3c31276942d2b4b75b9f.jpg\"/></p>', '[\"\\/uploads\\/20170821\\\\20b1d6620d9decc3d89f1d8f22efb5ff.jpg\",\"\\/uploads\\/20170821\\\\ad68840f2cd8bb01ede9e6e2e125e7e5.jpg\",\"\\/uploads\\/20170821\\\\966dc26d2a46ba8cf96820155bdb193f.jpg\"]', '/uploads/20170821\\4e6a2fb594440d811a0a3b2edc1f4f09.jpg', '0', '1', 96, '0', '0', '');
INSERT INTO `gf_goods` VALUES (9, 'Apple/苹果 iPhone5s A1530 手机 金色16GB', 18, 3288.00, 1599.00, '苹果手机系列经典版~值得拥有！', '<p><img src=\"http://img10.hqbcdn.com/thumbs/product/f7/db/f7db37dae3524a24c878d0da8ac4c4b4.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img2.hqbcdn.com/thumbs/product/ff/0d/ff0d6d0086521303ee36b781c6285546.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img3.hqbcdn.com/thumbs/product/d0/99/d09943a88b7ffe0dcaf569d3aca8a534.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img10.hqbcdn.com/thumbs/product/e7/03/e7030f8b49c3c27246fa4da8e82c4b8b.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img9.hqbcdn.com/thumbs/product/d4/15/d415c36831766d5433a61b6ff3aa3ca3.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><a href=\"https://selfsolve.apple.com/agreementWarrantyDynamic.do?&locale=cn_ZH\" target=\"_blank\" style=\"vertical-align: baseline; text-decoration-line: none; color: rgb(35, 35, 35); margin: 0px; padding: 0px; font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"><img src=\"http://img9.hqbcdn.com/thumbs/product/7b/c7/7bc7d1280d339a10a38885e6a6323975.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; vertical-align: middle; display: block;\"/></a><img src=\"http://img11.hqbcdn.com/thumbs/product/7a/40/7a40808c965eff99190fd6ddace4822d.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img10.hqbcdn.com/thumbs/product/31/3f/313f12bd61445885e2dde7ac75a87b2f.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img9.hqbcdn.com/thumbs/product/fe/1b/fe1bc197c790b20568e0033f90b1b101.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img16.hqbcdn.com/thumbs/product/f7/5c/f75c0bd160b190ef6c419c593247b1c7.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img8.hqbcdn.com/thumbs/product/4f/08/4f0853c3190434660d6be25f609c3c6c.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img10.hqbcdn.com/thumbs/product/03/96/0396b9abdec0ef915544c3b4c429676b.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img2.hqbcdn.com/thumbs/product/f7/28/f7285b736afb567525c90448cab28a11.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img15.hqbcdn.com/thumbs/product/65/a5/65a5b806249d3f01a6c8d3a952868964.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img10.hqbcdn.com/thumbs/product/26/14/26148a872eb8cab754eadd41f8f94b6d.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img3.hqbcdn.com/thumbs/product/43/6c/436c79f5221023439d13312e070c5c74.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img3.hqbcdn.com/thumbs/product/65/0a/650a0db623a24fdc146cf5ec25c6bd98.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img11.hqbcdn.com/thumbs/product/f7/48/f748481c1f15477517a7acbce469f498.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img10.hqbcdn.com/thumbs/product/f1/18/f1182436905e0d08b09645f21125d45f.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img12.hqbcdn.com/thumbs/product/bf/9b/bf9b240a6d07ad837982188062fcdd45.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img10.hqbcdn.com/thumbs/product/44/70/4470e6948ce18f5e61f2aae9d49811c5.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img14.hqbcdn.com/thumbs/product/19/c5/19c59d771a623479baf7d3f62136045f.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img10.hqbcdn.com/thumbs/product/07/f3/07f3597840c94dfdf6974b98da0a143b.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img13.hqbcdn.com/thumbs/product/e9/6b/e96b98e2395310e5f12714b0ba0aa945.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img3.hqbcdn.com/thumbs/product/ce/be/cebe6427a8bf1178ca3d46afe5df6d5f.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img8.hqbcdn.com/thumbs/product/46/5e/465ea34dbd633af242ffca1cb303a96c.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img11.hqbcdn.com/thumbs/product/16/e8/16e8176fc45c52264521bd718ece9f74.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img7.hqbcdn.com/thumbs/product/51/63/5163da4fe1517dd6ca3ded6532702683.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img11.hqbcdn.com/thumbs/product/46/9b/469bc46fd182567b4adbe78092c62834.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img10.hqbcdn.com/thumbs/product/c6/bf/c6bf4de480517f3f6faae86dc14cea88.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/></p><br/>', '[\"\\/uploads\\/20170821\\\\86b197e06310b4ec0ffb4076e9303a25.jpg\",\"\\/uploads\\/20170821\\\\3238d566649aa02cea154141d19a460d.jpg\",\"\\/uploads\\/20170821\\\\05947928c71afe6488a819b30fa7ee6c.jpg\"]', '/uploads/20170821\\16aa5a066332ba578263942a2f098305.jpg', '0', '1', 6, '1', '0', '');
INSERT INTO `gf_goods` VALUES (4, 'Meizu/魅族 Pro 7 公开版 双卡双待 手机 6GB+64GB 静谧黑', 10, 2999.00, 2888.00, '少量现货，无需等待！', '<p><img src=\"http://img15.hqbcdn.com/thumbs/product/5a/02/5a022bc1ca5a006e573f7d7c15b910f8.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img7.hqbcdn.com/thumbs/product/ea/8d/ea8d769c6d995cf652b6f06cb7782725.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img1.hqbcdn.com/thumbs/product/7c/6e/7c6e2127afc9cf145f0b2fb0b25916f5.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img1.hqbcdn.com/thumbs/product/cf/fd/cffd07d3f404b103ad7d1b92414bdcec.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img2.hqbcdn.com/thumbs/product/99/8e/998ebde4fb82333e4fa34dca56a154a5.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img3.hqbcdn.com/thumbs/product/2e/74/2e746dea811bc11a8c381710623560d0.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img10.hqbcdn.com/thumbs/product/1c/75/1c75e7d770a1ef2c1af3a92159d1983c.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img8.hqbcdn.com/thumbs/product/a7/2b/a72bd6125f83e47c9362c12e3e2adf8b.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img12.hqbcdn.com/thumbs/product/ad/90/ad906b77aaadaadbcec2c3d4676392c6.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img14.hqbcdn.com/thumbs/product/50/f6/50f66c9ff1032c69a171d02bb8737c21.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img11.hqbcdn.com/thumbs/product/23/a4/23a49a8d1c6a3cbae07a138141e91c88.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img7.hqbcdn.com/thumbs/product/9f/bc/9fbc75866138206aff2cb4c6e9b2d806.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img14.hqbcdn.com/thumbs/product/3c/66/3c66dac64893094812b4b8f7caff9e50.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img10.hqbcdn.com/thumbs/product/9b/3d/9b3d067a866709691bbb12a6141be229.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img1.hqbcdn.com/thumbs/product/d3/2e/d32efa7a49d68de44c584368612b2426.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img16.hqbcdn.com/thumbs/product/3e/4a/3e4afaf29cc5b86f3c79f6db326715cc.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img2.hqbcdn.com/thumbs/product/b2/b1/b2b1e5da4f24a60e59be72003dc01cbd.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img11.hqbcdn.com/thumbs/product/7b/83/7b8387fe9302b5860900f99a4b5d287b.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img2.hqbcdn.com/thumbs/product/54/8d/548dc075effa63746e4cec14363dc2ee.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img10.hqbcdn.com/thumbs/product/7d/9a/7d9aa896c3998572e4b66fd331ba23f9.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img13.hqbcdn.com/thumbs/product/63/19/63191bebe2e2940a6cd3040ce8e199ca.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/></p><p><br/></p>', '[\"\\/uploads\\/20170818\\\\1d6f25a4f6e5bc244460259a18e43da0.jpg\",\"\\/uploads\\/20170818\\\\345584efc772f4764182d8ae0d890736.jpg\",\"\\/uploads\\/20170818\\\\21f013f6450adc347ebd0ba2e9f16eb3.jpg\"]', '/uploads/20170821\\87b204c4362b4b0db3ec0299e81aefc5.jpg', '1', '0', 1, '0', '0', '');
INSERT INTO `gf_goods` VALUES (5, 'Apple/苹果 iPhone 7 plus 全网通 国行手机 红色 128G', 18, 6688.00, 7588.00, '', '<p><img src=\"http://img15.hqbcdn.com/thumbs/product/78/53/7853f82bbf95e041e26cff862a757ccd.jpg\"/></p>', '[\"\\/uploads\\/20170821\\\\d7e940117af7b7bbd7a0072461374f98.jpg\",\"\\/uploads\\/20170821\\\\2606a888c2d49670993691fc22c3f637.jpg\",\"\\/uploads\\/20170821\\\\7183f72b41c6d38641b25005191fb7d6.jpg\"]', '/uploads/20170821\\08e2f4113ea09738e30ec8237ac269e1.jpg', '0', '0', 6, '1', '0', '');
INSERT INTO `gf_goods` VALUES (10, 'Apple/苹果 新款 MacBook Pro 13英寸笔记本 MLVP2CH 256G 银色', 21, 12299.00, 13888.00, '新键盘与触控条！ Touch ID 指纹识别！ 自定义的触控栏！ 15.5MM！ 雷电3接口！更安静！', '<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255); text-align: center; user-select: auto !important;\"><img src=\"http://img10.hqbcdn.com/thumbs/product/a2/61/a261e2c6c745e620867922f9d4f2db67.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255); text-align: center; user-select: auto !important;\"><img src=\"http://img1.hqbcdn.com/thumbs/product/5e/f3/5ef3392eb80d13c49bff6e515be79e94.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img13.hqbcdn.com/thumbs/product/ce/68/ce68e21c30103f829dbf1ed18c33a726.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img11.hqbcdn.com/thumbs/product/ee/e4/eee4ddfafd36ac7ed552821c86a8811e.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img16.hqbcdn.com/thumbs/product/38/f6/38f684937260d3ca51ba5637c8a89b71.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img15.hqbcdn.com/thumbs/product/96/81/9681cf8542c0f769ef3ca83d6d39a0f0.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img16.hqbcdn.com/thumbs/product/2f/37/2f37b061f51a5e81d3be33b156f6be4d.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img16.hqbcdn.com/thumbs/product/d6/29/d629e8b8c59c0de59ede55e8dab34220.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img9.hqbcdn.com/thumbs/product/c7/f2/c7f2c58ca7e5245f3c1bb062b0566eb8.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img7.hqbcdn.com/thumbs/product/03/31/03310219dbf239c890f100949365995b.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img7.hqbcdn.com/thumbs/product/da/12/da123208b52847e52c59b5be9707cef6.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img7.hqbcdn.com/thumbs/product/f5/26/f52641593f8f04d0ef1f31ec5945cad1.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img10.hqbcdn.com/thumbs/product/9b/e5/9be5d66856fa6217b7bfe046eb4f9fa8.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img15.hqbcdn.com/thumbs/product/f9/e3/f9e3de0b5d3471cc7596c3f5fb2b0326.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/></p><p><br/></p>', '[\"\\/uploads\\/20170822\\\\dab4a2923c9e5268c74093747db2dbf9.jpg\",\"\\/uploads\\/20170822\\\\8da6d41dc56460d7c40b166bde194fa6.jpg\",\"\\/uploads\\/20170822\\\\a1bdfccfcc597fccb33022aeb364d080.jpg\"]', '/uploads/20170822\\4df1e17d78e699819e671c9cb1ef98c5.jpg', '0', '1', 28, '1', '0', '');
INSERT INTO `gf_goods` VALUES (11, 'Meizu/魅族 魅蓝E2 全网通 双卡双待 手机 月光银 3GB+32GB 官方标配', 10, 1299.00, 1199.00, '', '<p><img src=\"http://img16.hqbcdn.com/thumbs/product/7f/42/7f420dfa0da72323c9cb92a2724e54d8.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img15.hqbcdn.com/thumbs/product/bc/05/bc05339af2ced9d568172dc10b3aeb66.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img12.hqbcdn.com/thumbs/product/e1/d1/e1d1687b710302129466e81660d52789.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img13.hqbcdn.com/thumbs/product/ed/02/ed025ad59b6165d598f0ec0c48162ce8.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img7.hqbcdn.com/thumbs/product/07/d9/07d954eccdacc550790bbcb048e8dc8e.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img14.hqbcdn.com/thumbs/product/85/27/852762220b0c6c514658678e2a493f40.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img3.hqbcdn.com/thumbs/product/46/45/4645980f999544e4ebd64f7613e02d1f.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img2.hqbcdn.com/thumbs/product/e2/68/e2685a802b7df1146b4ac3c73792dbd4.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img11.hqbcdn.com/thumbs/product/9e/43/9e43c62c527fb5cec22404dde471c3f7.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img5.hqbcdn.com/thumbs/product/17/64/176470aabfcb4e84219a3197914d0b2a.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img13.hqbcdn.com/thumbs/product/44/15/44159f9e1385d7a821652cd2ff76007f.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img7.hqbcdn.com/thumbs/product/c2/ad/c2ad6bcb05c941d993bbc9915cfe31f4.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img13.hqbcdn.com/thumbs/product/28/5d/285d9e10de5c4973633d67f41c693cdc.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img5.hqbcdn.com/thumbs/product/2c/7a/2c7a5f2e1eea9c7691fb00c39502ad0d.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img10.hqbcdn.com/thumbs/product/60/1a/601ab1bbce140abe5e02350cb978568d.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img13.hqbcdn.com/thumbs/product/53/99/5399de7586740262ec25b4100b8879eb.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img6.hqbcdn.com/thumbs/product/5d/2b/5d2b11c678bbeb4f7dde1b8aa80acae5.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img6.hqbcdn.com/thumbs/product/0f/be/0fbe387477f1fe37a84e2ceeb693ceec.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img15.hqbcdn.com/thumbs/product/3e/06/3e06e525c89a332f40e6912034045d2f.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img3.hqbcdn.com/thumbs/product/4b/3a/4b3ae4adfdab6f1ed09e9c5b2e2187b8.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img13.hqbcdn.com/thumbs/product/fe/49/fe492d14a7e9fcdc0423e30a353856db.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img14.hqbcdn.com/thumbs/product/8c/93/8c9300db0d387ed0584b820ab20fbb93.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img2.hqbcdn.com/thumbs/product/5b/1a/5b1a9f9eae6ba1652df5376bdd06b9f7.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img14.hqbcdn.com/thumbs/product/27/4b/274b0c7c038b2cc41adcc60799009711.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img12.hqbcdn.com/thumbs/product/20/44/2044097a6260505b7ae42a90c014e227.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img1.hqbcdn.com/thumbs/product/b5/8e/b58ee13cf63cf7afe1e1bcb84914fa4e.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img16.hqbcdn.com/thumbs/product/90/91/9091c923b484e1c9a7d34b652a30c2ad.png\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/></p>', '[\"\\/uploads\\/20170822\\\\c76cb71ca5ca8a0239d90b76c5733d71.png\",\"\\/uploads\\/20170822\\\\c2e1141f2b796b2c5c0374576f312878.png\",\"\\/uploads\\/20170822\\\\cfb7f51711f9b73da71c2b9776274b16.png\"]', '/uploads/20170822\\89a19996ab72ca61bf99991638683425.jpg', '0', '1', 17, '0', '0', '');
INSERT INTO `gf_goods` VALUES (12, 'Apple/苹果 iPhone 7 Plus HK 海淘手机 亮黑色 128GB', 18, 8988.00, 5888.00, '全新64位架构四核心A10处理器，12MP大光圈光学防抖摄像头，双扬声器立体音效果，精细防尘抗水，奥妙全在其中', '<p style=\"text-align: center;\"><img src=\"http://img12.hqbcdn.com/thumbs/product/86/7f/867f719c42956820926c708054e5a981.jpg\"/></p>', '[\"\\/uploads\\/20170822\\\\85bfaa6ba6d1e7f8018c0b253e284441.png\",\"\\/uploads\\/20170822\\\\1296e15b64420bdcb57f1c99a8488614.png\",\"\\/uploads\\/20170822\\\\f4ffbe348824bd91c61fca873b091ffd.png\"]', '/uploads/20170822\\1068521a62f8819395f2634f3e01d486.jpg', '0', '1', 2, '1', '0', '');
INSERT INTO `gf_goods` VALUES (13, 'Apple/苹果 MacBook air 13.3英寸 2017年 MQD32CH/A 128GB', 21, 6988.00, 6188.00, '', '<p style=\"text-align: center;\"><img src=\"http://img3.hqbcdn.com/thumbs/product/a2/57/a257415880dcbfe24e176045f81fa9dc.jpg\"/></p>', '[\"\\/uploads\\/20170822\\\\aa7a72cb46a2b2106985f2489fa2be44.jpg\",\"\\/uploads\\/20170822\\\\0051f723ad35a381f44274bc6a182452.jpg\",\"\\/uploads\\/20170822\\\\4541a20138aa007de1fbb852e5bd0c98.jpg\"]', '/uploads/20170822\\038356d2d382443e545ab969fe829369.jpg', '0', '1', 0, '0', '0', '');
INSERT INTO `gf_goods` VALUES (14, 'Huawei/华为 Mate 9 全网通 双卡双待手机 4GB+64GB 摩卡金', 9, 4588.00, 3099.00, '专业相机 差点入门 麒麟芯片 960 快 令人惊叹', '<p style=\"text-align: center;\"><img src=\"http://img9.hqbcdn.com/thumbs/product/08/72/08721307d241ad7f81aed5ad91ae6fb1.jpg\"/><br/></p>', '[\"\\/uploads\\/20170822\\\\52f7a80efd1cbd7f6793afd3e28c08bd.jpg\",\"\\/uploads\\/20170822\\\\029b763dcf1030fb128f76ebf1e39d76.jpg\",\"\\/uploads\\/20170822\\\\8a81f5b8c121828b2cdabde2e686d764.jpg\"]', '/uploads/20170822\\027bc97109746b7c781118eae78d4a59.jpg', '0', '1', 0, '0', '0', '');
INSERT INTO `gf_goods` VALUES (15, 'Meizu/魅族 PRO 6s 全网通 双卡双待 手机 4GB+64GB 星空黑', 10, 2699.00, 1899.00, '光学防抖动相机 十核跑的更快! HI-FI 干净有力精准忠实!', '<p style=\"text-align: center;\"><img src=\"http://img2.hqbcdn.com/thumbs/product/87/6f/876fc8aa3ae1986d13a59a5f650a09f1.jpg\"/></p>', '[\"\\/uploads\\/20170822\\\\0ee2608ee3eb9d46fb89aa529faa5126.jpg\",\"\\/uploads\\/20170822\\\\fc7b21062abdcb41ee08d01ba765d196.jpg\",\"\\/uploads\\/20170822\\\\b917943d842525b7f5d0d797e875c269.jpg\"]', '/uploads/20170822\\978e181870daec825b3a298f0daefe1c.jpg', '0', '1', 0, '0', '0', '');
INSERT INTO `gf_goods` VALUES (16, 'Apple/苹果 iPod touch 6 音乐播放器 金色 64GB', 20, 2599.00, 2138.00, '【正品保障 全国联保】超稳定性能、随买随用！无需承担繁琐操作所带来的风险！！限购二台', '<p style=\"text-align: center;\"><img src=\"http://img16.hqbcdn.com/thumbs/product/bd/02/bd02d75091826c550c623e3c160600b1.jpg\"/></p>', '[\"\\/uploads\\/20170822\\\\ba49ad8317f3d78580cd9da79abc67e5.jpg\",\"\\/uploads\\/20170822\\\\3c404706b23a7e1fb17e1daa1b5b7c34.jpg\",\"\\/uploads\\/20170822\\\\15a643a79e53f5f234c9936c1e9dee95.jpg\"]', '/uploads/20170822\\cdcd9dd144f0663523b8941d0efe3e0c.jpg', '0', '1', 0, '1', '0', '');
INSERT INTO `gf_goods` VALUES (17, 'Apple/苹果 Apple EarPods iPhone/iPad/iPod 原装线控耳机 HK 白色', 24, 135.00, 65.00, '【苹果原装全球零售版耳机，兼容所有苹果设备以及大部分主流设备，低音更强】', '<p style=\"text-align: center;\"><img src=\"http://img4.hqbcdn.com/thumbs/product/f3/c4/f3c4b91af26ad6af73f0464f6cc6950a.jpg\"/></p>', '[\"\\/uploads\\/20170822\\\\840845651b8a3cb6b6f758033d467c55.jpg\",\"\\/uploads\\/20170822\\\\a277bbddb356d3833b6a74775bee24ae.jpg\",\"\\/uploads\\/20170822\\\\a0ca7d3ae7a86cf82ecf37d4b61425f1.jpg\"]', '/uploads/20170822\\6b54b54c8f474c0cb8215e1d255c2dd8.jpg', '0', '1', 1, '0', '0', '');
INSERT INTO `gf_goods` VALUES (18, 'Apple/苹果 Lightning to USB iPhone/iPad/iPod原装数据线 白色带包装', 24, 149.00, 53.00, '苹果原装！正品保证！全网最低，传输更快更稳定！', '<p style=\"text-align: center;\"><img src=\"http://img5.hqbcdn.com/thumbs/product/55/ea/55ea3d5b9b40bbf73f823ae52309023e.jpg\"/><br/></p>', '[\"\\/uploads\\/20170822\\\\901f1efcab121b8d85c572c9bbed6827.jpg\",\"\\/uploads\\/20170822\\\\9da65ec546ddbb58f26b2f9480bfe91a.jpg\",\"\\/uploads\\/20170822\\\\a1068a3386f2868324f2ea67646c51a1.jpg\"]', '/uploads/20170822\\c1397d2e3be74114327f3b67152ced9f.png', '1', '1', 0, '0', '0', '');
INSERT INTO `gf_goods` VALUES (19, 'Huawei/华为 Mate 9 PRO 全网通版 双卡双待 手机 4GB+64GB 琥珀金', 9, 5999.00, 3888.00, '曲面2K屏~双摄~网络更广~细品之美!', '<p style=\"text-align: center;\"><img src=\"http://img12.hqbcdn.com/thumbs/product/a0/70/a0705dfdbf8caf155aa9f09c8c7feff8.jpg\"/><br/></p>', '[\"\\/uploads\\/20170823\\\\fad1682289aea7d209370c343c1626f5.jpg\",\"\\/uploads\\/20170823\\\\fc39eda7c8919bb7b6ab94993ad8fa7d.jpg\",\"\\/uploads\\/20170823\\\\f3e7c013453ccbd4a1c2198e4847fa4c.jpg\"]', '/uploads/20170823\\afcb249945e43dae4a9bae3d1909b26c.jpg', '1', '0', 0, '0', '0', '');
INSERT INTO `gf_goods` VALUES (20, 'Huawei/华为 荣耀V9 全网通4G 手机 6GB+64GB 幻夜黑', 9, 3599.00, 2728.00, '黑白+彩色双1200万像素平行镜头，5.7英寸2K屏，搭载麒麟960芯片，4000mAh电池长久续航', '<p style=\"text-align: center;\"><img src=\"http://img12.hqbcdn.com/thumbs/product/80/d2/80d2717d0cdb10c1d124e4314600c697.png\"/><br/></p>', '[\"\\/uploads\\/20170823\\\\d4ad0c2572eab0f87b7890e1f192991b.png\",\"\\/uploads\\/20170823\\\\a29f4856e55d14c5a16088722efcfb42.png\",\"\\/uploads\\/20170823\\\\d12c6a5cf6ba9fa18085614cd0dad7e2.png\"]', '/uploads/20170823\\12dfce25a6d34d5b9f9cde265acfe25c.jpg', '0', '1', 1, '0', '0', '');
INSERT INTO `gf_goods` VALUES (21, 'MI/小米 小米平板3 WIFI版 7.9英寸 平板 4G+64GB 香槟金', 11, 1699.00, 1628.00, '', '<p style=\"text-align: center;\"><img src=\"http://img13.hqbcdn.com/thumbs/product/b9/59/b9596b3ebc97adf563cd22428b189597.jpg\"/></p>', '[\"\\/uploads\\/20170823\\\\b5baea00d156af13cc3407a9afc3f53c.jpg\",\"\\/uploads\\/20170823\\\\5f8faff611d3bc0723c0eeb7517d69c4.jpg\",\"\\/uploads\\/20170823\\\\0d089efb7eb507b48c2329c17a38fbc3.jpg\"]', '/uploads/20170823\\95475f3d70740fcb16221f24fc9923aa.jpg', '0', '1', 0, '0', '0', '');
INSERT INTO `gf_goods` VALUES (22, 'vivo X7 全网通 手机 玫瑰金', 17, 2498.00, 2088.00, '『正品行货 全国联保』享受国家假一赔三、七天退货优质服务！商品定价全网钜低，由品牌商指导授权，部份特惠机型数量有限，售完即止！仓储QC人员抽检发货，确保到手使用无忧！', '<p style=\"text-align: center;\"><img src=\"http://img4.hqbcdn.com/thumbs/product/de/5f/de5f94ba728dbe5746c09f4365cfc69a.jpg\"/></p>', '[\"\\/uploads\\/20170823\\\\2f637f562561e61679044d3c8ec5174e.jpg\",\"\\/uploads\\/20170823\\\\a90d4cc1e96cf09db6fd2b067cb45d4b.jpg\",\"\\/uploads\\/20170823\\\\99fe0a149d031e55f8d244e80e669bfc.jpg\"]', '/uploads/20170823\\d39d3afaf7b8dea95e23d596ed7da407.jpg', '0', '0', 0, '0', '0', '');
INSERT INTO `gf_goods` VALUES (23, 'Huawei/华为 荣耀畅玩6X 全网通手机 标配 3GB+32GB 铂光金', 9, 1499.00, 1099.00, '5.5寸屏 后置双摄像头 2.5屏幕 金属弧面机身 指纹新定意', '<p style=\"text-align: center;\"><img src=\"http://img3.hqbcdn.com/thumbs/product/00/36/0036a8fc98a628b6b94636d0a5ae3009.jpg\"/></p>', '[\"\\/uploads\\/20170823\\\\e78ac119eeb0ce9b4bcbc249af8eb36b.jpg\",\"\\/uploads\\/20170823\\\\ec100845db5b5c244699907ab305a3db.jpg\",\"\\/uploads\\/20170823\\\\fef46cb87ad0e9575672bfb3352ebed4.jpg\"]', '/uploads/20170823\\d8faa1ae98bc8e1b780ae7e92f4572e2.jpg', '0', '0', 1, '0', '0', '');
INSERT INTO `gf_goods` VALUES (24, 'Meitu/美图 M8 全网通4G 手机 4GB+64GB 樱花粉', 71, 2999.00, 2788.00, '', '<p style=\"text-align: center;\"><img src=\"http://img3.hqbcdn.com/thumbs/product/21/4a/214afed983e1cf1afde1a831f82ec741.jpg\"/></p>', '[\"\\/uploads\\/20170823\\\\9de2b422cb2cd301d4b450044e8ea731.png\",\"\\/uploads\\/20170823\\\\16bd422119af9b04bcca96830655b77f.png\",\"\\/uploads\\/20170823\\\\185a4986ccc3a9dc20263d5bf5afcbb6.png\"]', '/uploads/20170823\\2e83c8ccf6a1f42f335a643887de9995.png', '1', '0', 0, '0', '0', '');
INSERT INTO `gf_goods` VALUES (25, 'OPPO R11 全网通4G 双卡双待手机 4GB+64GB 黑色', 13, 2999.00, 2899.00, '', '<p style=\"text-align: center;\"><img src=\"http://img5.hqbcdn.com/thumbs/product/86/27/8627fc8035c5dff3f1be066263099dc8.jpg\"/><br/></p>', '[\"\\/uploads\\/20170823\\\\7fa3a45ae9fd17c652785193aae02fc0.png\",\"\\/uploads\\/20170823\\\\c0af85e40f3638ce03d7b61e4c3de3dc.png\",\"\\/uploads\\/20170823\\\\aac4bbb1996e1e75f3a91e4ff32a4ccc.png\"]', '/uploads/20170823\\3bee117a659af807119ebc2ab32bf6d0.png', '1', '0', 0, '0', '0', '');
INSERT INTO `gf_goods` VALUES (26, 'Huawei/华为 荣耀9 全网通 手机 6GB+128GB 幻夜黑', 9, 2999.00, 2888.00, '2000万变焦双摄，3D曲面极光玻璃，美得有声有色！', '<p style=\"text-align: center;\"><img src=\"http://img5.hqbcdn.com/thumbs/product/a8/19/a819a6f92cb36cbf0d5f963b3f85ab96.png\"/></p>', '[\"\\/uploads\\/20170823\\\\97b76717d92eab8f482b30a59f3c0593.jpg\",\"\\/uploads\\/20170823\\\\43c8f4cb54d9ff5204cc92033b0a1f95.jpg\",\"\\/uploads\\/20170823\\\\f97b8abec333de12ae267c1fdbd62bf2.png\"]', '/uploads/20170823\\f8c9c070c8523dd9d19b7b7236611bf9.jpg', '0', '1', 24, '0', '0', '/uploads/20170823/bd902404c3fdb9733ef70fb1eee5051d.jpg');
INSERT INTO `gf_goods` VALUES (27, 'Samsung/三星 GALAXY S8 双卡双待 全网通 手机 枫叶金 4+64GB', 12, 5999.00, 5599.00, '', '<p style=\"text-align: center;\"><img src=\"http://img13.hqbcdn.com/thumbs/product/99/ce/99ce8707d5b2811d2975b18f59a45954.jpg\"/><br/></p>', '[\"\\/uploads\\/20170823\\\\3627fd86b8a6502ab62c205bd88ddc97.jpg\",\"\\/uploads\\/20170823\\\\1a50dd1b940972d1d6f8c48fd9f49d0e.jpg\",\"\\/uploads\\/20170823\\\\be30c9d26abc1077efcb004f5baf034f.jpg\"]', '/uploads/20170823\\6fb3654f7480190b4c35c05fb9bc9768.jpg', '0', '1', 8, '0', '1', '/uploads/20170823/1162c0db364b76fe2462ea87bb8b49d7.jpg');
INSERT INTO `gf_goods` VALUES (28, 'WACACO Minipresso 便携式手动咖啡机 手压迷你咖啡机 经典咖啡粉款', 51, 499.00, 399.00, '', '<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255); text-align: center; user-select: auto !important;\"><br/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255); user-select: auto !important;\"><img src=\"http://img2.hqbcdn.com/thumbs/product/c3/33/c333c035734fd2b3f8655617732ebc19.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img5.hqbcdn.com/thumbs/product/c8/86/c88618c2445e1c2d7a61ff86de7cdc85.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img2.hqbcdn.com/thumbs/product/31/4a/314aed564612a8cd772432cbc2c019a5.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img9.hqbcdn.com/thumbs/product/6e/63/6e63be9d6fe23644ab3f0dacdabbce79.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img2.hqbcdn.com/thumbs/product/62/22/62228523d5294c588727f8f193e5c4f2.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img11.hqbcdn.com/thumbs/product/ff/f0/fff017200ebc96e38a9b9f704cd4731f.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img5.hqbcdn.com/thumbs/product/e5/8d/e58dddb2a75b719a23cbd6ac05d98390.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img9.hqbcdn.com/thumbs/product/33/a8/33a83a30feec0586a55eefa2b70fa3b2.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img8.hqbcdn.com/thumbs/product/ed/76/ed76d33d47801d8e658e6d0c0e91916a.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img12.hqbcdn.com/thumbs/product/3e/b5/3eb521d7c1271b0323596d59d3a6b836.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img12.hqbcdn.com/thumbs/product/65/b6/65b65a6852d056116724386811e41d34.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img1.hqbcdn.com/thumbs/product/8f/34/8f34b8393aa3795ee4965caaedae121c.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img9.hqbcdn.com/thumbs/product/2d/ed/2dedc1950ac7ac5a303969f7b92413d9.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img1.hqbcdn.com/thumbs/product/99/3c/993cc06b7eb550a9a3981211437c3226.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img15.hqbcdn.com/thumbs/product/36/76/3676779feab184f7bad551953bc556c1.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/><img src=\"http://img13.hqbcdn.com/thumbs/product/cf/da/cfda53a31f598929a009f9945d33d920.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block;\"/></p><p style=\"text-align: center;\"><br/></p>', '[\"\\/uploads\\/20170823\\\\6aab831f19edeb173b3f2920c19625dc.jpg\",\"\\/uploads\\/20170823\\\\fb4e1f2fc0da7c9af227acdf29a644b8.jpg\",\"\\/uploads\\/20170823\\\\60d22b9c22d10955587b701be7b7b964.jpg\"]', '/uploads/20170823\\a7a3c72c0e431388b72d8e233be8f62c.jpg', '0', '1', 3, '0', '0', '');
INSERT INTO `gf_goods` VALUES (29, 'ROCK/洛克 卡通十二生肖苹果数据线 Lightning接口充电线 支持ios8、9、10 100CM 白狗', 27, 38.00, 39.00, '', '<p style=\"text-align: center;\"><img src=\"http://img8.hqbcdn.com/thumbs/product/2b/fe/2bfedd516dc513b8fa9de86c7db69324.jpg\"/></p>', '[\"\\/uploads\\/20170823\\\\9c15e3d74a32c4e4462dfa4b4ef0cce1.jpg\",\"\\/uploads\\/20170823\\\\2c11eb78549b9696a7130658174e10d2.jpg\",\"\\/uploads\\/20170823\\\\671bfb6281e9335447f4f3c641470bab.jpg\"]', '/uploads/20170823\\832cd3276e74b9645e77271f1a167fc2.jpg', '0', '0', 5, '0', '0', '');
INSERT INTO `gf_goods` VALUES (30, 'Apple/苹果 MLA02CH/A 蓝牙无线鼠标 magic mouse2原装正品国行 白色', 34, 599.00, 538.00, '2代新品 可充电 含充电线', '<p style=\"text-align: center;\"><img src=\"http://img10.hqbcdn.com/thumbs/product/7e/a2/7ea2dcab9ca0cd1d5d24b0a9e766f93a.jpg\"/><br/></p>', '[\"\\/uploads\\/20170823\\\\cf23aefbaf124c8cf34444433b82ef5d.jpg\",\"\\/uploads\\/20170823\\\\1a4d7603b570340f56ff829975da171d.jpg\",\"\\/uploads\\/20170823\\\\30035241c098134fb02e4ac777d09c70.jpg\"]', '/uploads/20170823\\a23229f763c7ae7cef217c57432a8acb.jpg', '0', '1', 1, '0', '0', '');
INSERT INTO `gf_goods` VALUES (31, 'lenovo/联想 YOGA910（YOGA5 PRO）13.9英寸超轻薄触控笔记本电脑 i7-7500 16G 1TBSSD', 31, 11999.00, 11999.00, '', '<p style=\"text-align: center;\"><img src=\"http://img6.hqbcdn.com/thumbs/product/e5/ae/e5aeaec2dce771db81312921c8cfc2e9.jpg\"/></p>', '[\"\\/uploads\\/20170823\\\\6d1b294f2892a427a5c4f4dc217b9940.jpg\",\"\\/uploads\\/20170823\\\\f6f7f8c17e2bb1889485e321700daa48.jpg\",\"\\/uploads\\/20170823\\\\31a54dc40c4bad4c44b6baf5759ac8c6.jpg\"]', '/uploads/20170823\\e235531e8a1b998043c252461da19687.jpg', '0', '1', 0, '0', '0', '');
INSERT INTO `gf_goods` VALUES (32, 'DM WFD028 无线苹果手机电脑两用U盘 可以做5000mAh移动电源U盘 白色 128G', 37, 599.00, 499.00, '无线存储 多人连接 移动电源 5000毫安', '<p style=\"text-align: center;\"><img src=\"http://img3.hqbcdn.com/thumbs/product/e7/d3/e7d30d0fe7243f59e224bd2ea9aafe93.jpg\"/><br/></p>', '[\"\\/uploads\\/20170823\\\\dbf086c55ae194a6d7e936a74cbfa9b2.jpg\",\"\\/uploads\\/20170823\\\\1e46613c258c61fe492a9b3e6304b6b7.jpg\",\"\\/uploads\\/20170823\\\\24205eaca7b736e01e8fccbc0036edc2.jpg\"]', '/uploads/20170823\\805461f816f192e9b196c64a501e1b79.jpg', '0', '0', 1, '0', '0', '');
INSERT INTO `gf_goods` VALUES (33, 'Microsoft/微软 XBOX ONE 体感游戏主机 家用游戏机 含有Kinect版 国行标配', 66, 4699.00, 3999.00, '众多精彩功能陆续上线，选择国行Xbox，您值得期待！', '<p style=\"text-align: center;\"><img src=\"http://img15.hqbcdn.com/product/a6/5e/a65e06cf51e5a71477f2c12bfda56d35.jpg\"/><br/></p>', '[\"\\/uploads\\/20170823\\\\81edbae77ac16efaa6f77121c5dae411.jpg\",\"\\/uploads\\/20170823\\\\c791227e99e4c76da85b8fd7fd1bc993.jpg\",\"\\/uploads\\/20170823\\\\40ef8409b32a0246b59216b6b1689969.jpg\"]', '/uploads/20170823\\78a28821ba489a60adf10a8b983897fc.jpg', '0', '0', 0, '0', '0', '');
INSERT INTO `gf_goods` VALUES (34, 'Nikon/尼康 D5全画幅单反相机 单机不带镜头XQD', 59, 43500.00, 43499.00, '', '<p style=\"text-align: center;\"><img src=\"http://img2.hqbcdn.com/thumbs/product/ca/4d/ca4d055a16d733a8c831084d87643319.jpg\"/></p>', '[\"\\/uploads\\/20170823\\\\3de4b9f172715ed0c2d6207fd91ae8d7.jpg\",\"\\/uploads\\/20170823\\\\a4d04dfd3d87f6e4beace570924c4c6f.jpg\",\"\\/uploads\\/20170823\\\\ea9b4ab0072f05733865adb88428e087.jpg\"]', '/uploads/20170823\\26764d6d1e9c96ae5cf3fa9e1af5ae33.jpg', '0', '0', 0, '0', '0', '');
INSERT INTO `gf_goods` VALUES (35, 'Huawei/华为 荣耀智能手表S1运动实时心率监测 游泳防水 支持苹果IOS和安卓 香槟金-黑色短腕带', 49, 799.00, 599.00, '全天候心率检测+科学跑步指导，你的私人运动教练', '<p style=\"text-align: center;\"><img src=\"http://img16.hqbcdn.com/thumbs/product/9b/36/9b36b699f06f6b151e109a545b3305c9.jpg\"/></p>', '[\"\\/uploads\\/20170823\\\\7e514596a9e32c568cecbe527a18747c.jpg\",\"\\/uploads\\/20170823\\\\5409e36949d904215e178695c54c886b.jpg\",\"\\/uploads\\/20170823\\\\56b8a968fdb5c9a643ae782a051e9b47.jpg\"]', '/uploads/20170823\\c4a3e2ed552930a84fdb06f380c46e23.jpg', '0', '0', 1, '0', '1', '');
INSERT INTO `gf_goods` VALUES (36, 'QIBAO/其宝 大白家用静音无辐射户外孕妇婴儿灭蚊灯 LED电击式 捕蚊器 驱蚊灯 白色', 49, 48.00, 38.00, '', '<p style=\"text-align: center;\"><img src=\"http://img3.hqbcdn.com/thumbs/product/f9/1d/f91d9c5e5e0cbc1992d4c22ba19864ca.jpg\"/></p>', '[\"\\/uploads\\/20170823\\\\f54ef07985d96c53c100b6e33f472f3b.jpg\",\"\\/uploads\\/20170823\\\\3c727d2067de3a65a85e1293cc567da6.jpg\",\"\\/uploads\\/20170823\\\\352edc1c712b0f86f162dbbcc89f67a5.jpg\"]', '/uploads/20170823\\2bb382e635af1ab62b40b357bf3fbf3f.jpg', '0', '0', 0, '0', '1', '');
INSERT INTO `gf_goods` VALUES (37, 'XIRO/零度 DOBBY口袋无人机 迷你遥控航拍飞行器高清无人机 官方标配', 54, 2499.00, 2399.00, '三轴电子防抖 高清摄像头 折叠技术', '<p style=\"text-align: center;\"><img src=\"http://img8.hqbcdn.com/thumbs/product/d7/6d/d76de9dcaf1f4461bcd81f370d9b0b64.jpg\"/></p>', '[\"\\/uploads\\/20170823\\\\8f02df0bc5779de7aa8194c34f2b73b1.jpg\",\"\\/uploads\\/20170823\\\\53aa9ef73b6245e27d4e48b0c4912db9.jpg\",\"\\/uploads\\/20170823\\\\4681b3cd4b17af4704d5efcc72f876e4.jpg\"]', '/uploads/20170823\\480a87f402fad1dd738a758f5f988d59.jpg', '0', '0', 0, '0', '1', '');
INSERT INTO `gf_goods` VALUES (38, 'Huawei/华为 P10 全网通4G 双卡双待手机 4GB+128GB 陶瓷白', 9, 4899.00, 3788.00, '华为P10的故事~徕卡镜头~可以刷地铁卡~WIFI双天线~多彩设计~快人一步!', '<p style=\"text-align: center;\"><img src=\"http://img7.hqbcdn.com/thumbs/product/a2/a0/a2a06faec29feea6511d8fdd6e8f654a.png\"/><br/></p>', '[\"\\/uploads\\/20170823\\\\887465ddefccd7f9b860c256d667d448.png\",\"\\/uploads\\/20170823\\\\22035cde3710fe28efec74d07ef9565b.png\",\"\\/uploads\\/20170823\\\\dcee1e74cfa7b883090341093732a8c5.png\"]', '/uploads/20170823\\1a937e5cf93a43ebf3c739db4d51ed7e.png', '0', '0', 0, '0', '0', '/uploads/20170823/d3d69f28faab1ec72a48394678b70693.jpg');
INSERT INTO `gf_goods` VALUES (39, 'Huawei/华为 Mate 9 全网通 双卡双待手机 4GB+64GB 摩卡金', 9, 4588.00, 3099.00, '专业相机 差点入门 麒麟芯片 960 快 令人惊叹', '<p style=\"text-align: center;\"><img src=\"http://img13.hqbcdn.com/thumbs/product/fb/a6/fba638bc8b794d56de63cd0246323185.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img4.hqbcdn.com/thumbs/product/aa/18/aa185f1a4aae05531fd6d713bdc501e2.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img10.hqbcdn.com/thumbs/product/2e/2a/2e2af25ff728c0c25ab642b801caa43a.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img12.hqbcdn.com/thumbs/product/b8/98/b898ddbbbf76d6d4bd0e5c8a5bc1ac96.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img10.hqbcdn.com/thumbs/product/fa/eb/faeba37f52514f738b35f1f7b2dd1a75.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img10.hqbcdn.com/thumbs/product/2a/7e/2a7ecd873086966eea523e5d66b03c71.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/><img src=\"http://img9.hqbcdn.com/thumbs/product/08/72/08721307d241ad7f81aed5ad91ae6fb1.jpg\" alt=\"\" style=\"border: 0px; margin: 0px auto; padding: 0px; display: block; color: rgb(68, 68, 68); font-family: 微软雅黑; font-size: 12px; text-align: center; white-space: normal; background-color: rgb(255, 255, 255);\"/></p><br/>', '[\"\\/uploads\\/20170823\\\\9c736f2af756f886d494f09abc9c29d7.jpg\",\"\\/uploads\\/20170823\\\\1d8da61658f20cf5f082725c42d649fe.jpg\",\"\\/uploads\\/20170823\\\\51a0c596fc05d7315ca6f087b29e10f4.jpg\"]', '/uploads/20170823\\2d9566e7b39246787134c892e6392b08.jpg', '1', '0', 18, '0', '0', '/uploads/20170823/d9629ef3d0dc1a58f60f5359d2edf6c4.jpg');

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
) ENGINE = MyISAM AUTO_INCREMENT = 161 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '货品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gf_goods_sort
-- ----------------------------
INSERT INTO `gf_goods_sort` VALUES (45, '4.7英寸|金色|32GB', 14, 1);
INSERT INTO `gf_goods_sort` VALUES (44, '4.7英寸|黑色|32GB', 31, 1);
INSERT INTO `gf_goods_sort` VALUES (43, '5.5英寸|白色|64GB', 12, 1);
INSERT INTO `gf_goods_sort` VALUES (49, '2017年Pro 13英寸|MF839CH/A(128GB)', 15, 2);
INSERT INTO `gf_goods_sort` VALUES (48, '6GB|64GB|静谧黑', 35, 4);
INSERT INTO `gf_goods_sort` VALUES (47, '4GB|128GB|香槟金', 12, 4);
INSERT INTO `gf_goods_sort` VALUES (46, '4GB|128GB|静谧黑', 31, 4);
INSERT INTO `gf_goods_sort` VALUES (50, ' Pro 13英寸|MF839CH/A(128GB)', 25, 2);
INSERT INTO `gf_goods_sort` VALUES (20, 'iPhone7 Plus 国行红色|红色128G', 34, 5);
INSERT INTO `gf_goods_sort` VALUES (21, 'iPhone7 国行红色|红色128G', 5, 5);
INSERT INTO `gf_goods_sort` VALUES (22, 'iPhone7 Plus|红色128G', 43, 5);
INSERT INTO `gf_goods_sort` VALUES (23, 'iPhone7|红色128G', 125, 5);
INSERT INTO `gf_goods_sort` VALUES (24, '4.7英寸|金色16GB', 6, 6);
INSERT INTO `gf_goods_sort` VALUES (25, '4.7英寸|银色16GB', 20, 6);
INSERT INTO `gf_goods_sort` VALUES (26, '5.5英寸|银色32GB', 120, 6);
INSERT INTO `gf_goods_sort` VALUES (150, 'iPhone7 国行红色|玫瑰金色 256G', 39, 7);
INSERT INTO `gf_goods_sort` VALUES (149, 'iPhone7 Plus|玫瑰金色 32G', 41, 7);
INSERT INTO `gf_goods_sort` VALUES (148, 'iPhone7|玫瑰金色 32G', 12, 7);
INSERT INTO `gf_goods_sort` VALUES (34, '金色 16GB', 15, 8);
INSERT INTO `gf_goods_sort` VALUES (35, '银色 16GB', 11, 8);
INSERT INTO `gf_goods_sort` VALUES (36, '深空灰色 16GB', 54, 8);
INSERT INTO `gf_goods_sort` VALUES (37, '玫瑰金色 16GB', 44, 8);
INSERT INTO `gf_goods_sort` VALUES (38, '金色 64GB', 55, 8);
INSERT INTO `gf_goods_sort` VALUES (39, '银色 64GB', 13, 8);
INSERT INTO `gf_goods_sort` VALUES (40, '深空灰色 64GB', 12, 8);
INSERT INTO `gf_goods_sort` VALUES (41, '玫瑰金色 64GB', 123, 8);
INSERT INTO `gf_goods_sort` VALUES (42, '金色16GB', 26, 9);
INSERT INTO `gf_goods_sort` VALUES (51, 'Air 11英寸|MLL42CH 256G 深空灰色', 221, 10);
INSERT INTO `gf_goods_sort` VALUES (52, 'Pro 13英寸|MNQG2CH 512 银', 21, 10);
INSERT INTO `gf_goods_sort` VALUES (53, 'Pro 15英寸|MNQF2CH 512 深空灰色 ', 152, 10);
INSERT INTO `gf_goods_sort` VALUES (54, 'Air 新款 12英寸|MLL42CH 256G 深空灰色', 31, 10);
INSERT INTO `gf_goods_sort` VALUES (55, '新款Pro 13英寸|MLUQ2CH 256G 银色', 97, 10);
INSERT INTO `gf_goods_sort` VALUES (56, '新款Pro 15英寸|MLH12CH 256G 深空灰色', 13, 10);
INSERT INTO `gf_goods_sort` VALUES (57, '2017年Pro 13英寸|MLVP2CH 256G 银色', 33, 10);
INSERT INTO `gf_goods_sort` VALUES (58, '香槟金 4GB+64GB', 312, 11);
INSERT INTO `gf_goods_sort` VALUES (59, '月光银 3GB+32GB', 15, 11);
INSERT INTO `gf_goods_sort` VALUES (60, '月光银 4GB+64GB', 12, 11);
INSERT INTO `gf_goods_sort` VALUES (61, ' 香槟金 3GB+32GB ', 88, 11);
INSERT INTO `gf_goods_sort` VALUES (62, ' 曜石黑 3GB+32GB', 137, 11);
INSERT INTO `gf_goods_sort` VALUES (63, ' 曜石黑 4GB+64GB', 97, 11);
INSERT INTO `gf_goods_sort` VALUES (64, '5.5英寸|亮黑色 128GB', 12, 12);
INSERT INTO `gf_goods_sort` VALUES (65, '4.7英寸|亮黑色 256GB', 321, 12);
INSERT INTO `gf_goods_sort` VALUES (66, 'MQD42CH/A 256GB', 123, 13);
INSERT INTO `gf_goods_sort` VALUES (67, 'MQD32CH/A 128GB', 21, 13);
INSERT INTO `gf_goods_sort` VALUES (68, 'MT8 全网通|4GB+32GB 苍穹灰', 32, 14);
INSERT INTO `gf_goods_sort` VALUES (69, 'MT8 移动版|4GB+32GB 月光银', 321, 14);
INSERT INTO `gf_goods_sort` VALUES (70, 'MT8 电信版|4GB+64GB 陶瓷白', 21, 14);
INSERT INTO `gf_goods_sort` VALUES (71, 'MT9 全网通|6GB+128GB 黑色', 123, 14);
INSERT INTO `gf_goods_sort` VALUES (72, 'PRO6 全网通|4GB+64GB 星空黑', 12, 15);
INSERT INTO `gf_goods_sort` VALUES (73, 'PRO6S 全网|4GB+64GB 月光银', 54, 15);
INSERT INTO `gf_goods_sort` VALUES (74, 'PRO6 Plus|4GB+64GB 玫瑰金', 123, 15);
INSERT INTO `gf_goods_sort` VALUES (75, 'PRO 6 移动版|4GB+64GB 香槟金', 315, 15);
INSERT INTO `gf_goods_sort` VALUES (76, 'shuffle touch6|银色 16GB', 12, 16);
INSERT INTO `gf_goods_sort` VALUES (77, '国行 nano8|深空灰 64GB', 39, 16);
INSERT INTO `gf_goods_sort` VALUES (78, '白色|5W充电器', 12, 17);
INSERT INTO `gf_goods_sort` VALUES (79, '白色带包装|有线耳机', 463, 17);
INSERT INTO `gf_goods_sort` VALUES (80, '白色|数据线', 143, 17);
INSERT INTO `gf_goods_sort` VALUES (81, '10W充电器', 41, 17);
INSERT INTO `gf_goods_sort` VALUES (82, '数据线+充电器', 32, 17);
INSERT INTO `gf_goods_sort` VALUES (83, '白色|无线耳机', 14, 17);
INSERT INTO `gf_goods_sort` VALUES (84, '白色|5W充电器', 32, 18);
INSERT INTO `gf_goods_sort` VALUES (85, '白色带包装|数据线+充电器', 14, 18);
INSERT INTO `gf_goods_sort` VALUES (86, '白色|数据线', 2, 18);
INSERT INTO `gf_goods_sort` VALUES (87, 'MT8 全网通|4GB+64GB 琥珀金', 32, 19);
INSERT INTO `gf_goods_sort` VALUES (88, 'MT8 电信版|4GB+64GB 银钻灰', 14, 19);
INSERT INTO `gf_goods_sort` VALUES (89, 'MT8 移动版|4GB+64GB 玫瑰金', 10, 19);
INSERT INTO `gf_goods_sort` VALUES (90, 'MT9 PRO|6GB+128GB 银钻灰', 13, 19);
INSERT INTO `gf_goods_sort` VALUES (91, 'V8 全网通|6GB+64GB 极光蓝', 199, 20);
INSERT INTO `gf_goods_sort` VALUES (92, '荣耀8 青春版|6GB+128GB 铂光金', 13, 20);
INSERT INTO `gf_goods_sort` VALUES (93, '4G+64GB 香槟金', 36, 21);
INSERT INTO `gf_goods_sort` VALUES (94, 'X7|金色', 13, 22);
INSERT INTO `gf_goods_sort` VALUES (95, 'Xplay5|玫瑰金', 985, 22);
INSERT INTO `gf_goods_sort` VALUES (96, 'Xplay6|玫瑰金', 147, 22);
INSERT INTO `gf_goods_sort` VALUES (97, '标配 3GB+32GB 冰河银|畅玩5', 142, 23);
INSERT INTO `gf_goods_sort` VALUES (98, ' 尊享 4GB+64GB 冰河银| 5X 公开', 39, 23);
INSERT INTO `gf_goods_sort` VALUES (99, '4GB+64GB 闪耀紫| M8', 33, 24);
INSERT INTO `gf_goods_sort` VALUES (100, '4GB+64GB 闪耀紫|M6', 231, 24);
INSERT INTO `gf_goods_sort` VALUES (101, '4GB+64GB 魅影红|T8', 14, 24);
INSERT INTO `gf_goods_sort` VALUES (102, '4GB+64GB 热力红色|R9', 12, 25);
INSERT INTO `gf_goods_sort` VALUES (103, ' 4GB+64GB 黑色|A37', 83, 25);
INSERT INTO `gf_goods_sort` VALUES (104, 'GB+64GB 金色|R9S PLUS', 74, 25);
INSERT INTO `gf_goods_sort` VALUES (160, '6GB+128GB 琥珀金| V9', 90, 26);
INSERT INTO `gf_goods_sort` VALUES (147, ' 珊瑚蓝 4+64GB', 78, 27);
INSERT INTO `gf_goods_sort` VALUES (146, '兰花灰 6+64GB', 32, 27);
INSERT INTO `gf_goods_sort` VALUES (145, '午夜黑 4+128GB', 127, 27);
INSERT INTO `gf_goods_sort` VALUES (110, '经典咖啡粉款', 887, 28);
INSERT INTO `gf_goods_sort` VALUES (111, '蓝鼠', 3, 29);
INSERT INTO `gf_goods_sort` VALUES (112, '黄牛', 12, 29);
INSERT INTO `gf_goods_sort` VALUES (113, '黄虎', 321, 29);
INSERT INTO `gf_goods_sort` VALUES (114, '白兔', 684, 29);
INSERT INTO `gf_goods_sort` VALUES (115, '绿龙', 745, 29);
INSERT INTO `gf_goods_sort` VALUES (116, '绿蛇', 75, 29);
INSERT INTO `gf_goods_sort` VALUES (117, '蓝马', 95, 29);
INSERT INTO `gf_goods_sort` VALUES (118, '白羊', 324, 29);
INSERT INTO `gf_goods_sort` VALUES (119, '红猴', 212, 29);
INSERT INTO `gf_goods_sort` VALUES (120, '黄鸡', 23, 29);
INSERT INTO `gf_goods_sort` VALUES (121, '粉鸡', 67, 29);
INSERT INTO `gf_goods_sort` VALUES (122, '白狗', 15, 29);
INSERT INTO `gf_goods_sort` VALUES (123, '粉猪', 32, 29);
INSERT INTO `gf_goods_sort` VALUES (124, '白色', 345, 30);
INSERT INTO `gf_goods_sort` VALUES (125, 'i7-7500 16G 1TBSSD', 93, 31);
INSERT INTO `gf_goods_sort` VALUES (126, 'i5-7200 8G 256GSSD WIN10 触摸屏 银色', 124, 31);
INSERT INTO `gf_goods_sort` VALUES (127, '白色 64G ', 354, 32);
INSERT INTO `gf_goods_sort` VALUES (128, ' 白色 32G', 81, 32);
INSERT INTO `gf_goods_sort` VALUES (129, '白色 128G', 16, 32);
INSERT INTO `gf_goods_sort` VALUES (130, '含有Kinect版', 54, 33);
INSERT INTO `gf_goods_sort` VALUES (131, '含有Kinect版', 81, 33);
INSERT INTO `gf_goods_sort` VALUES (132, '单机不带镜头XQD', 354, 34);
INSERT INTO `gf_goods_sort` VALUES (133, '单机身不带镜头CF', 89, 34);
INSERT INTO `gf_goods_sort` VALUES (134, '深空灰-黑色短腕带', 34, 35);
INSERT INTO `gf_goods_sort` VALUES (135, '月光银-橙色短腕带', 78, 35);
INSERT INTO `gf_goods_sort` VALUES (136, '月光银-黑色长腕带', 391, 35);
INSERT INTO `gf_goods_sort` VALUES (137, '深空灰-黑色长腕带', 124, 35);
INSERT INTO `gf_goods_sort` VALUES (138, '香槟金-黑色短腕带', 33, 35);
INSERT INTO `gf_goods_sort` VALUES (139, '小黄人', 75, 36);
INSERT INTO `gf_goods_sort` VALUES (140, '大白|白色', 452, 36);
INSERT INTO `gf_goods_sort` VALUES (141, '官方标配', 98, 37);
INSERT INTO `gf_goods_sort` VALUES (142, 'P10 Plus|4GB+128GB 草木绿', 64, 38);
INSERT INTO `gf_goods_sort` VALUES (143, ' P9 联通定制双4G|4GB+128GB 曜石黑', 184, 38);
INSERT INTO `gf_goods_sort` VALUES (144, ' P9 PLUS 全网通|4GB+64GB 钻雕金', 14, 38);
INSERT INTO `gf_goods_sort` VALUES (151, 'iPhone7 Plus 国行红色|亮黑色 128G', 13, 7);
INSERT INTO `gf_goods_sort` VALUES (152, 'MT9 保时捷|6GB+128GB 摩卡金', 46, 39);
INSERT INTO `gf_goods_sort` VALUES (153, ' MT9 全网通|4GB+32GB 月光银  ', 128, 39);
INSERT INTO `gf_goods_sort` VALUES (154, ' MT9 全网通|4GB+64GB 陶瓷白 ', 3, 39);
INSERT INTO `gf_goods_sort` VALUES (155, 'MT9 PRO|4GB+64GB 摩卡金', 21, 39);
INSERT INTO `gf_goods_sort` VALUES (156, 'MT9 PRO|4GB+64GB 香槟金  ', 154, 39);
INSERT INTO `gf_goods_sort` VALUES (159, '6GB+128GB 海鸥灰|荣耀9', 22, 26);

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
  `order_num` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '订单号',
  `total_price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '价格总计',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '待付款' COMMENT '订单状态（取消，删除，其它是一般状态）',
  `address_id` int(11) NOT NULL DEFAULT 0 COMMENT '收货地址id',
  `user_id` int(11) NOT NULL COMMENT '所属用户id',
  `order_time` int(11) NOT NULL DEFAULT 0 COMMENT '下单时间',
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注说明',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gf_order
-- ----------------------------
INSERT INTO `gf_order` VALUES (3, 'G0822912176', 21763.00, '已付款，未发货', 1, 2, 1503391217, '顺丰快递');
INSERT INTO `gf_order` VALUES (6, 'G0825256153', 11888.00, '待付款', 12, 2, 1503625615, '');
INSERT INTO `gf_order` VALUES (7, 'G0825436885', 5288.00, '已付款，未发货', 2, 2, 1503643688, '止');

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
) ENGINE = MyISAM AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单列表项' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of gf_order_items
-- ----------------------------
INSERT INTO `gf_order_items` VALUES (9, 3, 1599.00, 1, 42);
INSERT INTO `gf_order_items` VALUES (8, 3, 7288.00, 1, 50);
INSERT INTO `gf_order_items` VALUES (7, 3, 7588.00, 1, 23);
INSERT INTO `gf_order_items` VALUES (6, 3, 5288.00, 1, 24);
INSERT INTO `gf_order_items` VALUES (12, 6, 11888.00, 1, 150);
INSERT INTO `gf_order_items` VALUES (13, 7, 5288.00, 1, 45);

-- ----------------------------
-- Table structure for gf_search_words
-- ----------------------------
DROP TABLE IF EXISTS `gf_search_words`;
CREATE TABLE `gf_search_words`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `search_word` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '搜索关键词',
  `times` int(11) NOT NULL DEFAULT 1 COMMENT '搜索次数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gf_search_words
-- ----------------------------
INSERT INTO `gf_search_words` VALUES (1, '华为', 12);
INSERT INTO `gf_search_words` VALUES (2, '华为苹果', 1);
INSERT INTO `gf_search_words` VALUES (3, 'Apple/苹果 MacBook Air 13.3英寸 2016款 MMGF2CH/A 128GB', 1);
INSERT INTO `gf_search_words` VALUES (4, 'Apple/苹果 iPod touch 6 音乐播放器 金色 64GB', 1);
INSERT INTO `gf_search_words` VALUES (5, '三星', 2);
INSERT INTO `gf_search_words` VALUES (6, 'mac', 8);
INSERT INTO `gf_search_words` VALUES (7, 'Huawei/华为 荣耀畅玩6X 全网通手机 标配 3GB+32GB 铂光金', 1);
INSERT INTO `gf_search_words` VALUES (8, 'I7 128G四色同价', 2);
INSERT INTO `gf_search_words` VALUES (9, '未找到相关结果', 1);
INSERT INTO `gf_search_words` VALUES (10, 'k', 4);
INSERT INTO `gf_search_words` VALUES (11, 'book', 6);
INSERT INTO `gf_search_words` VALUES (12, 'apple', 2);
INSERT INTO `gf_search_words` VALUES (13, 'hk', 2);
INSERT INTO `gf_search_words` VALUES (14, 'iphone', 1);
INSERT INTO `gf_search_words` VALUES (15, 'i', 16);
INSERT INTO `gf_search_words` VALUES (16, 'Apple/苹果 新款 MacBook Pro 13英寸笔记本 MLVP2CH 256G 银色', 6);
INSERT INTO `gf_search_words` VALUES (17, '是', 5);

-- ----------------------------
-- Table structure for gf_users
-- ----------------------------
DROP TABLE IF EXISTS `gf_users`;
CREATE TABLE `gf_users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '前台用户名',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '前台用户密码',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '收货地址',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '前台用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gf_users
-- ----------------------------
INSERT INTO `gf_users` VALUES (2, 'chenhao', 'e10adc3949ba59abbe56e057f20f883e', '');
INSERT INTO `gf_users` VALUES (8, 'chenhao4', 'e10adc3949ba59abbe56e057f20f883e', '');
INSERT INTO `gf_users` VALUES (9, '7777777', 'e10adc3949ba59abbe56e057f20f883e', '');
INSERT INTO `gf_users` VALUES (10, 'chenhao9', 'e10adc3949ba59abbe56e057f20f883e', '');
INSERT INTO `gf_users` VALUES (11, '123456', 'e10adc3949ba59abbe56e057f20f883e', '');

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
) ENGINE = MyISAM AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of gf_view_times
-- ----------------------------
INSERT INTO `gf_view_times` VALUES (1, 2, 26, 9);
INSERT INTO `gf_view_times` VALUES (2, 2, 6, 6);
INSERT INTO `gf_view_times` VALUES (3, 2, 39, 1);
INSERT INTO `gf_view_times` VALUES (4, 2, 2, 1);
INSERT INTO `gf_view_times` VALUES (5, 2, 9, 1);
INSERT INTO `gf_view_times` VALUES (6, 2, 12, 2);
INSERT INTO `gf_view_times` VALUES (7, 2, 5, 1);
INSERT INTO `gf_view_times` VALUES (8, 2, 7, 4);
INSERT INTO `gf_view_times` VALUES (9, 2, 10, 1);
INSERT INTO `gf_view_times` VALUES (10, 2, 1, 3);
INSERT INTO `gf_view_times` VALUES (11, 2, 29, 2);
INSERT INTO `gf_view_times` VALUES (12, 2, 27, 1);

SET FOREIGN_KEY_CHECKS = 1;
