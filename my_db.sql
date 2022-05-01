/*
 Navicat Premium Data Transfer

 Source Server         : node
 Source Server Type    : MySQL
 Source Server Version : 50728
 Source Host           : localhost:3306
 Source Schema         : my_db

 Target Server Type    : MySQL
 Target Server Version : 50728
 File Encoding         : 65001

 Date: 01/05/2022 13:07:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for access
-- ----------------------------
DROP TABLE IF EXISTS `access`;
CREATE TABLE `access`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of access
-- ----------------------------
INSERT INTO `access` VALUES (1, 'access_import');
INSERT INTO `access` VALUES (2, 'access_export');
INSERT INTO `access` VALUES (3, 'access_approval');
INSERT INTO `access` VALUES (4, 'access_template');
INSERT INTO `access` VALUES (5, 'access_user');
INSERT INTO `access` VALUES (6, 'access_role');

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编号',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '抬头',
  `specification` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规格',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '单价',
  `count` int(11) NULL DEFAULT NULL COMMENT '数量',
  `start_date` datetime(0) NULL DEFAULT NULL COMMENT '出场日期',
  `trade_date` datetime(0) NULL DEFAULT NULL COMMENT '交易日期',
  `total_amount` decimal(65, 0) NULL DEFAULT NULL COMMENT '总价',
  `status` int(255) NULL DEFAULT NULL COMMENT '状态',
  `signature` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '签名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of account
-- ----------------------------

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` int(50) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cover_img` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pub_date` datetime(0) NOT NULL,
  `state` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_delete` tinyint(1) UNSIGNED ZEROFILL NOT NULL,
  `cate_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (00000000000000000000000000000000000000000000000001, '小王子', '222', '22', '2022-02-07 17:08:39', '1', 0, 1, 1);
INSERT INTO `article` VALUES (00000000000000000000000000000000000000000000000002, 'pride and prejudise', '123141245', '', '0000-00-00 00:00:00', '??', 0, 2, 0);
INSERT INTO `article` VALUES (00000000000000000000000000000000000000000000000003, 'pride and prejudise', '123141245', '\\uploads\\888bb8d7c79855759404d5fb74b67e30', '2022-02-07 17:36:16', '??', 0, 2, 10);
INSERT INTO `article` VALUES (00000000000000000000000000000000000000000000000004, 'pride and prejudise', '123141245', '\\uploads\\6465d000fc9234d9ecf70da5d5cee3da', '2022-02-07 17:36:35', '草稿', 0, 2, 10);
INSERT INTO `article` VALUES (00000000000000000000000000000000000000000000000005, 'pride and prejudise', '123141245', '\\uploads\\d1847038e6f3be67eb4b6fff217ffb64', '2022-02-07 17:36:56', '已发布', 0, 2, 10);

-- ----------------------------
-- Table structure for article_cate
-- ----------------------------
DROP TABLE IF EXISTS `article_cate`;
CREATE TABLE `article_cate`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_delete` tinyint(1) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '0 未被删除 1被删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = '文章分类数据表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of article_cate
-- ----------------------------
INSERT INTO `article_cate` VALUES (1, '科技', 'keji', 0);
INSERT INTO `article_cate` VALUES (2, '教育', 'jiaoyu', 0);
INSERT INTO `article_cate` VALUES (3, '文化', 'wenhua', 1);

-- ----------------------------
-- Table structure for business
-- ----------------------------
DROP TABLE IF EXISTS `business`;
CREATE TABLE `business`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `contact` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `contact_phone` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `orderCount` int(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of business
-- ----------------------------
INSERT INTO `business` VALUES (1, '杭州金点子有限公司', '林先生', '13956563434', '浙江省杭州市临安区科创大厦', '1', 10);
INSERT INTO `business` VALUES (2, '思聪', 'Gert', '19858185202', '浙江省杭州市', '技术服务', 11);

-- ----------------------------
-- Table structure for dict
-- ----------------------------
DROP TABLE IF EXISTS `dict`;
CREATE TABLE `dict`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dict
-- ----------------------------
INSERT INTO `dict` VALUES (1, NULL);

-- ----------------------------
-- Table structure for form
-- ----------------------------
DROP TABLE IF EXISTS `form`;
CREATE TABLE `form`  (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `form_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `form_date` date NULL DEFAULT NULL,
  `form_json` json NULL,
  `form_temp_id` int(50) NULL DEFAULT NULL,
  `approval` int(10) NULL DEFAULT 0 COMMENT '审批 0：未审批；1：已审批',
  `commit` int(10) NULL DEFAULT 0 COMMENT '0: 未提交； 1：已提交',
  `release` int(10) NULL DEFAULT 0 COMMENT '0: 未发布；2：已发布',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of form
-- ----------------------------
INSERT INTO `form` VALUES (1, '设备流水', NULL, NULL, NULL, 0, 0, 0);

-- ----------------------------
-- Table structure for form_temp
-- ----------------------------
DROP TABLE IF EXISTS `form_temp`;
CREATE TABLE `form_temp`  (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `form_json` json NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of form_temp
-- ----------------------------
INSERT INTO `form_temp` VALUES (1, '设备', NULL);
INSERT INTO `form_temp` VALUES (2, '设备1', '{\"list\": [{\"key\": \"input_1651052163688\", \"help\": \"\", \"type\": \"input\", \"label\": \"订单号\", \"model\": \"input_1651052163688\", \"rules\": [{\"message\": \"必填项\", \"required\": false}], \"options\": {\"type\": \"text\", \"width\": \"100%\", \"hidden\": false, \"disabled\": false, \"clearable\": false, \"maxLength\": null, \"addonAfter\": \"\", \"addonBefore\": \"\", \"placeholder\": \"请输入\", \"defaultValue\": \"\"}}, {\"key\": \"textarea_1651052165210\", \"help\": \"\", \"type\": \"textarea\", \"label\": \"文本框\", \"model\": \"textarea_1651052165210\", \"rules\": [{\"message\": \"必填项\", \"required\": false}], \"options\": {\"width\": \"100%\", \"hidden\": false, \"maxRows\": 6, \"minRows\": 4, \"disabled\": false, \"clearable\": false, \"maxLength\": null, \"placeholder\": \"请输入\", \"defaultValue\": \"\"}}], \"config\": {\"layout\": \"horizontal\", \"labelCol\": {\"lg\": 4, \"md\": 4, \"sm\": 4, \"xl\": 4, \"xs\": 4, \"xxl\": 4}, \"labelWidth\": 100, \"wrapperCol\": {\"lg\": 18, \"md\": 18, \"sm\": 18, \"xl\": 18, \"xs\": 18, \"xxl\": 18}, \"customStyle\": \"\", \"labelLayout\": \"flex\", \"hideRequiredMark\": false}}');
INSERT INTO `form_temp` VALUES (4, '设备3', '{\"list\": [{\"key\": \"input_1651057815239\", \"help\": \"\", \"type\": \"input\", \"label\": \"输入框\", \"model\": \"input_1651057815239\", \"rules\": [{\"message\": \"必填项\", \"required\": false}], \"options\": {\"type\": \"text\", \"width\": \"100%\", \"hidden\": false, \"disabled\": false, \"clearable\": false, \"maxLength\": null, \"addonAfter\": \"\", \"addonBefore\": \"\", \"placeholder\": \"请输入\", \"defaultValue\": \"\"}}], \"config\": {\"layout\": \"horizontal\", \"labelCol\": {\"lg\": 4, \"md\": 4, \"sm\": 4, \"xl\": 4, \"xs\": 4, \"xxl\": 4}, \"labelWidth\": 100, \"wrapperCol\": {\"lg\": 18, \"md\": 18, \"sm\": 18, \"xl\": 18, \"xs\": 18, \"xxl\": 18}, \"customStyle\": \"\", \"labelLayout\": \"flex\", \"hideRequiredMark\": false}}');
INSERT INTO `form_temp` VALUES (5, '模板2', '{\"list\": [{\"key\": \"input_1651328555040\", \"help\": \"\", \"type\": \"input\", \"label\": \"输入框\", \"model\": \"input_1651328555040\", \"rules\": [{\"message\": \"必填项\", \"required\": false}], \"options\": {\"type\": \"text\", \"width\": \"100%\", \"hidden\": false, \"disabled\": false, \"clearable\": false, \"maxLength\": null, \"addonAfter\": \"\", \"addonBefore\": \"\", \"placeholder\": \"请输入\", \"defaultValue\": \"\"}}, {\"key\": \"input_1651328556741\", \"help\": \"\", \"type\": \"input\", \"label\": \"输入框\", \"model\": \"input_1651328556741\", \"rules\": [{\"message\": \"必填项\", \"required\": false}], \"options\": {\"type\": \"text\", \"width\": \"100%\", \"hidden\": false, \"disabled\": false, \"clearable\": false, \"maxLength\": null, \"addonAfter\": \"\", \"addonBefore\": \"\", \"placeholder\": \"请输入\", \"defaultValue\": \"\"}}, {\"key\": \"input_1651328555857\", \"help\": \"\", \"type\": \"input\", \"label\": \"输入框\", \"model\": \"input_1651328555857\", \"rules\": [{\"message\": \"必填项\", \"required\": false}], \"options\": {\"type\": \"text\", \"width\": \"100%\", \"hidden\": false, \"disabled\": false, \"clearable\": false, \"maxLength\": null, \"addonAfter\": \"\", \"addonBefore\": \"\", \"placeholder\": \"请输入\", \"defaultValue\": \"\"}}, {\"key\": \"input_1651328557757\", \"help\": \"\", \"type\": \"input\", \"label\": \"输入框\", \"model\": \"input_1651328557757\", \"rules\": [{\"message\": \"必填项\", \"required\": false}], \"options\": {\"type\": \"text\", \"width\": \"100%\", \"hidden\": false, \"disabled\": false, \"clearable\": false, \"maxLength\": null, \"addonAfter\": \"\", \"addonBefore\": \"\", \"placeholder\": \"请输入\", \"defaultValue\": \"\"}}, {\"key\": \"textarea_1651328559107\", \"help\": \"\", \"type\": \"textarea\", \"label\": \"文本框\", \"model\": \"textarea_1651328559107\", \"rules\": [{\"message\": \"必填项\", \"required\": false}], \"options\": {\"width\": \"100%\", \"hidden\": false, \"maxRows\": 6, \"minRows\": 4, \"disabled\": false, \"clearable\": false, \"maxLength\": null, \"placeholder\": \"请输入\", \"defaultValue\": \"\"}}, {\"key\": \"date_1651328560990\", \"help\": \"\", \"type\": \"date\", \"label\": \"日期选择框\", \"model\": \"date_1651328560990\", \"rules\": [{\"message\": \"必填项\", \"required\": false}], \"options\": {\"range\": false, \"width\": \"100%\", \"format\": \"YYYY-MM-DD\", \"hidden\": false, \"disabled\": false, \"showTime\": false, \"clearable\": false, \"placeholder\": \"请选择\", \"defaultValue\": \"\", \"rangePlaceholder\": [\"开始时间\", \"结束时间\"], \"rangeDefaultValue\": []}}], \"config\": {\"layout\": \"horizontal\", \"labelCol\": {\"lg\": 4, \"md\": 4, \"sm\": 4, \"xl\": 4, \"xs\": 4, \"xxl\": 4}, \"labelWidth\": 100, \"wrapperCol\": {\"lg\": 18, \"md\": 18, \"sm\": 18, \"xl\": 18, \"xs\": 18, \"xxl\": 18}, \"customStyle\": \"\", \"labelLayout\": \"flex\", \"hideRequiredMark\": false}}');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `parent_id` int(50) NULL DEFAULT 0,
  `enable` tinyint(1) NULL DEFAULT NULL COMMENT '是否启用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, '用户管理', '/user', 'el-icon-user-solid', 0, 1);
INSERT INTO `menu` VALUES (2, '角色管理', '/role', 'el-icon-s-check', 0, 1);
INSERT INTO `menu` VALUES (3, '权限管理', '/menu', 'el-icon-menu', 0, 0);
INSERT INTO `menu` VALUES (4, '模板管理', '/template', 'el-icon-s-tools', 0, 1);
INSERT INTO `menu` VALUES (5, '任务管理', '/task', 'el-icon-s-flag', 0, 1);
INSERT INTO `menu` VALUES (6, '字典管理', '/dict', 'el-icon-info', 0, 1);
INSERT INTO `menu` VALUES (7, '业务单位管理', '/business', 'el-icon-s-cooperation', 0, 1);

-- ----------------------------
-- Table structure for menu_role
-- ----------------------------
DROP TABLE IF EXISTS `menu_role`;
CREATE TABLE `menu_role`  (
  `id` int(50) NOT NULL,
  `menu_id` int(50) NULL DEFAULT NULL,
  `role_id` int(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `menu_id`(`menu_id`) USING BTREE,
  INDEX `menu_role_ibfk_2`(`role_id`) USING BTREE,
  CONSTRAINT `menu_role_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `menu_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu_role
-- ----------------------------
INSERT INTO `menu_role` VALUES (1, 1, 1);
INSERT INTO `menu_role` VALUES (2, 2, 1);
INSERT INTO `menu_role` VALUES (3, 3, 1);
INSERT INTO `menu_role` VALUES (4, 4, 1);
INSERT INTO `menu_role` VALUES (5, 5, 3);
INSERT INTO `menu_role` VALUES (6, 7, 1);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '管理员');
INSERT INTO `role` VALUES (2, '审批单位');
INSERT INTO `role` VALUES (3, '下属单位');

-- ----------------------------
-- Table structure for role_access
-- ----------------------------
DROP TABLE IF EXISTS `role_access`;
CREATE TABLE `role_access`  (
  `id` int(11) NOT NULL,
  `role_id` int(11) NULL DEFAULT NULL,
  `access_id` int(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `access_id`(`access_id`) USING BTREE,
  INDEX `role_access_ibfk_3`(`role_id`) USING BTREE,
  CONSTRAINT `role_access_ibfk_2` FOREIGN KEY (`access_id`) REFERENCES `access` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `role_access_ibfk_3` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_access
-- ----------------------------
INSERT INTO `role_access` VALUES (1, 1, 5);
INSERT INTO `role_access` VALUES (2, 1, 6);
INSERT INTO `role_access` VALUES (3, 2, 3);
INSERT INTO `role_access` VALUES (4, 2, 4);
INSERT INTO `role_access` VALUES (5, 3, 1);
INSERT INTO `role_access` VALUES (6, 3, 2);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `realName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `phone` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `user_picture` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'tyt', '123456', '童烨韬', 'tyt@gamil.com', '13946764452', '1', '22');
INSERT INTO `user` VALUES (40, 'asdf', '123123', '童烨韬', '601728814@qq.com', '13953534343', NULL, NULL);
INSERT INTO `user` VALUES (41, 'gert', '123123', '童烨韬', 'gertyt@foxmail.com', '13858185202', NULL, NULL);

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(255) NULL DEFAULT NULL,
  `role_id` int(11) NULL DEFAULT 3,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_role_ibfk_1`(`user_id`) USING BTREE,
  INDEX `user_role_ibfk_2`(`role_id`) USING BTREE,
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (44, 1, 3);
INSERT INTO `user_role` VALUES (45, 1, 2);
INSERT INTO `user_role` VALUES (47, 41, 1);
INSERT INTO `user_role` VALUES (50, 40, 2);
INSERT INTO `user_role` VALUES (51, 40, 3);
INSERT INTO `user_role` VALUES (52, 40, 1);

SET FOREIGN_KEY_CHECKS = 1;
